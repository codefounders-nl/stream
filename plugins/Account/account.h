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

#include <QObject>

class Account : public QObject
{
    Q_OBJECT

    Q_PROPERTY(Type type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString uri READ uri WRITE setUri NOTIFY uriChanged)
    Q_PROPERTY(QString username READ username WRITE setUsername NOTIFY usernameChanged)
    Q_PROPERTY(QString secret READ secret WRITE setSecret NOTIFY secretChanged)
public:

    enum Type {
        Subsonic,
        Deezer,
        Youtube
    };

    Q_ENUM(Type)

    explicit Account(const QString &name, QObject *parent = 0);

    QString name() const;
    void setName(const QString& name);

    Type type() const;
    void setType(Type type);
    void setType(const QString& typeStr);

    QString username() const;
    void setUsername(const QString& username);

    QString secret() const;
    void setSecret(const QString& secret);

    QString uri() const;
    void setUri(const QString& uri);

    Type typeFromString(const QString& type);
    QString typeToString(Type type) const;


signals:
    void nameChanged();
    void typeChanged();
    void uriChanged();
    void usernameChanged();
    void secretChanged();

private:
    QString m_name;
    QString m_uri;
    Type m_type;
    QString m_username;
    QString m_secret;
};
