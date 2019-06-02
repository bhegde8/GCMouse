#ifndef FUNCTIONHANDLER_H
#define FUNCTIONHANDLER_H

#include <QObject>
#include <QtQuick/QQuickItem>

class FunctionHandler : public QQuickItem
{
    Q_OBJECT
public:
    explicit FunctionHandler(QQuickItem *parent = nullptr);
    Q_INVOKABLE void loadDefaultConfig();

signals:

public slots:

};

#endif // FUNCTIONHANDLER_H
