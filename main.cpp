#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "pagereader.h"
#include "filteringsystem.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QString addr = QString("https://students.bmstu.ru/schedule/62ec2eb2-a264-11e5-aa40-005056960017");
    PageReader* reader = new PageReader(addr);
    FilteringSystem* fSys = new FilteringSystem(reader->week);

    QQmlContext *context = engine.rootContext();    // Создаём корневой контекст
    /* Загружаем объект в контекст для установки соединения,
     * а также определяем имя, по которому будет происходить соединение
     * */
    context->setContextProperty("fSys", fSys);

    engine.load(url);

    fSys->init();

    return app.exec();
}
