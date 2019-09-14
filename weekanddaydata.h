#ifndef WEEKANDDAYDATA_H
#define WEEKANDDAYDATA_H

#include <QWidget>
#include <QString>

struct DoubleClass{
    int NumeratorDenumerataor;
    QString time;

    QString classType;
    QString className;
    QString classCab;
    QString classLecturer;
};

struct DayData{
    QString name;
    QList<DoubleClass> doubleClasses;
};

#endif // WEEKANDDAYDATA_H
