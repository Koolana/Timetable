#include "widget.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Widget w;

    //with Kolana branch1
    //test commit
    //w.showFullScreen();
    w.show();

    return a.exec();
}
