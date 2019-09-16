#include "weekwindow.h"

#include <QDebug>

#include <QBoxLayout>
#include <QPushButton>
#include <QLabel>

#include "daywindow.h"

WeekWindow::WeekWindow(QList<DayData*> week, QWidget *parent) : QWidget(parent)
{
    gLayout = new QVBoxLayout;
    gLayout->setSpacing(0);

    QDateTime dt = QDateTime::currentDateTime();
    QDateTime firstDate = QDateTime(QDate(dt.date().year(), 9, 2));//когда начался первый числитель, глобальное значение, вынести в define
    //qDebug() << firstDate.daysTo(dt);
    //qDebug() << dt.date().day();
    QLabel* today = new QLabel(QString::number(dt.date().day()) + " " +
                               QString::number(dt.date().month()) + " " +
                               QString::number(dt.time().hour()) + " " +
                               QString::number(dt.time().minute()));
    //today->setSizePolicy(QSizePolicy::Minimum, QSizePolicy::Minimum);
    today->setFrameShape(QFrame::StyledPanel);
    today->setLineWidth(3);
    if(firstDate.daysTo(dt) / 7 % 2 == 0)
    {
        today->setText(today->text() + " ЧС");
    }else
    {
        today->setText(today->text() + " ЗН");
    }
    gLayout->addWidget(today, 0, Qt::AlignTop);

    QHBoxLayout* butLayout = new QHBoxLayout;

    int i = 0;

    for (auto day : week)
    {
        CustomButton* but = new CustomButton(i, day->name);
        but->unPressed();

        DayWindow* dw = new DayWindow(day, dt);
        dw->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

        connect(but, SIGNAL(clickWithId(int)), SLOT(changeById(int)));
        listBut.append(but);
        listDays.append(dw);

        butLayout->addWidget(but, 0, Qt::AlignBottom);
        gLayout->addWidget(dw, 1);
        //qDebug() << day->name;
        i++;
    }

    QMargins m = butLayout->contentsMargins(); //убирает пустое пространство между родителем
    m.setLeft(0);
    m.setRight(0);
    m.setTop(0);
    m.setBottom(0);
    butLayout->setSpacing(0);
    butLayout->setContentsMargins(m);
    gLayout->addLayout(butLayout);

    QMargins tmp = gLayout->contentsMargins(); //убирает пустое пространство между родителем
    m.setLeft(0);
    m.setRight(0);
    m.setTop(0);
    m.setBottom(0);
    gLayout->setSpacing(0);
    gLayout->setContentsMargins(m);

    setLayout(gLayout);

    curIdDay = 0;
    listBut.at(curIdDay)->clicked();
    //listDays.at(curIdDay)->setVisible(true);
}

void WeekWindow::changeById(int id)
{
    listBut.at(curIdDay)->unPressed();
    listDays.at(curIdDay)->setVisible(false);
    curIdDay = id;
    listDays.at(curIdDay)->setVisible(true);
}
