#include "lessonwindow.h"

#include <QLabel>
#include <QStyle>
#include <QBoxLayout>

LessonWindow::LessonWindow(Lesson* less, QWidget *parent) : QWidget(parent)
{
    QHBoxLayout* gLayout = new QHBoxLayout;

    QVBoxLayout* timeLayout = new QVBoxLayout;
    QLabel* tStart = new QLabel(QString::number(less->timeStart->hour()) + ":" +
                             (less->timeStart->minute() < 10 ? "0" + QString::number(less->timeStart->minute()) : QString::number(less->timeStart->minute())));
    QLabel* tEnd = new QLabel(QString::number(less->timeEnd->hour()) + ":" +
                              (less->timeEnd->minute() < 10 ? "0" + QString::number(less->timeEnd->minute()) : QString::number(less->timeEnd->minute())));
    timeLayout->addWidget(tStart);
    timeLayout->addWidget(tEnd);
    gLayout->addLayout(timeLayout);

    QLabel* typeLess = new QLabel(less->lessonType);
    gLayout->addWidget(typeLess, 1, Qt::AlignLeft);

    QLabel* nameLass = new QLabel(less->lessonName);
    nameLass->setWordWrap(true);
    nameLass->setAlignment(Qt::AlignCenter);
    gLayout->addWidget(nameLass, 5, Qt::AlignHCenter);

    QLabel* cabLess = new QLabel(less->lessonCab);
    gLayout->addWidget(cabLess, 1, Qt::AlignRight);

    setStyleSheet(QString::fromUtf8("border: 2px solid black;"));//отобразить контур

    QMargins m = gLayout->contentsMargins(); //убирает пустое пространство между родителем
    m.setLeft(0);
    m.setRight(0);
    m.setTop(0);
    m.setBottom(0);
    gLayout->setSpacing(0);
    gLayout->setContentsMargins(m);

    setLayout(gLayout);
}
