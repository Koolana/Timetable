#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "timetabledata.h"

#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QList<DayData*> inputWeek, QObject *parent = nullptr);

    void init();

    static int getCurrentWeekType(QDate nowInDate);
    QList<DayData*> getDaysListWithFilter(int weekType);
    QList<QDate> getDateWeekList(QDate date);
    QList<LabWork*> getLabWorksByDate(QDate date);
    QList<DayData*> getDaysListWithLabWorks(QList<DayData*> listDays, QList<QDate> listDate);

    void sendDaysListToQml(QList<DayData*>);
    void sendDateListToQml(QList<QDate> dates);

    bool isCurrentLesson(Lesson* less);

    void setWeekToQml(QDate date);

signals:
    void sendOneLessonToQml(QString time, QString type, QString name, QString cab, QString lecturer);
    void finishSendDayToQml();
    void sendDayNumberToQml(int num);
    void sendDateToQml(QString date, QString dateLongName, QString dateShortName, bool isCh);
    void sendWeekTypeToQml(bool isCh);
    void sendClearAllToQml();

public slots:

private:
    QList<DayData*> allWeekData;
    //QList<DayData*> outputWeekData;
};

#endif // CONTROLLER_H
