import QtQuick 2.7
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: subsonicPodcastModel
    
    namespaceDeclarations: "declare default element namespace 'http://subsonic.org/restapi';"
    query: "/subsonic-response/podcasts/channel"

    XmlRole { name: "podcastId"; query: "@id/string()" }
    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "description"; query: "@description/string()" }
    XmlRole { name: "coverArt"; query: "@coverArt/string()" }
    XmlRole { name: "originalImageUrl"; query: "@originalImageUrl/string()" }
    XmlRole { name: "status"; query: "@status/string()" }
}