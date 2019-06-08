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

    FuncHandler *fHandler = new FuncHandler(); //Handles "backend" functions the UI/QML can't do well

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("funcHandler", fHandler); //used to connect a C++ -> QML connection
    engine.load(QUrl(QStringLiteral("qrc:/ui.qml")));

    QObject* appWindow = engine.rootObjects().first();

    //Add all the QML -> C++ connections
    QObject::connect(appWindow, SIGNAL(loadConfig(QString)), fHandler, SLOT(onLoadConfig(QString)));
    QObject::connect(appWindow, SIGNAL(applyTextChooser(QString, QString)), fHandler, SLOT(onApplyTextChooser(QString, QString)));
    QObject::connect(appWindow, SIGNAL(saveConfig(QString)), fHandler, SLOT(onSaveConfig(QString)));

    fHandler->setWindow(appWindow); //store the GUI window of the application on the function handler so it can manipulate the window

    app.exec();

}

