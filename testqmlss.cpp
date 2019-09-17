#include "testqmlss.h"

TestQMLSS::TestQMLSS(QObject *parent) : QObject(parent)
{
    textField = "start";
}

void TestQMLSS::init()
{
    for(int i = 0; i < 4; i++)
    {
        emit sendToQml(textField);
    }

    textField = "";
}

void TestQMLSS::receiveFromQml()
{
    textField += "1";
    emit sendToQml(textField);
}

