#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "functionhandler.h"
#include <QtQuick/QQuickItem>
#include <QObject>
#include <QQmlContext>
#include <fstream>



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("rootObject", QVariant::fromValue(engine.rootObjects().first()));
    engine.load(QUrl(QStringLiteral("qrc:/ui.qml")));

    app.exec();

}

