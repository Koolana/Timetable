#include "widget.h"
#include "pagereader.h"

#include <QVBoxLayout>
#include <QGroupBox>
#include <QTextEdit>

#include "weekwindow.h"

Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    setMinimumSize(500, 500);
    QVBoxLayout* layout = new QVBoxLayout();

    //QGroupBox* box = new QGroupBox("Test");
    QString addr = QString("https://students.bmstu.ru/schedule/62ec2eb2-a264-11e5-aa40-005056960017");
    PageReader* reader = new PageReader(addr);

    WeekWindow* ww = new WeekWindow(reader->week);
    layout->addWidget(ww);

    setLayout(layout);

    QMargins m = layout->contentsMargins(); //убирает пустое пространство между родителем
    m.setLeft(5);
    m.setRight(5);
    m.setTop(0);
    layout->setContentsMargins(m);
}

Widget::~Widget()
{

}
