import QtQuick 2.7
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: subsonicPlaylistModel
    
    namespaceDeclarations: "declare default element namespace 'http://subsonic.org/restapi';"
    query: "/subsonic-response/playlists/playlist"

    XmlRole { name: "playlistId"; query: "@id/string()" }
    XmlRole { name: "title"; query: "@name/string()" }
    XmlRole { name: "playlistArt"; query: "@coverArt/string()" }
    XmlRole { name: "duration"; query: "@duration/string()" }
    XmlRole { name: "tracksAmount"; query: "@songCount/string()" }
}