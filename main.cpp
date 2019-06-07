#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickItem>
#include <QObject>
#include <QQmlContext>
#include <fstream>
#include <funchandler.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    FuncHandler *fHandler = new FuncHandler();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("funcHandler", fHandler);
    engine.load(QUrl(QStringLiteral("qrc:/ui.qml")));

    QObject* appWindow = engine.rootObjects().first();
    QObject::connect(appWindow, SIGNAL(loadConfig(QString)), fHandler, SLOT(onLoadConfig(QString)));
    QObject::connect(appWindow, SIGNAL(applyTextChooser(QString, QString)), fHandler, SLOT(onApplyTextChooser(QString, QString)));

    fHandler->setWindow(appWindow);

    app.exec();

}

