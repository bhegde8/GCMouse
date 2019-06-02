#ifndef FUNCHANDLER_H
#define FUNCHANDLER_H

#include <QObject>
#include <iostream>

class FuncHandler : public QObject
{
    Q_OBJECT
public:
    explicit FuncHandler(QObject *parent = nullptr);

signals:
    void applyJsonConfig(QString json);

public slots:
    void onLoadConfig(QString fileName);
};

#endif // FUNCHANDLER_H
