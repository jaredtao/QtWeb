#include "websocketclientwrapper.h"
#include "websockettransport.h"

#include <QDebug>
#include <QWebSocketServer>
#include <QWebSocket>
WebSocketClientWrapper::WebSocketClientWrapper(QWebSocketServer *server, QObject *parent) : QObject(parent), m_server(server)
{
    connect(server, &QWebSocketServer::newConnection, this, &WebSocketClientWrapper::handleNewConnection);
}

void WebSocketClientWrapper::handleNewConnection()
{
    auto pSocket = m_server->nextPendingConnection();
    if (pSocket)
    {
        connect(pSocket, &QWebSocket::disconnected, this, &WebSocketClientWrapper::clientDisconnected);
        emit clientConnected(new WebSocketTransport(pSocket));
    }
}
