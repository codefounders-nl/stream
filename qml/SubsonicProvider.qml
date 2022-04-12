import QtQuick 2.7
import Qt.labs.settings 1.0
import "utility.js" as Util

Item {
    property string name: "Subsonic"
    property alias client: _client
    property alias settings: _settings
    property alias playlistModel: _playlistModel
    property alias playlistsModel: _playlistsModel
    property alias podcastsModel: _podcastsModel
    property alias podcastModel: _podcastModel

    Settings {
        id: _settings

        category: "Subsonic"

        property int accountType: 0 // Account::Type::Subsonic
        property string serverurl
        property string username
        property string password

        function needsCredentials() {
            return password == ""
        }
    }

    SubsonicClient{
        id: _client

        server: _settings.serverurl
        username: _settings.username
        salt: Util.generateRandomSalt(12)
        token: Util.getToken(_settings.password, salt)
    }

    SubsonicPlaylistModel {
        id: _playlistModel

        source: _client.getPlaylist(client.currentPlaylistId)
    }

    SubsonicPlaylistsModel {
        id: _playlistsModel

        source: _client.getPlaylists()
    }

    SubsonicPodcastsModel {
        id: _podcastsModel

        source: _client.getPodcasts()
    }

    SubsonicPodcastModel {
        id: _podcastModel

        source: _client.getPodcast(client.currentPodcastId)
    }
}