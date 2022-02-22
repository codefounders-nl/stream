#ifndef ACCOUNT_PLUGIN_H
#define ACCOUNT_PLUGIN_H

#include <QQmlExtensionPlugin>

class AccountPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif
