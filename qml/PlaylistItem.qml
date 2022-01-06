import QtQuick 2.7
import Ubuntu.Components 1.3

ListItem {
    id: playlistItem

    height: units.gu(9)

    onClicked: songSelected(artist, title, albumartImage.source)
    signal songSelected(string artist, string title, string albumart)

    UbuntuShape {
        id: albumartShape

        height: units.gu(7)
        width: height

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        // Put album art in UbuntuShape
        source: Image {
                    id: albumartImage

                    source: "http://demo.subsonic.org/rest/getCoverArt?u=guest&p=guest&v=1.13&c=api-test&id=" + albumart
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
            verticalCenter: parent.verticalCenter
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

            text: artist
        }

        Label {
            id: durationText

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            text: Math.floor(duration / 60) + ":" + duration % 60
        }
    }
}