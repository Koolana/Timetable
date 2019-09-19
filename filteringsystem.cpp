#include "filteringsystem.h"

FilteringSystem::FilteringSystem(QList<DayData*> inputWeek, QObject *parent) : QObject(parent)
{
    week = inputWeek;
}

void FilteringSystem::init()
{
    for(auto day: week)
    {
        if(day->name == "СР")
        {
            for(auto lesson: day->lessons)
            {
                if(lesson->NumeratorDenumerataor != 1)
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
    }
}
