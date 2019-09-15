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
    pressed();
}

void CustomButton::pressed()
{
    setStyleSheet(QString::fromUtf8("background-color: rgb(244, 115, 255);"));
}

void CustomButton::unPressed()
{
    setStyleSheet(QString::fromUtf8("background-color: rgb(244, 244, 244);"));
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
