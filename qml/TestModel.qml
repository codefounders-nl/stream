import QtQuick 2.7
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: testModel
    namespaceDeclarations: "declare default element namespace 'http://subsonic.org/restapi';"
    source: "http://demo.subsonic.org/rest/getPlaylist?u=guest&p=guest&v=1.13&c=api-test&id=1507"
    query: "/subsonic-response/playlist/entry"

    XmlRole { name: "artist"; query: "@artist/string()" }
    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "albumart"; query: "@coverArt/string()" }
    XmlRole { name: "duration"; query: "@duration/string()" }
    XmlRole { name: "source"; query: "@path/string()" }
}

/*/
ListModel {
            id: testModel
            ListElement {
                artist: "Meau"
                title: "Dat heb jij gedaan"
                albumart: "./tmp/dathebjijgedaan.jpg"
                duration: "3:31"
            }
            ListElement {
                artist: "Acraze"
                title: "Do It To It"
                albumart: "./tmp/doittoit.jpg"
                duration: "2:37"
            }
            ListElement {
                artist: "Adele"
                title: "Easy On Me"
                albumart: "./tmp/easyonme.jpg"
                duration: "3:44"
            }
            ListElement {
                artist: "RONDÉ"
                title: "Hard To Say Goodbye"
                albumart: "./tmp/hartosaygoodbye.jpg"
                duration: "3:14"
            }
            ListElement {
                artist: "Glass Animals"
                title: "Heat Waves"
                albumart: "./tmp/heatwaves.jpg"
                duration: "3:58"
            }
            ListElement {
                artist: "Coldplay, BTS"
                title: "My Universe"
                albumart: "./tmp/myuniverse.jpg"
                duration: "3:48"
            }
        }
/*/