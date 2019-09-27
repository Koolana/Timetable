#include "filteringsystem.h"
#include "timemodule.h"

#include <QDebug>
#include <QDateTime>

FilteringSystem::FilteringSystem(QList<DayData*> inputWeek, QObject *parent) : QObject(parent)
{
    week = inputWeek;
    filteringWeek.clear();
}

void FilteringSystem::init()
{
    setCurrentWeek();
}

void FilteringSystem::sendDayFilterDataToQml()
{
    for(auto day: filteringWeek)
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
                                    lesson->lessonLecturer,
                                    isCurrentDay? isCurrentLesson(lesson) : false);

        }

        emit finishSendDay();
    }
}

void FilteringSystem::setCurrentWeek()
{
    for(int i = 0; i < 12; i++)
    {
        createDay(i % 6 + 1, i / 6);
    }
}

void FilteringSystem::createDay(int day, int weekType)
{
    filteringWeek.clear();

    isCurrentDay = (day == QDateTime::currentDateTime().date().dayOfWeek() && weekType == TimeModule::getCurrentWeekType(QDateTime::currentDateTime()));

    DayData* newDay = new DayData;

    for(auto lesson: week.at(day - 1)->lessons)
    {
        if(lesson->NumeratorDenumerataor == weekType || lesson->NumeratorDenumerataor == 2){
            newDay->lessons.append(lesson);
        }
    }

    filteringWeek.append(newDay);
    //qDebug() << filteringWeek.at(0)->lessons.at(0)->timeStart->hour();
    sendDayFilterDataToQml();
}

void FilteringSystem::setTimeFilter(int day, int weekType)
{
    emit setDayByNum(day - 1/* + weekType * 6*/);
}

//void FilteringSystem::setCurrentLesson()
//{
//    for(auto day: filteringWeek)
//    {
//        for(int i = 0; i < day->lessons.count(); i++)
//        {
//            if(isCurrentLesson(day->lessons.at(i)))
//            {
//                emit sendCurrentLessonToQml(i);
//                break;
//            }
//        }
//    }
//}

bool FilteringSystem::isCurrentLesson(Lesson* less){
    if(QDateTime::currentDateTime().time() > *less->timeStart && QDateTime::currentDateTime().time() < *less->timeEnd)//убрать выделение если не текущий день
    {
        return true;
    }

    return false;
}

bool FilteringSystem::isCurrentLesson(Lesson* less, int numDay){
    qDebug() << numDay << " " << QDateTime::currentDateTime().date().dayOfWeek();
    if(QDateTime::currentDateTime().time() > *less->timeStart && QDateTime::currentDateTime().time() < *less->timeEnd && numDay == QDateTime::currentDateTime().date().dayOfWeek())//убрать выделение если не текущий день
    {
        return true;
    }

    return false;
}
