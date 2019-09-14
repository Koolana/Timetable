#include "drawclasseslist.h"
#include "drawclass.h"

#include <QBoxLayout>

DrawClassesList::DrawClassesList(QList<DoubleClass> *doubleClasses, QGroupBox *parent) : QGroupBox(parent)
{
    this->setVisible(false);

    QVBoxLayout* layout = new QVBoxLayout;

    for(auto oneClass: *doubleClasses){
        if(oneClass.NumeratorDenumerataor != 0)
        {
            drawClass* tmp = new drawClass(&oneClass);
            layout->addWidget(tmp);
        }
    }

    setLayout(layout);

    QMargins m = layout->contentsMargins();
    m.setLeft(0);
    m.setRight(0);
    m.setTop(0);
    m.setBottom(0);
    layout->setContentsMargins(m);
}

void DrawClassesList::hideOrShow(){
    this->setVisible(!this->isVisible());
}
