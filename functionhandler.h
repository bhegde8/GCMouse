#ifndef FUNCTIONHANDLER_H
#define FUNCTIONHANDLER_H

#include <QObject>

class FunctionHandler : public QObject
{
    Q_OBJECT
public:
    explicit FunctionHandler(QObject *parent = nullptr);
    Q_INVOKABLE void loadDefaultConfig();

signals:

public slots:

};

#endif // FUNCTIONHANDLER_H
