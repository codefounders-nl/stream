/*
 * Copyright © 2020 Rodney Dawes
 * Copyright: 2013 Michael Zanetti <michael_zanetti@gmx.net>
 *
 * This project is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This project is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
#pragma once

#include "account.h"

#include <QAbstractListModel>
#include <QSettings>

class AccountModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        Name = Qt::UserRole + 1,
        Type,
        Uri,
        Username,
        Secret
    };

    explicit AccountModel(const QSettings& settings=QSettings(), QObject *parent=0);

    int rowCount(const QModelIndex &parent=QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE Account *get(const QString& name) const;
    Q_INVOKABLE Account *get(const int index) const;

    Q_INVOKABLE void remove(Account* account);
    Q_INVOKABLE void save(Account* account);

    Q_INVOKABLE Account *createAccount(const QString& text=QString());

    Q_INVOKABLE void refresh();

private:
    int indexOf(const QString& name);

    QList<Account*> m_accounts;
    QSettings m_settings;
};
