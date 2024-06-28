#include "httputils.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>

HttpUtils::HttpUtils(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager();
    connect(manager, &QNetworkAccessManager::finished, this, &HttpUtils::replyFinished);
}

void HttpUtils::connet(QString url){
    QNetworkRequest requst;
    requst.setUrl(QUrl(BASE_URL+url));
    manager->get(requst);
}

void HttpUtils::replyFinished(QNetworkReply *reply){
    emit replySignal(reply->readAll()); //这里发送信号给QML里监听

}
