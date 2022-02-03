import QtQuick 2.7

Item {
    property string name: "Subsonic"
    property alias client: client
    property alias playlistModel: playlistModel
    property alias playlistsModel: playlistsModel

    SubsonicClient{
        id: client
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