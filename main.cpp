#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "functionhandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<FunctionHandler>("net.bhegde.functionhandler", 1, 0, "FunctionHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/ui.qml")));

    app.exec();
}

