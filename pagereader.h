#ifndef PAGEREADER_H
#define PAGEREADER_H

#include <QWidget>
#include <QString>
#include <QNetworkAccessManager>

#include <QTextEdit>
#include <weekanddaydata.h>

class PageReader : public QWidget
{
    Q_OBJECT
public:
    PageReader(QWidget *parent = 0);
    PageReader(QString *addr, QWidget *parent = 0);

    void downloadAndReadPage(QString *addr);

    ~PageReader();

    QTextEdit* testTextBox; //временно, убрать отображение вообще из PageReader
    QList<DayData> week;

private:
    QNetworkAccessManager* manager;
};

#endif // PAGEREADER_H
