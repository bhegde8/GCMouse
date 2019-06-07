#ifndef FUNCHANDLER_H
#define FUNCHANDLER_H

#include <QObject>
#include <iostream>

extern QObject* appWindow;

class FuncHandler : public QObject
{
    Q_OBJECT
public:
    explicit FuncHandler(QObject *parent = nullptr);
    void setWindow(QObject* window = nullptr);

signals:
    void applyJsonConfig(QString json);

public slots:
    void onLoadConfig(QString fileName);
    void onApplyTextChooser(QString chooser, QString text);


};

#endif // FUNCHANDLER_H
