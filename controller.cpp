#include "controller.h"

#include "QDebug"
#include <QTemporaryFile>

Controller::Controller(QList<DayData*> inputWeek, QObject *parent) : QObject(parent)
{
    allWeekData = inputWeek;

    QTemporaryFile tmpFile;//временный файл sql для милого андройда т.к sqlite не поддерживает пакеты ресурсов qt
    tmpFile.setFileTemplate("XXXXXX");
    if (tmpFile.open()) {
        QString tmp_filename=tmpFile.fileName();
        qDebug() << "temporary" << tmp_filename;

        QTextStream stream(&tmpFile);

        QFile file(":/LabBase");
        if (file.open(QIODevice::ReadOnly)) {
            tmpFile.write(file.readAll());
            //tmpFile.write("123");
            stream << tmpFile.readAll();
        }

        stream.flush();
        tmpFile.seek(0);

        tmpFile.close();
    }

    //Подключаем базу данных
    QSqlDatabase db;
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(tmpFile.fileName());
    db.open();
}

void Controller::init(){
    setWeekToQml(QDateTime::currentDateTime());
}

void Controller::setWeekToQml(QDateTime date){
    QList<QDate> listDate = getDateWeekListToQml(date);
    QList<DayData*> listDays = getDaysListWithFilter(getCurrentWeekType(date));
    listDays = getDaysListWithLabWorks(listDays, listDate);

    emit sendWeekTypeToQml(!getCurrentWeekType(date));

    sendDaysListToQml(listDays);
    emit sendDayNumberToQml(QDateTime::currentDateTime().date().dayOfWeek() == 7 ? QDateTime::currentDateTime().addDays(1).date().dayOfWeek() - 1 : QDateTime::currentDateTime().date().dayOfWeek() - 1);
}

QList<LabWork*> Controller::getLabWorksByDate(QDate date)
{
    QList<LabWork*> tmp;
    tmp.clear();

    //Осуществляем запрос
    QSqlQuery query;
    query.exec("SELECT * FROM `LabWorks` WHERE `Month` = '" + QString::number(date.month()) + "' AND `Day` = '" + QString::number(date.day()) + "'");

    //Выводим значения из запроса
    while (query.next())
    {
        tmp.append(new LabWork({date,
                                new QTime(query.value(5).toInt(), query.value(6).toInt()),
                                new QTime(query.value(7).toInt(), query.value(8).toInt()),
                                query.value(9).toString(),
                                query.value(11).toString(),
                                query.value(10).toString()}));
    }

    return tmp;
}

QList<DayData*> Controller::getDaysListWithLabWorks(QList<DayData*> listDays, QList<QDate> listDate)
{
    for(int i = 0; i < listDays.count(); i++)
    {
        QList<LabWork*> listLab  = getLabWorksByDate(listDate.at(i));

        for(auto oneLab: listLab){
            bool flag = false;

            for(auto lesson: listDays.at(i)->lessons){
                //qDebug() << (oneLab->timeStart->secsTo(*lesson->timeStart) <= 0) << (oneLab->timeEnd->secsTo(*lesson->timeEnd) >= 0);
                if ((oneLab->timeStart->secsTo(*lesson->timeStart) <= 0) && (oneLab->timeStart->secsTo(*lesson->timeEnd) >= 0)){
                    flag = true;
                }

                if(flag)
                {
                    lesson->lessonName = oneLab->lessonName;
                    lesson->lessonType = QString("(лаб)");
                    lesson->lessonCab = oneLab->lessonCab;
                    lesson->lessonLecturer = oneLab->lessonLecturer;
                }

                if((oneLab->timeEnd->secsTo(*lesson->timeStart) <= 0) && (oneLab->timeEnd->secsTo(*lesson->timeEnd) >= 0)){
                    flag = false;
                }
            }
        }
    }

    return listDays;
}

QList<QDate> Controller::getDateWeekListToQml(QDateTime date){
    QDateTime tmp = date;
    QList<QDate> listDate;
    listDate.clear();

    if( date.date().dayOfWeek() == 7)
    {
        tmp = date.addDays(1);
    }

    for (int i = tmp.date().dayOfWeek() - 1; i > tmp.date().dayOfWeek() - 7; i--)
    {
        listDate.append(tmp.date().addDays(-i));
        emit sendDateToQml(tmp.date().addDays(-i).toString("dd.MM.yy"));
        //qDebug() << i;
    }

    return listDate;
}

void Controller::sendDaysListToQml(QList<DayData*> tmp){
    for(auto day: tmp)
    {
        for(auto lesson: day->lessons)
        {
            emit sendOneLessonToQml(QString::number(lesson->timeStart->hour()) + ":" +
                                    (lesson->timeStart->minute() < 10 ? "0" + QString::number(lesson->timeStart->minute()) : QString::number(lesson->timeStart->minute())) + "\n" +
                                    QString::number(lesson->timeEnd->hour()) + ":" +
                                    (lesson->timeEnd->minute() < 10 ? "0" + QString::number(lesson->timeEnd->minute()) : QString::number(lesson->timeEnd->minute())),
                                    lesson->lessonType,
                                    lesson->lessonName,
                                    lesson->lessonCab,
                                    lesson->lessonLecturer);
        }

        emit finishSendDayToQml();
    }
}

int Controller::getCurrentWeekType(QDateTime nowInDate){
    QDateTime firstDate = QDateTime(QDate(nowInDate.date().year(), 9, 2));//когда начался первый числитель, глобальное значение, вынести в define
    QDateTime tmp = nowInDate;

    if(tmp.date().dayOfWeek() > 6){
        tmp = QDateTime(tmp.date().addDays(1));
    }

    return firstDate.daysTo(tmp) / 7 % 2 ? 1 : 0;
}

QList<DayData*> Controller::getDaysListWithFilter (int weekType){
    QList<DayData*> tmp;
    tmp.clear();

    for (auto day : allWeekData)
    {
        DayData* newDay = new DayData;
        newDay->name = day->name;

        for (auto lesson: day->lessons)
        {
            if (lesson->NumeratorDenumerataor == weekType || lesson->NumeratorDenumerataor == 2){
                newDay->lessons.append(lesson);
            }
        }

        tmp.append(newDay);
    }

    return tmp;
}
