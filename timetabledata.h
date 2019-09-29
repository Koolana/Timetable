#ifndef WEEKANDDAYDATA_H
#define WEEKANDDAYDATA_H

#include <QWidget>
#include <QString>
#include <QTime>

struct LabWork{
    QDate date;
    QTime* timeStart;
    QTime* timeEnd;

    QString lessonName;
    QString lessonCab;
    QString lessonLecturer;
};

struct Lesson{
    int NumeratorDenumerataor;
    QTime* timeStart;
    QTime* timeEnd;

    QString lessonType;
    QString lessonName;
    QString lessonCab;
    QString lessonLecturer;
};

struct DayData{
    QString name;
    QList<Lesson*> lessons;
};

#endif // WEEKANDDAYDATA_H
