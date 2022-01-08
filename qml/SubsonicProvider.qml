import QtQuick 2.7

Item {
    property alias client : client
    property alias model: model

    SubsonicClient{
        id: client

        server: "http://demo.subsonic.org"
        username: "guest"
        password: "guest"
    }

    SubsonicListModel {
        id: model

        source: client.getPlaylist(1507)
    }
}