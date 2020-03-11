#include <QGuiApplication>
#include <QQuickView>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication a(argc, argv);

    QQuickView view;
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return a.exec();
}
