#include "controller.h"

#include "QDebug"

Controller::Controller(QList<DayData*> inputWeek, QObject *parent) : QObject(parent)
{
    allWeekData = inputWeek;

    labList.append(new LabWork({QDate(2019, 9, 13),
                                new QTime(8, 30),
                                new QTime(10, 5),
                                QString("Нейронные сети"),
                                QString("517м"),
                                QString("Имя Преп.")}));

    labList.append(new LabWork({QDate(2019, 9, 21),
                                new QTime(10, 15),
                                new QTime(15, 25),
                                QString("Статрадиотехника"),
                                QString("517м"),
                                QString("Имя Преп.")}));

    labList.append(new LabWork({QDate(2019, 9, 27),
                                new QTime(8, 30),
                                new QTime(10, 5),
                                QString("Нейронные сети"),
                                QString("517м"),
                                QString("Имя Преп.")}));

    labList.append(new LabWork({QDate(2019, 9, 28),
                                new QTime(10, 15),
                                new QTime(15, 25),
                                QString("Теория обработки информации (ТОИ)"),
                                QString("517м"),
                                QString("Имя Преп.")}));

    labList.append(new LabWork({QDate(2019, 10, 5),
                                new QTime(8, 30),
                                new QTime(15, 25),
                                QString("ТиССУТС"),
                                QString("1б"),
                                QString("Имя Преп.")}));

    labList.append(new LabWork({QDate(2019, 10, 11),
                                new QTime(8, 30),
                                new QTime(10, 5),
                                QString("Нейронные сети"),
                                QString("517м"),
                                QString("Имя Преп.")}));

    labList.append(new LabWork({QDate(2019, 10, 12),
                                new QTime(8, 30),
                                new QTime(19, 00),
                                QString("ТиССУТС"),
                                QString("1б"),
                                QString("Имя Преп.")}));
    //qDebug() << labList.at(0)->date.toString();
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

    for(auto oneLab: labList){
        if(!oneLab->date.daysTo(date))
        {
            tmp.append(oneLab);
        }
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
