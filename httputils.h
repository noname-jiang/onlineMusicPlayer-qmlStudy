#ifndef HTTPUTILS_H
#define HTTPUTILS_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

class HttpUtils : public QObject
{
    Q_OBJECT

private:
    QNetworkAccessManager * manager;
    QString BASE_URL = "http://localhost:3000/";

public:
    explicit HttpUtils(QObject *parent = nullptr);

    Q_INVOKABLE void connet(QString url); //Q_INVOKABLE让QML里可以调用

    Q_INVOKABLE void replyFinished(QNetworkReply *reply);

signals:
    void replySignal(QString reply);


};

#endif // HTTPUTILS_H
