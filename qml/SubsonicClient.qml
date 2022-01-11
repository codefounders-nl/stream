import QtQuick 2.7

Item {
    property string server
    property string username
    property string password

    function getPlaylist(id) {
        return getUrl("getPlaylist", id)
    }

    function getCoverArt(id) {
        return getUrl("getCoverArt", id)
    }
    
    function getStreamSource(id) {
        return getUrl("stream", id)
    }

    function getUrl(operation, id) {
        var url = server + "/rest/"+ operation + "?v=1.13&c=stream.sflt&u=" + username + "&p=" + password + "&id=" + id
        console.debug("url: " + url)
        return url
    }
}