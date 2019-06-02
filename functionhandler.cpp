#include "functionhandler.h"
#include <iostream>
#include <fstream>
#include <streambuf>
#include <string>
#include <QDebug>
#include "json.hpp"

using namespace std;
using namespace nlohmann;

FunctionHandler::FunctionHandler(QObject *parent) : QObject(parent)
{

}

void FunctionHandler::loadDefaultConfig() {
    qInfo() << "Loading default config...";

    std::ifstream t("defaultConfig.json");
    std::string configText((std::istreambuf_iterator<char>(t)),
                     std::istreambuf_iterator<char>());

    json configJson = json::parse(configText)["config"];

    for (auto it = configJson.begin(); it != configJson.end(); ++it)
    {
        qInfo() << QString::fromStdString(it.key()) << ": " << QString::fromStdString(it.value());
    }

//    qInfo() << QString::fromStdString(configText);
}
