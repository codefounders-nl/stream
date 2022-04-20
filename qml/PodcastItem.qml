import QtQuick 2.7
import Ubuntu.Components 1.3
import "utility.js" as Utility

// Listitem for an individual song of a podcast
ListItem {
    id: podcastItem

    visible: duration > 0
    height: visible ? units.gu(16) : 0
    
    property var client
    signal songSelected(string artist, string title, string albumart, string source)

    onClicked: songSelected(artist, title, client.getCoverArt(albumart), client.getStreamSource(source))

    UbuntuShape {
        id: albumartShape

        height: units.gu(7)
        width: height

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            top: parent.top
            topMargin: units.gu(2)
        }

        // Put album art in UbuntuShape
        source: Image {
                    id: albumartImage

                    source: client.getCoverArt(albumart)
                }

        aspect: UbuntuShape.Inset
    }

    // Put labels in a 'box'
    Item {
        width: parent.width - units.gu(12)
        height: units.gu(4.5)

        anchors {
            left: albumartShape.right
            leftMargin: units.gu(1)
            verticalCenter: albumartShape.verticalCenter
        }

        Label {
            id: titleText

            width: parent.width - albumartShape.width

            anchors {
                left: parent.left
                top: parent.top
            }

            font.bold: true
            maximumLineCount: 1
            elide: Text.ElideRight

            text: title
        }

        Label {
            id: artistText

            width: parent.width - albumartShape.width

            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            maximumLineCount: 1
            elide: Text.ElideRight

            text: publishDate.slice(0, 10)
        }

        Label {
            id: durationText

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            text: Utility.millisecToPlaytime(duration * 1000)
        }
    }

    Label {
        id: descriptionText

        width: parent.width - units.gu(4)

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            top: albumartShape.bottom
            topMargin: units.gu(1)
        }

        maximumLineCount: 2
        elide: Text.ElideRight // required the width to be set
        wrapMode: Text.WordWrap

        text: description
    }
}