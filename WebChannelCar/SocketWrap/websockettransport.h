#pragma once
#include <QWebChannelAbstractTransport> 
QT_BEGIN_NAMESPACE
class QWebSocket;
QT_END_NAMESPACE

class WebSocketTransport : public QWebChannelAbstractTransport
{
    Q_OBJECT
public:
    explicit WebSocketTransport(QWebSocket *socket);
    virtual ~WebSocketTransport() override;

    void sendMessage(const QJsonObject &message) override;

private slots:
    void textMessageReceived(const QString &message);

private:
    QWebSocket *m_socket;
};
