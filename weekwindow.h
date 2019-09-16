#ifndef WEEKWINDOW_H
#define WEEKWINDOW_H

#include <QWidget>
#include <QBoxLayout>
#include "custombutton.h"
#include "timetabledata.h"

class DayWindow;

class WeekWindow : public QWidget
{
    Q_OBJECT
public:
    explicit WeekWindow(QList<DayData*> week, QWidget *parent = nullptr);

private:
    QVBoxLayout* gLayout;

    int curIdDay;
    QList<DayWindow*> listDays;
    QList<CustomButton*> listBut;

signals:

public slots:
    void changeById(int id);
};

#endif // WEEKWINDOW_H
