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
    property alias starredModel: _starredModel

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


        function toSourcesArray(){
            var sourceArray = new Array(_playlistModel.count);
            for(var i = 0; i < _playlistModel.count ; i++){
                sourceArray[i] = client.getStreamSource(_playlistModel.get(i).source);
            }
            console.log(sourceArray);
            return sourceArray;

        }
    }

    SubsonicPlaylistsModel {
        id: _playlistsModel

        source: _client.getPlaylists()


    }

    SubsonicPlaylistModel {
        id: _starredModel

        source: _client.getStarred()

        function toSourcesArray(){
            var sourceArray = new Array(_starredModel.count);
            for(var i = 0; i < _starredModel.count ; i++){
                sourceArray[i] = client.getStreamSource(_starredModel.get(i).source);
            }
            console.log(sourceArray);
            return sourceArray;

        }
    }

    SubsonicPodcastsModel {
        id: _podcastsModel

        source: _client.getPodcasts()

        
    }

    SubsonicPodcastModel {
        id: _podcastModel

        source: _client.getPodcast(client.currentPodcastId)

        function toSourcesArray(){
            var sourceArray = new Array(_podcastModel.count);
            for(var i = 0; i < _podcastModel.count ; i++){
                sourceArray[i] = client.getStreamSource(_podcastModel.get(i).source);
            }
            console.log(sourceArray);
            return sourceArray;

        }
    }
}