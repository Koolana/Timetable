#ifndef LESSONWINDOW_H
#define LESSONWINDOW_H

#include <QWidget>
#include "timetabledata.h"

class LessonWindow : public QWidget
{
    Q_OBJECT
public:
    explicit LessonWindow(Lesson* less, QWidget *parent = nullptr);

signals:

public slots:
};

#endif // LESSONWINDOW_H
