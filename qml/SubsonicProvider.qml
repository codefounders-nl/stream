import QtQuick 2.7

Item {
    property string name: "Subsonic"
    property alias client: client
    property alias playlistModel: playlistModel
    property alias playlistsModel: playlistsModel

    SubsonicClient{
        id: client

        server: "http://demo.subsonic.org"
        username: "guest"
        password: "guest"
    }

    SubsonicPlaylistModel {
        id: playlistModel

        source: client.getPlaylist(client.currentPlaylistId)
    }

    SubsonicPlaylistsModel{
        id: playlistsModel

        source: client.getPlaylists()
    }
}