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
#include "accountmodel.h"

#include <QDebug>
#include <QSettings>
#include <QStringList>

AccountModel::AccountModel(const QSettings& settings, QObject *parent) :
    QAbstractListModel(parent),
    m_settings(settings.fileName(), QSettings::NativeFormat)
{
    refresh();
}

int AccountModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_accounts.count();
}

QVariant AccountModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid()) {
        auto account = m_accounts.at(index.row());
        switch (role) {
        case Roles::Name:
            return account->name();
        case Roles::Type:
            return account->type();
        case Roles::Uri:
            return account->uri();
        case Roles::Username:
            return account->username();
        case Roles::Secret:
            return account->secret();
        default:
            qWarning() << "Unhandled role:" << role;
        }
    } else {
        qCritical() << "Invalid index.";
    }
    return QVariant();
}

QHash<int, QByteArray> AccountModel::roleNames() const
{
    static QHash<int, QByteArray> roles;
    if (roles.empty()) {
        roles.insert(Roles::Name, "name");
        roles.insert(Roles::Type, "type");
        roles.insert(Roles::Uri, "uri");
        roles.insert(Roles::Username, "username");
        roles.insert(Roles::Secret, "secret");
    }
    return roles;
}

Account *AccountModel::get(const QString& name) const
{
    for (const auto& account: m_accounts) {
        if (account->name() == name) {
            return account;
        }
    }
    return nullptr;
}

Account *AccountModel::get(int index) const
{
    if (index < m_accounts.count()) {
        return m_accounts[index];
    }
    return nullptr;
}

void AccountModel::remove(Account* account)
{
    auto name = account->name();
    auto index = indexOf(name);
    beginRemoveRows(QModelIndex(), index, index);
    m_accounts.removeAt(index);
    m_settings.beginGroup(name);
    m_settings.remove("");
    m_settings.endGroup();
    endRemoveRows();
}

void AccountModel::refresh()
{
    beginResetModel();
    endResetModel();
    for (const auto& group: m_settings.childGroups()) {
        qDebug() << "Settings Group: " << group;
        if (group == "General") continue;

        auto name = group;

        m_settings.beginGroup(group);
        Account *account = new Account(name, this);
        account->setType(m_settings.value("type").toString());
        account->setUri(m_settings.value("uri").toString());
        account->setUsername(m_settings.value("username").toString());
        account->setSecret(m_settings.value("secret").toString());
        m_settings.endGroup();

        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_accounts << account;
        endInsertRows();
    }
}

int AccountModel::indexOf(const QString& name)
{
    int i = 0;
    for (const auto& account: m_accounts) {
        if (account->name() == name) {
            return i;
        }
        i++;
    }
    return -1;
}
