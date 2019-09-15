#ifndef DAYWINDOW_H
#define DAYWINDOW_H

#include <QWidget>
#include <QBoxLayout>
#include <timetabledata.h>

#include "lessonwindow.h"

class DayWindow : public QWidget
{
    Q_OBJECT
public:
    explicit DayWindow(DayData* day, QDateTime nowDate, QWidget *parent = nullptr);

private:
    QList<LessonWindow*> listLessonWindow;

signals:

public slots:
};

#endif // DAYWINDOW_H
