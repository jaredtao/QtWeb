#include "WebSDK.h"
#include "SocketWrap/websockettransport.h"
#include <QDebug>
#include <QProcess>
WebSDK::WebSDK(QWidget *pMainWindow, Car *car, QObject *parent) : QObject(parent), m_pMainWindow(pMainWindow), m_pCar(car)
{
    m_server = new QWebSocketServer("EditorSocketServer", QWebSocketServer::NonSecureMode, this);
    const static quint16 portStart = 12345;
    quint16 retry = 0;
    bool connected = false;
    do {
        quint16 port = portStart + retry;
        connected = m_server->listen(QHostAddress::LocalHost, port);
        if (!connected) {
            qWarning() << "listen" << port << "failed: " << m_server->errorString();
            retry++;
        }
    } while (!connected);

    m_channel.registerObject("car", m_pCar);

    m_server->setMaxPendingConnections(1);
    m_clientWraper = new WebSocketClientWrapper(m_server);
    connect(m_clientWraper, &WebSocketClientWrapper::clientConnected, &m_channel, &QWebChannel::connectTo);
    connect(m_clientWraper, &WebSocketClientWrapper::clientConnected, this, &WebSDK::onConnected);
    connect(m_clientWraper, &WebSocketClientWrapper::clientDisconnected, this, &WebSDK::onDisconnected);
}

WebSDK::~WebSDK()
{
    if (m_clientWraper) {
        m_clientWraper->deleteLater();
        m_clientWraper = nullptr;
    }
    if (m_server) {
        if (m_server->isListening()) {
            m_server->close();
        }
        m_server->deleteLater();
        m_server = nullptr;
    }
}

void WebSDK::openWeb(const QString &htmlFile, WebSDK::BrowserType type, const QUrlQuery &urlQuery)
{
    const static QString browserArray[] = { "chrome", "firefox", "IExplore" };

    QUrl url = QUrl::fromLocalFile(htmlFile);

    QString browser = browserArray[static_cast<uint8_t>(type)];

    QUrlQuery query = urlQuery;
    query.addQueryItem("webChannelBaseUrl", m_server->serverUrl().toString());
    url.setQuery(query);

    QString psCmd = QString("powershell -noprofile -command \"[void][System.Diagnostics.Process]::Start('%1', '%2')\"").arg(browser).arg(url.toString());
    bool ok = QProcess::startDetached(psCmd);
    if (!ok) {
        qWarning() << "failed";
    }
}
void WebSDK::onConnected()
{
    m_pMainWindow->setWindowTitle("Qt Controlled Car (Connected)");
}
void WebSDK::onDisconnected()
{
    m_pMainWindow->setWindowTitle("Qt Controlled Car (DisConnected)");
}
