#ifndef DRAWCLASSESLIST_H
#define DRAWCLASSESLIST_H

#include <QWidget>
#include <QGroupBox>

#include <weekanddaydata.h>

class DrawClassesList : public QGroupBox
{
    Q_OBJECT
public:
    DrawClassesList(QList<DoubleClass> *doubleClasses, QGroupBox *parent = nullptr);

public slots:
    void hideOrShow();
};

#endif // DRAWCLASSESLIST_H
