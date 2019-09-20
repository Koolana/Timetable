#include "timemodule.h"

#include <QDateTime>
#include <QDebug>

TimeModule::TimeModule(QObject *parent) : QObject(parent)
{
    tmr = new QTimer();
    tmr->setInterval(1000);
    connect(tmr, SIGNAL(timeout()), this, SLOT(updateTime()));
    tmr->start();
}

void TimeModule::updateTime(){
    emit sendCurrentTimeToQml(QString::number(QDateTime::currentDateTime().time().hour()) + ":" +
                             (QDateTime::currentDateTime().time().minute() < 10 ? "0" + QString::number(QDateTime::currentDateTime().time().minute()) : QString::number(QDateTime::currentDateTime().time().minute())));
//    emit setCurrentLesson();//не мгновенное отображение текущей пары
}

void TimeModule::init()
{
    QDateTime nowDate = QDateTime::currentDateTime();

    dayNumber = nowDate.date().dayOfWeek();
    weekType = getCurrentWeekType(nowDate);

    QString dayName = QDateTime::currentDateTime().date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС");
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);

    updateTime();
}

void TimeModule::nextDay()
{
    if(dayNumber < 6){
        dayNumber++;
    }else{
        dayNumber = 1;

        if(weekType == 0){
            weekType = 1;
        }else
        {
            weekType = 0;
        }
    }

    QString dayName = QDateTime::currentDateTime().date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС");
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);
}

void TimeModule::prevDay()
{
    if(dayNumber > 1){
        dayNumber--;
    }else{
        dayNumber = 6;

        if(weekType == 0){
            weekType = 1;
        }else
        {
            weekType = 0;
        }
    }

    QString dayName = QDateTime::currentDateTime().date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС");
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);
}

int TimeModule::getCurrentWeekType(QDateTime nowDate){
    QDateTime firstDate = QDateTime(QDate(nowDate.date().year(), 9, 2));//когда начался первый числитель, глобальное значение, вынести в define
    return firstDate.daysTo(nowDate) / 7 % 2 ? 1 : 0;
}

