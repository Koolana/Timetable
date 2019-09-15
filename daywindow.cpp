#include "daywindow.h"

#include <QDebug>
#include <QLabel>

DayWindow::DayWindow(DayData* day, QDateTime nowDate, QWidget *parent) : QWidget(parent)
{
    QDateTime firstDate = QDateTime(QDate(nowDate.date().year(), 9, 2));//когда начался первый числитель, глобальное значение, вынести в define
    QVBoxLayout* gLayout = new QVBoxLayout;

    for (auto lesson : day->lessons)
    {
        //qDebug() << firstDate.daysTo(nowDate) / 7 % 2 << " ? " << lesson->NumeratorDenumerataor;
        if(firstDate.daysTo(nowDate) / 7 % 2 == lesson->NumeratorDenumerataor || lesson->NumeratorDenumerataor == 2)
        {
            LessonWindow* lw = new LessonWindow(lesson);
            listLessonWindow.append(lw);

            gLayout->addWidget(lw);
        }
    }

    QMargins m = gLayout->contentsMargins(); //убирает пустое пространство между родителем
    m.setLeft(0);
    m.setRight(0);
    m.setTop(0);
    m.setBottom(0);
    //gLayout->setSpacing(20);
    gLayout->setContentsMargins(m);

    setStyleSheet(QString::fromUtf8("border: 2px solid black;"));//отобразить контур

    setLayout(gLayout);
    setVisible(false);
}
