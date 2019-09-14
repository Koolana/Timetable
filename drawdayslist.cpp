#include "drawdayslist.h"

#include <QBoxLayout>
#include <QDebug>

DrawDaysList::DrawDaysList(QList<DayData> *week, QWidget* parent)
    : QWidget(parent)
{
    QVBoxLayout* gLayout = new QVBoxLayout;

    QHBoxLayout* layout = new QHBoxLayout;

    bool flag = true;

    for(auto day: *week){
        QPushButton* but = new QPushButton(day.name);
        but->setMinimumHeight(100);
        DrawClassesList* classesList = new DrawClassesList(&day.doubleClasses);

        connect(but, SIGNAL(clicked()), this, SLOT(clickManager()));
        connect(but, SIGNAL(clicked()), classesList, SLOT(hideOrShow()));

        if(flag)
        {
            classesList->hideOrShow();
            flag = !flag;
        }

        listBut.append(but);
        listClassList.append(classesList);
        layout->addWidget(but);

        gLayout->addWidget(classesList);
    }

    gLayout->addLayout(layout);
    setLayout(gLayout);

    QMargins m = gLayout->contentsMargins(); //убирает пустое пространство около родителя
    m.setLeft(0);
    m.setRight(0);
    m.setTop(0);
    m.setBottom(0);
    gLayout->setContentsMargins(m);
}

void DrawDaysList::clickManager()
{
    for(auto classesList: listClassList){
        if(classesList->isVisible())
        {
            classesList->setVisible(false);
        }
        //qDebug() << classesList->isVisible();
    }
}
