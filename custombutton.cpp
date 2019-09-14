#include "custombutton.h"

CustomButton::CustomButton(int id, QString str, QWidget* parent)
    : QPushButton(str, parent)
{
    setSizePolicy( QSizePolicy(QSizePolicy::Preferred, QSizePolicy::Preferred) );
    this->id = id;
    connect(this, SIGNAL(clicked()), SLOT(customClick()));
}

void CustomButton::customClick()
{
    emit clickWithId(id);
}

int CustomButton::heightForWidth( int width ) const
{
    return width;
}

QSize CustomButton::sizeHint() const
{
    int w = (int) (100);
    return QSize( w, heightForWidth(w) );
}
