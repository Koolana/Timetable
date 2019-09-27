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
    bool isCurrentLesson(Lesson* less);
    bool isCurrentLesson(Lesson* less, int numDay);

signals:
    void sendOneLessonToQml(QString time, QString type, QString name, QString cab, QString lecturer, bool isCur);
    void sendCurrentLessonToQml(int num);
    //void sendAllWeekDataToQml(QList<QVariant>);
    void finishSendDay();
    void setDayByNum(int num);

public slots:
    void setTimeFilter(int day, int weekType);
    void createDay(int day, int weekType);
    void sendDayFilterDataToQml();
    void setCurrentWeek();
//    void setCurrentLesson();

private:
    QList<DayData*> week;
    QList<DayData*> filteringWeek;

    bool isCurrentDay;
};

#endif // FILTERINGSYSTEM_H
