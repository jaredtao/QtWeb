#pragma once

#include <QObject>

class WebSocketTransport;

QT_BEGIN_NAMESPACE
class QWebSocketServer;
QT_END_NAMESPACE

class WebSocketClientWrapper : public QObject
{
    Q_OBJECT
public:
    WebSocketClientWrapper(QWebSocketServer *server, QObject *parent = nullptr);

signals:
    void clientConnected(WebSocketTransport *client);
    void clientDisconnected();
private slots:
    void handleNewConnection();

private:
    QWebSocketServer *m_server;
};
