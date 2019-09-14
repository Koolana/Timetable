#include "custombutton.h"

CustomButton::CustomButton(int id, QString str, QWidget* parent)
    : QPushButton(str, parent)
{
    this->id = id;
    connect(this, SIGNAL(clicked()), SLOT(customClick()));
}

void CustomButton::customClick()
{
    emit clickWithId(id);
}
