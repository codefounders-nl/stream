import QtQuick 2.7
import QtQuick.XmlListModel 2.0

Item {
    property string server
    property string username
    property string password

    property string currentPlaylistId
    property string currentAlbumId
    property string currentArtistId

    function getPlaylist(id) {
        return getUrl("getPlaylist", id)
    }

    function getCoverArt(id) {
        return getUrl("getCoverArt", id)
    }
    
    function getStreamSource(id) {
        return getUrl("stream", id)
    }

    function getBaseUrl(operation, id) {
        var url = server + "/rest/"+ operation + "?v=1.13&c=stream.sflt&u=" + username + "&p=" + password
        // console.debug("url: " + url)
        return url
    }

    function getUrl(operation, id) {
        var url = getBaseUrl(operation, id) + "&id=" + id
        return url
    }

    function getPodcastUrl(operation, id) {
        var url = getBaseUrl(operation, id)
        return url
    }


    function getPlaylists() {
        return getUrl("getPlaylists")
    }
    
    function getPodcasts() {
        return getPodcastUrl("getPodcasts")
    }

    function getPodcast(id) {
        return getUrl("getPodcasts", id)
    }

    function login(serverurl,username,password,callbackFunc) {
        pingModel.callbackFunc = callbackFunc
        pingModel.source = serverurl + "/rest/ping.view?v=1.13&c=stream.sflt&u=" + username + "&p=" + password
    }

    XmlListModel {
        id: pingModel

        property var callbackFunc
        
        onStatusChanged: {
            console.log(pingModel.source)
            console.log(pingModel.status)
            console.log(pingModel.get(0))
            if (status == XmlListModel.Ready) {
                callbackFunc(pingModel.get(0))
            }
        }

        namespaceDeclarations: "declare default element namespace 'http://subsonic.org/restapi';"
        query: "/subsonic-response"

        XmlRole { name: "status"; query: "@status/string()" }
        XmlRole { name: "errorcode"; query: "error/@code/string()" }
        XmlRole { name: "errormessage"; query: "error/@message/string()" }
    }
}