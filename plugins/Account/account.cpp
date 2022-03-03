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
#include "account.h"

#include <QDebug>

Account::Account(const QString &name, QObject *parent) :
    QObject(parent),
    m_name(name)
{

}

QString Account::name() const
{
    return m_name;
}

void Account::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

Account::Type Account::type() const
{
    return m_type;
}

void Account::setType(Account::Type type)
{
    if (m_type != type) {
        m_type = type;
        emit typeChanged();
    }
}

void Account::setType(const QString &typeStr)
{
    setType(typeFromString(typeStr));
}

Account::Type Account::typeFromString(const QString &type)
{
    if (type == "Deezer") return Account::Type::Deezer;
    else if (type == "Youtube") return Account::Type::Youtube;
    else return Account::Type::Subsonic;
}

QString Account::typeToString(Account::Type type) const
{
    switch (type) {
        case Account::Type::Subsonic:
            return "Subsonic";
        case Account::Type::Deezer:
            return "Deezer";
        case Account::Type::Youtube:
            return "Youtube";
        default:
            return "Invalid";            
    }
}

QString Account::username() const
{
    return m_username;
}

void Account::setUsername(const QString &username)
{
    if (m_username != username) {
        m_username = username;
        emit usernameChanged();
    }
}

void Account::setSecret(const QString &secret)
{
    if (m_secret != secret) {
        m_secret = secret;
        emit secretChanged();
    }
}

QString Account::uri() const
{
    return m_uri;
}

void Account::setUri(const QString &uri)
{
    if (m_uri != uri) {
        m_uri = uri;
        emit uriChanged();
    }
}
