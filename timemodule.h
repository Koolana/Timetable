#ifndef TIMEMODULE_H
#define TIMEMODULE_H

#include <QObject>
#include <QDateTime>
#include <QTimer>

class TimeModule : public QObject
{
    Q_OBJECT
public:
    explicit TimeModule(QObject *parent = nullptr);
    void init();
    static int getCurrentWeekType(QDateTime nowDate);

private:
    QTimer *tmr;
    int dayNumber;
    int weekType;
    QDateTime nowDate;

signals:
    void sendCurrentTimeToQml(QString time);
    void sendDayAndWeekTypeToQml(QString day, QString weekType, QString date);
    void sendFirstInitToQml(bool isCh, int indexTodayDay);

    void setTimeFilter(int day, int weekType);
//    void setCurrentLesson();

public slots:
    void nextDay();
    void prevDay();
    void setDay(int dayChZn);

private slots:
    void updateTime();

};

#endif // TIMEMODULE_H
