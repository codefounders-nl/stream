import QtQuick 2.7
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: subsonicListModel
    
    namespaceDeclarations: "declare default element namespace 'http://subsonic.org/restapi';"
    query: "/subsonic-response/podcasts/channel/episode"

    XmlRole { name: "artist"; query: "@artist/string()" }
    XmlRole { name: "podcastTitle"; query: "@album/string()" }
    XmlRole { name: "albumart"; query: "@coverArt/string()" }
    XmlRole { name: "duration"; query: "@duration/string()" }
    XmlRole { name: "source"; query: "@id/string()" }
    // XmlRole { name: "year"; query: "@year/string()" }
    // XmlRole { name: "contentType"; query: "@contentType/string()" }
    XmlRole { name: "playCount"; query: "@playCount/string()" }
    // XmlRole { name: "created"; query: "@created/string()" }
    XmlRole { name: "publishDate"; query: "@publishDate/string()" }
    // XmlRole { name: "streamId"; query: "@streamId/string()" }
    XmlRole { name: "description"; query: "@description/string()" }
    XmlRole { name: "status"; query: "@status/string()" }
}