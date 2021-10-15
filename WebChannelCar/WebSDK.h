#pragma once

#include "SocketWrap/websocketclientwrapper.h"
#include <QObject>
#include <QUrl>
#include <QUrlQuery>
#include <QWebChannel>
#include <QWebSocketServer>
#include <QWidget>
#include "car.h"
class WebSDK : public QObject
{
    Q_OBJECT


public:
    enum class BrowserType : uint8_t
    {
        Chrome = 0,
        Firefox,
        IE,
        Edge
    };
    explicit WebSDK(QWidget *pMainWindow, Car *car, QObject *parent = nullptr);
    virtual ~WebSDK() override;
signals:
public slots:
    void openWeb(const QString &htmlFile, BrowserType type = BrowserType::Chrome, const QUrlQuery &urlQuery = {});
protected slots:
    void onConnected();
    void onDisconnected();

private:
    QWidget *m_pMainWindow = nullptr;
    Car *m_pCar = nullptr;
    QWebSocketServer *m_server = nullptr;
    QWebChannel m_channel;
    WebSocketClientWrapper *m_clientWraper = nullptr;
};
