#include "timemodule.h"

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
    nowDate = QDateTime::currentDateTime();

    dayNumber = nowDate.date().dayOfWeek();

    //если воскресенье
    if(dayNumber > 6){
        dayNumber = 1;
        nowDate = QDateTime(nowDate.date().addDays(1));
    }

    weekType = getCurrentWeekType(nowDate);

    QString dayName = nowDate.date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС", nowDate.date().toString("dd.MM.yy"));
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);
    emit sendFirstInitToQml(!weekType);

    updateTime();
}

void TimeModule::nextDay()
{
    if(dayNumber < 6){
        dayNumber++;
        nowDate = QDateTime(nowDate.date().addDays(1));
    }else{
        dayNumber = 1;
        nowDate = QDateTime(nowDate.date().addDays(2));
    }

    weekType = getCurrentWeekType(nowDate);

    QString dayName = nowDate.date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС", nowDate.date().toString("dd.MM.yy"));
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);
}

void TimeModule::prevDay()
{
    if(dayNumber > 1){
        dayNumber--;
        nowDate = QDateTime(nowDate.date().addDays(-1));
    }else{
        dayNumber = 6;
        nowDate = QDateTime(nowDate.date().addDays(-2));
    }

    weekType = getCurrentWeekType(nowDate);

    QString dayName = nowDate.date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС", nowDate.date().toString("dd.MM.yy"));
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);
}

int TimeModule::getCurrentWeekType(QDateTime nowInDate){
    QDateTime firstDate = QDateTime(QDate(nowInDate.date().year(), 9, 2));//когда начался первый числитель, глобальное значение, вынести в define
    QDateTime tmp = nowInDate;

    if(tmp.date().dayOfWeek() > 6){
        tmp = QDateTime(tmp.date().addDays(1));
    }

    return firstDate.daysTo(tmp) / 7 % 2 ? 1 : 0;
}

//установить дату из выпадающего меню
//работает
void TimeModule::setDay(int dayChZn)
{
    int timeOffset = dayChZn - (dayNumber - 1) - abs(getCurrentWeekType(QDateTime::currentDateTime()) - weekType) * 7;
    nowDate = QDateTime(nowDate.date().addDays(timeOffset));

    dayNumber = nowDate.date().dayOfWeek();

    if(dayNumber > 6){
        nowDate = QDateTime(nowDate.date().addDays(1));
        dayNumber = nowDate.date().dayOfWeek();
    }

    weekType = getCurrentWeekType(nowDate);

    QString dayName = nowDate.date().longDayName(dayNumber);//повтор
    dayName[0] = dayName[0].toUpper();//повтор

    emit sendDayAndWeekTypeToQml(dayName, weekType ? "ЗН" : "ЧС", nowDate.date().toString("dd.MM.yy"));
    emit setTimeFilter(dayNumber, weekType ? 1 : 0);
}

