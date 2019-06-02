#include "funchandler.h"
#include <fstream>
#include <streambuf>
#include <QDebug>

FuncHandler::FuncHandler(QObject *parent) : QObject(parent)
{

}

void FuncHandler::onLoadConfig(QString filename) {
    qInfo() << "Loading config...";

    std::ifstream t(filename.toStdString());
    std::string configText((std::istreambuf_iterator<char>(t)),
                         std::istreambuf_iterator<char>());



    emit applyJsonConfig(QString::fromStdString(configText));
}
