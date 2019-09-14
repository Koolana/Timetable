#include "widget.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Widget w;

    //test commit
    //w.showFullScreen();
    w.show();

    return a.exec();
}
