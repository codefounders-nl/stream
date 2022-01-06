import QtQuick 2.7
import Ubuntu.Components 1.3

Rectangle {
    width: parent.width
    height: units.gu(9)

    color: theme.palette.normal.background

    property string title
    property string artist
    property string albumart

    MouseArea {
        anchors.fill: parent

        onClicked: mainStack.push(playerPage)
    }

    // Grey line on top of bottomMenu, just like in the header

    Rectangle {
        id: greyLine

        width: parent.width
        height: units.gu(0.1)

        color: theme.palette.normal.base
    }

    // Song progressbar, this will diplay over the grey line, when a song starts playing

    ProgressBar {
        id: progressBar

        width: parent.width

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: greyLine.verticalCenter
        }

        // visible: 
        
        minimumValue: 0
        maximumValue: 100
        value: 34
    }

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
                    source: albumart
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

        Icon {
            id: playIcon

            width: units.gu(3)
            height: units.gu(3)

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            name: "media-playback-pause"
        }
    }
}