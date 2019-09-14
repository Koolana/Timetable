#include "drawclass.h"

#include <QBoxLayout>
#include <QLabel>

drawClass::drawClass(DoubleClass *oneClass, QGroupBox *parent) : QGroupBox(parent)
{
    QHBoxLayout* layout = new QHBoxLayout;

    QLabel* lab1 = new QLabel(oneClass->time);
    layout->addWidget(lab1);

    QLabel* lab3 = new QLabel(oneClass->classType + oneClass->className);
    layout->addWidget(lab3);

    QLabel* lab5 = new QLabel(oneClass->classLecturer);
    layout->addWidget(lab5);

    QLabel* lab2 = new QLabel(oneClass->classCab);
    layout->addWidget(lab2);

    setLayout(layout);
}
