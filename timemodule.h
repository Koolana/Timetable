#ifndef TIMEMODULE_H
#define TIMEMODULE_H

#include <QObject>
#include <QTimer>

class TimeModule : public QObject
{
    Q_OBJECT
public:
    explicit TimeModule(QObject *parent = nullptr);
    void init();

private:
    QTimer *tmr;
    int dayNumber;
    int weekType;

signals:
    void sendCurrentTimeToQml(QString time);
    void sendDayAndWeekTypeToQml(QString day, QString weekType);

    void setTimeFilter(int day, int weekType);
    void setCurrentLesson();

public slots:
    void nextDay();
    void prevDay();

private slots:
    void updateTime();

};

#endif // TIMEMODULE_H
