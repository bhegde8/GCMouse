#include "funchandler.h"
#include <fstream>
#include <streambuf>
#include <QDebug>

QObject* appWindow;

//FuncHandler handles functions that the QML code can't do well,
//such as loading the config from the file, saving the config, programmatically
//modifying object properties by the object name, etc.

FuncHandler::FuncHandler(QObject *parent) : QObject(parent)
{

}

//Store the GUI window of the application so
//that the FuncHandler can access UI elements and modify them when needed
void FuncHandler::setWindow(QObject* window) {
    appWindow = window;
}

//Load the JSON config from the given file
void FuncHandler::onLoadConfig(QString filename) {

    std::ifstream t(filename.toStdString());
    std::string configText((std::istreambuf_iterator<char>(t)),
                         std::istreambuf_iterator<char>());


    emit applyJsonConfig(QString::fromStdString(configText)); //Send the JSON to the QML code for processing
}

//Save the current config in JSON format to config.json
void FuncHandler::onSaveConfig(QString configJson) {
    std::ofstream file("config.json");
    file << configJson.toStdString();
}

//Set the text of button map choosing text fields
//Used when the config is loaded and the text fields need to
//be populated with the loaded config. Also used
//to set the text fields for mouse controls.
void FuncHandler::onApplyTextChooser(QString chooser, QString text) {

    QObject *chooserObj = appWindow->findChild<QObject*>("chooser_" + chooser);
    if (chooserObj)
        chooserObj->setProperty("text", text);

}
