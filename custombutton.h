#ifndef CUSTOMBUTTON_H
#define CUSTOMBUTTON_H

#include <QPushButton>

class CustomButton : public QPushButton
{
    Q_OBJECT
public:
    CustomButton(int id, QString str = "", QWidget* parent = 0);
    virtual int heightForWidth( int width ) const;
    virtual QSize sizeHint() const;

private:
    int id;

signals:
    void clickWithId(int id);

private slots:
    void customClick();
};

#endif // CUSTOMBUTTON_H
