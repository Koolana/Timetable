#include "pagereader.h"

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QTextCodec>
#include <QFile>
#include <QDebug>
#include <QtXml>
#include <libs/QGumboParser/qgumbodocument.h>
#include <libs/QGumboParser/qgumbonode.h>

PageReader::PageReader(QWidget *parent)
    : QWidget(parent)
{

}

PageReader::PageReader(QString *addr, QWidget *parent)
    : QWidget(parent)
{
    downloadAndReadPage(addr);
}

void PageReader::downloadAndReadPage(QString *addr)
{
    testTextBox = new QTextEdit();//временно, убрать отображение вообще из PageReader

    //Вынести весь парсер и формирования списка расписания в отдельный класс
    manager = new QNetworkAccessManager(this);
    qDebug() << QSslSocket::supportsSsl() << QSslSocket::sslLibraryBuildVersionString() << QSslSocket::sslLibraryVersionString();

    // берем адрес
    QUrl url(*addr);

    // создаем объект для запроса
    QNetworkRequest request(url);

    // Выполняем запрос, получаем указатель на объект
    // ответственный за ответ
    QNetworkReply* reply=  manager->get(request);

    // Подписываемся на сигнал о готовности загрузки
    // реализуем ожидание конца загрузки
    QEventLoop loop;
    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    loop.exec();

    // выводим содержимое
    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray content = reply->readAll();
        QGumboDocument doc = QGumboDocument::parse(QString(content));
        QGumboNode root = doc.rootNode();
        QGumboNodes nodes = root.getElementsByClassName("hidden-xs");//.getElementsByTagName(HtmlTag::TABLE);//.getElementsByTagName(HtmlTag::DIV);

        QStringList* list = new QStringList();

        for (auto node: nodes) {
            //nodes.getElementsByClassName("hidden-xs");
            if(node.nodeName() == "div"){
                //qDebug() << "title: " << node.nodeName() << " " << node.innerText();
                QGumboNodes nodes1lvl = node.getElementsByTagName(HtmlTag::TR);

                DayData thisDay;

                int i = 0;

                for(auto node1lvl: nodes1lvl)
                {
                    if(i < 1)
                    {
                        thisDay.name = node1lvl.getElementsByTagName(HtmlTag::STRONG).at(0).innerText();
                        //qDebug() << "   dayName: " << thisDay.name;
                    }
                    else if(i >=2)
                    {
                        //qDebug() << "   title1: " << node1lvl.nodeName() << " " << node1lvl.children().size();

                        DoubleClass thisClass;
                        QGumboNodes nodes2lvl = node1lvl.children();

                        int j = 0;

                        for(auto node2lvl: nodes2lvl)
                        {
                            if(j == 0)
                            {
                                thisClass.time = node2lvl.innerText();
                                //qDebug() << "      title2: " << node2lvl.nodeName() << " " << node2lvl.innerText();
                            }else
                            {
                                thisClass.NumeratorDenumerataor = j - 1;

                                if(node2lvl.children().empty())
                                {
                                    thisClass.classType = "";
                                    thisClass.className = "";
                                    thisClass.classCab = "";
                                    thisClass.classLecturer = "";
                                    //qDebug() << "      title2: " << node2lvl.nodeName() << " " << "empty";
                                }else
                                {
                                    //qDebug() << "      title2: " << node2lvl.nodeName();

                                    thisClass.classType = node2lvl.children().at(0).innerText();
                                    thisClass.className = node2lvl.children().at(1).innerText();
                                    thisClass.classCab = node2lvl.children().at(2).innerText();
                                    thisClass.classLecturer = node2lvl.children().at(3).innerText();
                                }

                                if(node1lvl.children().size() == 2){
                                    thisClass.NumeratorDenumerataor = 2;
                                }

                                thisDay.doubleClasses.append(thisClass);
                            }
                            j++;
                        }
                    }
                    i++;
                }

                week.append(thisDay);
                list->append(node.outerHtml());
            }
        }

        for(auto tmp: *list){
            testTextBox->insertHtml(tmp);
        }

        for(auto weekDay: week)
        {
            qDebug() << weekDay.name;

            for(int i = 0; i < weekDay.doubleClasses.count(); i++)
            {
                qDebug() << "  " << weekDay.doubleClasses.at(i).NumeratorDenumerataor << " "
                         << weekDay.doubleClasses.at(i).time << " "
                         << weekDay.doubleClasses.at(i).classType
                         << weekDay.doubleClasses.at(i).className << " "
                         << weekDay.doubleClasses.at(i).classCab << " "
                         << weekDay.doubleClasses.at(i).classLecturer;
            }
        }
    }
    else // вывод ошибки
        testTextBox->setPlainText(reply->errorString());

    reply->deleteLater();
}

PageReader::~PageReader(){

}
