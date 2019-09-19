#ifndef PAGEREADER_H
#define PAGEREADER_H

#include <QNetworkAccessManager>

#include <QTextEdit>
#include <timetabledata.h>

class PageReader : public QObject
{
    Q_OBJECT
public:
    PageReader(QObject *parent = nullptr);
    PageReader(QString addr, QObject *parent = nullptr);

    void downloadAndReadPage(QString addr);

    ~PageReader();

    //QTextEdit* testTextBox; //временно, убрать отображение вообще из PageReader
    QList<DayData*> week;

private:
    QNetworkAccessManager* manager;
};

#endif // PAGEREADER_H
