#include "lessonwindow.h"

#include <QLabel>
#include <QBoxLayout>

LessonWindow::LessonWindow(Lesson* less, QWidget *parent) : QWidget(parent)
{
    QVBoxLayout* gLayout = new QVBoxLayout;
    QLabel* les = new QLabel(less->lessonName);

    les->setFrameShape(QFrame::StyledPanel);
    les->setLineWidth(3);

    gLayout->addWidget(les);
    setLayout(gLayout);
}
