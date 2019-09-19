#ifndef FILTERINGSYSTEM_H
#define FILTERINGSYSTEM_H

#include <QObject>
#include "timetabledata.h"

class FilteringSystem : public QObject
{
    Q_OBJECT
public:
    explicit FilteringSystem(QList<DayData*> inputWeek, QObject *parent = nullptr);
    void init();

signals:
    void sendOneLessonToQml(QString time, QString type, QString name, QString cab, QString lecturer);

public slots:
    void setTimeFilter(int day, int weekType);

private:
    QList<DayData*> week;
    QList<DayData*> filteringWeek;
};

#endif // FILTERINGSYSTEM_H
