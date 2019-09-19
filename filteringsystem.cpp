#include "filteringsystem.h"

#include <QDebug>
#include <QDateTime>

FilteringSystem::FilteringSystem(QList<DayData*> inputWeek, QObject *parent) : QObject(parent)
{
    week = inputWeek;
    filteringWeek.clear();
}

void FilteringSystem::init()
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
                                    lesson->lessonLecturer);

        }
    }
}

void FilteringSystem::setTimeFilter(int day, int weekType)
{
    filteringWeek.clear();

    DayData* newDay = new DayData;
    for(auto lesson: week.at(day - 1)->lessons)
    {
        if(lesson->NumeratorDenumerataor == weekType || lesson->NumeratorDenumerataor == 2){
            newDay->lessons.append(lesson);
        }
    }

    filteringWeek.append(newDay);
    //qDebug() << filteringWeek.at(0)->lessons.at(0)->timeStart->hour();
    init();
}

void FilteringSystem::setCurrentLesson()
{
    for(auto day: filteringWeek)
    {
        for(int i = 0; i < day->lessons.count(); i++)
        {
            if(QDateTime::currentDateTime().time() > *day->lessons.at(i)->timeStart && QDateTime::currentDateTime().time() < *day->lessons.at(i)->timeEnd)//убрать выделение если не текущий день
            {
                emit sendCurrentLessonToQml(i);
                break;
            }
        }
    }
}
