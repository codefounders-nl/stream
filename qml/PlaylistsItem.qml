import QtQuick 2.7
import Ubuntu.Components 1.3
import "utility.js" as Utility

// Listitem containing a playlist
ListItem {
    id: playlistItem

    height: units.gu(9)
    enabled: duration > 0
    
    property var client
    signal playlistSelected(string playlistId, string playlistTitle)

    onClicked: playlistSelected(playlistId, title)

    UbuntuShape {
        id: playlistArtShape

        height: units.gu(7)
        width: height

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        // Put album art in UbuntuShape
        source: Image {
                    id: playlistImage

                    source: client.getCoverArt(playlistArt)                   
                }

        aspect: UbuntuShape.Inset
    }

    // Put labels in a 'box'
    Item {
        width: parent.width - units.gu(12)
        height: units.gu(4.5)

        anchors {
            left: playlistArtShape.right
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: titleText

            width: parent.width - playlistArtShape.width

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
            id: informationText

            width: parent.width - playlistArtShape.width

            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            maximumLineCount: 1
            elide: Text.ElideRight

            text: tracksAmount + ' tracks, ' +  Utility.secToPlaytimeHourFormat(duration)
        }
    }
}