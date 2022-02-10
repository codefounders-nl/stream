import QtQuick 2.7
import Qt.labs.settings 1.0

Item {
    property string name: "Subsonic"
    property alias client: _client
    property alias settings: _settings
    property alias playlistModel: _playlistModel
    property alias playlistsModel: _playlistsModel

    Settings {
        id: _settings

        category: "Subsonic"

        property string serverurl
        property string username
        property string password        
    }


    SubsonicClient{
        id: _client

        server: _settings.serverurl
        username: _settings.username
        password: _settings.password
    }

    SubsonicPlaylistModel {
        id: _playlistModel

        source: _client.getPlaylist(client.currentPlaylistId)
    }

    SubsonicPlaylistsModel{
        id: _playlistsModel

        source: _client.getPlaylists()
    }
}