#ifndef DRAWDAYSLIST_H
#define DRAWDAYSLIST_H

#include <QWidget>
#include <QGroupBox>
#include <QPushButton>
#include <weekanddaydata.h>

#include "drawclasseslist.h"

class DrawDaysList : public QWidget
{
    Q_OBJECT
public:
    DrawDaysList(QList<DayData> *week, QWidget *parent = 0);

private:
    QList<QPushButton*> listBut;
    QList<DrawClassesList*> listClassList;

public slots:
    void clickManager();
};

#endif // DRAWDAYSLIST_H
