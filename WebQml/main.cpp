#include <QGuiApplication>
#include <QQuickView>
#include <QtWebEngine>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication a(argc, argv);
    QtWebEngine::initialize();
    QQuickView view;
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();
    return a.exec();
}
