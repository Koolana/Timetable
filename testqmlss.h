#ifndef TESTQMLSS_H
#define TESTQMLSS_H

#include <QObject>

class TestQMLSS : public QObject
{
    Q_OBJECT
public:
    explicit TestQMLSS(QObject *parent = nullptr);
    void init();

signals:
    // Сигнал для передачи данных в qml-интерфейс
    void sendToQml(QString textField);

public slots:
    // Слот для приёма данных из qml-интерфейса
    void receiveFromQml();

private:
    QString textField;  // Счетчик, которым будем оперировать
};

#endif // TESTQMLSS_H
