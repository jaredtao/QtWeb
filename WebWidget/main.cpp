#include <QApplication>
#include <QWebEngineView>
int main(int argc, char **argv)
{
    QApplication app(argc, argv);

    QWebEngineView view;
    view.load(QUrl("https://www.zhihu.com/"));
    view.show();

    return app.exec();
}
