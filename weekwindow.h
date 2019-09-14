#ifndef WEEKWINDOW_H
#define WEEKWINDOW_H

#include <QWidget>
#include "timetabledata.h"

class DayWindow;

class WeekWindow : public QWidget
{
    Q_OBJECT
public:
    explicit WeekWindow(QList<DayData*> week, QWidget *parent = nullptr);

private:
    int curIdDay;
    QList<DayWindow*> listDays;

signals:

public slots:
    void changeById(int id);
};

#endif // WEEKWINDOW_H
