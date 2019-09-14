#ifndef DRAWCLASS_H
#define DRAWCLASS_H

#include <QWidget>
#include <QGroupBox>

#include <weekanddaydata.h>

class drawClass : public QGroupBox
{
    Q_OBJECT
public:
    explicit drawClass(DoubleClass *oneClass, QGroupBox *parent = nullptr);

signals:

public slots:
};

#endif // DRAWCLASS_H
