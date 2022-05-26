import QtQuick 2.7
import Ubuntu.Components 1.3
import "utility.js" as Utility

// Listitem containing a podcast
ListItem {
    id: podcastItem

    height: units.gu(9)
    //enabled: duration > 0
    
    property var client
    signal podcastSelected(string podcastId, string podcastTitle, string podcastDescription)

    onClicked: podcastSelected(podcastId, title, description)

    UbuntuShape {
        id: podcastArtShape

        height: units.gu(7)
        width: height

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        // Put album art in UbuntuShape
        source: Image {
                    id: podcastImage

                    source: client.getCoverArt(coverArt)                   
                }

        aspect: UbuntuShape.Inset
    }

    // Put labels in a 'box'
    Item {
        width: parent.width - units.gu(12)
        height: units.gu(4.5)

        anchors {
            left: podcastArtShape.right
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: titleText

            width: parent.width - podcastArtShape.width

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

            width: parent.width - podcastArtShape.width

            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            maximumLineCount: 1
            elide: Text.ElideRight

            text: description
        }
    }
}