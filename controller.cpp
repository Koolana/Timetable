#include "controller.h"

#include "QDebug"
#include <QTemporaryFile>
#include <QSqlError>

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
            stream << tmpFile.readAll();
        }

        stream.flush();
        tmpFile.seek(0);

        tmpFile.close();
        file.close();
    }

    //Подключаем базу данных
    QSqlDatabase db;
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(tmpFile.fileName());//открываем временный файл sql, при закрытии приложения он удаляется
    db.open();
}

void Controller::init(){
    setWeekToQml(QDate::currentDate());

//    emit sendClearAllToQml();
//    QList<QDate> tmp;
//    tmp.append(QDate::currentDate());
//    tmp.append(QDate::currentDate());
//    sendDateListToQml(tmp);
//    emit sendDayNumberToQml(1);
}

void Controller::setWeekToQml(QDate date){
    emit sendClearAllToQml();

    QList<QDate> listDate = getDateWeekList(date);
    sendDateListToQml(listDate);
    QList<DayData*> listDays = getDaysListWithFilter(getCurrentWeekType(date));
    listDays = getDaysListWithLabWorks(listDays, listDate);

    //emit sendWeekTypeToQml(!getCurrentWeekType(date));

    sendDaysListToQml(listDays);
    emit sendDayNumberToQml(QDateTime::currentDateTime().date().dayOfWeek() == 7 ? QDateTime::currentDateTime().addDays(1).date().dayOfWeek() - 1 : QDateTime::currentDateTime().date().dayOfWeek() - 1);
}

QList<LabWork*> Controller::getLabWorksByDate(QDate date)
{
    QList<LabWork*> tmp;
    tmp.clear();

    //Осуществляем запрос
    QSqlQuery query;
    //qDebug() << QString::number(date.month());
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
        //qDebug() << listLab.count();

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

QList<QDate> Controller::getDateWeekList(QDate date){
    QDate tmp = date;
    QList<QDate> listDate;
    listDate.clear();

    if( date.dayOfWeek() == 7)
    {
        tmp = date.addDays(1);
    }

    for (int i = tmp.dayOfWeek() - 1; i > tmp.dayOfWeek() - 7; i--)
    {
        listDate.append(tmp.addDays(-i));
        //emit sendDateToQml(tmp.date().addDays(-i).toString("dd.MM.yy"));
        //qDebug() << i;
    }

    return listDate;
}

void Controller::sendDateListToQml(QList<QDate> dates){//добавить отправления полного и короткого названия дня по датам
    for (auto date : dates){
        QString dateLongName = QDate::longDayName(date.dayOfWeek());
        dateLongName[0] = dateLongName[0].toUpper();

        emit sendDateToQml(date.toString("dd.MM.yy"), dateLongName, QDate::shortDayName(date.dayOfWeek()).toUpper(), (bool)getCurrentWeekType(date));
    }
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

int Controller::getCurrentWeekType(QDate nowInDate){
    QDate firstDate = QDate(nowInDate.year(), 9, 2);//когда начался первый числитель, глобальное значение, вынести в define
    QDate tmp = nowInDate;

    if(tmp.dayOfWeek() > 6){
        tmp = tmp.addDays(1);
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
                Lesson* les =  new Lesson(*lesson);
                newDay->lessons.append(les);
            }
        }

        tmp.append(newDay);
    }

    return tmp;
}
