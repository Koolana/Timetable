#include "widget.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Widget w;

    //with Uneckee branch2
    //test commit
    //w.showFullScreen(); figjbjrggrew
    w.show();
    pause(0.01);

    return a.exec();
}
