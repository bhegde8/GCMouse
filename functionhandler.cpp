#include "functionhandler.h"
#include <iostream>
#include <fstream>
#include <streambuf>
#include <string>
#include <QDebug>
#include "json.hpp"
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickWindow>

using namespace std;
using namespace nlohmann;

static QQuickWindow *rootObj;

FunctionHandler::FunctionHandler(QQuickItem *parent) : QQuickItem(parent)
{
    rootObj = window();
}

void FunctionHandler::loadDefaultConfig() {
    qInfo() << "Loading default config...";

    std::ifstream t("defaultConfig.json");
    std::string configText((std::istreambuf_iterator<char>(t)),
                     std::istreambuf_iterator<char>());

//    QObject *chooser = appWindow->findChild<QObject*>("chooser_LTrigger");
//    chooser->setProperty("currentText", "mouse_leftclick");

      qInfo() << (rootObj == nullptr);
      std::string test = rootObj->objectName().toStdString();


//    json configJson = json::parse(configText)["config"];

//    for (auto it = configJson.begin(); it != configJson.end(); ++it)
//    {

//        qInfo() << QString::fromStdString(it.key()) << ": " << QString::fromStdString(it.value());

//        std::string itemName = "chooser_" + it.key();
//        QObject *chooser = appWindow->findChild<QObject*>(itemName.c_str());
//        chooser->setProperty("currentText", "mouse_leftclick");
//    }


//    qInfo() << QString::fromStdString(configText);
}
