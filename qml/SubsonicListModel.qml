import QtQuick 2.7
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: subsonicListModel
    namespaceDeclarations: "declare default element namespace 'http://subsonic.org/restapi';"
    source: "http://demo.subsonic.org/rest/getPlaylist?u=guest&p=guest&v=1.13&c=api-test&id=1507"
    query: "/subsonic-response/playlist/entry"

    XmlRole { name: "artist"; query: "@artist/string()" }
    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "albumart"; query: "@coverArt/string()" }
    XmlRole { name: "duration"; query: "@duration/string()" }
    XmlRole { name: "source"; query: "@id/string()" }
}