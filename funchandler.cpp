#include "funchandler.h"
#include <fstream>
#include <streambuf>
#include <QDebug>

QObject* appWindow;

FuncHandler::FuncHandler(QObject *parent) : QObject(parent)
{

}

void FuncHandler::setWindow(QObject* window) {
    appWindow = window;
}

void FuncHandler::onLoadConfig(QString filename) {
    qInfo() << "Loading config...";

    std::ifstream t(filename.toStdString());
    std::string configText((std::istreambuf_iterator<char>(t)),
                         std::istreambuf_iterator<char>());


    emit applyJsonConfig(QString::fromStdString(configText));
}

void FuncHandler::onApplyTextChooser(QString chooser, QString text) {

//    qInfo() << "Trying to set text of chooser_ " + chooser + " to: " + text;

    QObject *chooserObj = appWindow->findChild<QObject*>("chooser_" + chooser);
    if (chooserObj)
        chooserObj->setProperty("text", text);
}
