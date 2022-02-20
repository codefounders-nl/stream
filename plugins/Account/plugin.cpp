#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "account.h"
#include "accountmodel.h"


static QObject* modelSingletonProvider(QQmlEngine*, QJSEngine*)
{
    return new AccountModel;
}

void AccountPlugin::registerTypes(const char *uri) {
    //@uri Account

    //mlRegisterType<Account::Type>("Account", 1, 0, "Type");
    qmlRegisterUncreatableType<Account>(uri, 1, 0, "Account", "Use AccountModel::createAccount() to create a new account");

    /* Make this one a singleton */
    qmlRegisterSingletonType<AccountModel>(uri, 1, 0, "AccountModel", [](QQmlEngine*, QJSEngine*) -> QObject* { return new AccountModel; });
}
