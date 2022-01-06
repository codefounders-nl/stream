import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    id: playerPage

    anchors.fill: parent

    header: PageHeader {
                id: playerPageHeader
                title: i18n.tr('Now playing')
            }
    
    Image {
        id: fullAlbumArt

        width: parent.width
        height: parent.width

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: playerPageHeader.bottom
        }

        source: "tmp/dathebjijgedaan.jpg" // TEMPORARY SOURCE FOR DEMONSTRATION PURPOSES
    }

    Item {
        id: controlsHolder

        anchors {
            top: fullAlbumArt.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        Column {
            id: controls
            width: parent.width - units.gu(4)

            anchors.centerIn: parent

            Column {
                id: trackInfo

                width: parent.width
                height: units.gu(7)

                spacing: units.gu(0.5)

                Label {
                    id: trackInfoTitle
                                        
                    font.bold: true
                    
                    maximumLineCount: 1
                    
                    elide: Text.ElideRight

                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    text: "Dat heb jij gedaan" // TEMPORARY TITLE FOR DEMONSTRATION PURPOSES
                }

                Label {
                    id: trackInfoArtist

                    maximumLineCount: 1

                    elide: Text.ElideRight

                    anchors.horizontalCenter: parent.horizontalCenter

                    text: "Meau" // TEMPORARY ARTIST FOR DEMONSTRATION PURPOSES
                }
            }
            
            Slider {
                width: parent.width
                height: units.gu(2)

                minimumValue: 0
                maximumValue: 100
                value: 34

                // live: true
            }

            Item {
                width: parent.width
                height: units.gu(2)

                Label {
                    id: playbacktime
                    
                    anchors {
                        left: parent.left
                    }
                    
                    text: "1:12" // TEMPORARY VALUE FOR DEMONSTRATION PURPOSES
                }

                Label {
                    id: fullduration
                    
                    anchors {
                        right: parent.right
                    }
                    
                    text: "3:31" // TEMPORARY VALUE FOR DEMONSTRATION PURPOSES
                }
            }

            Row {
                id: playerControls

                height: units.gu(7)

                anchors.horizontalCenter: parent.horizontalCenter

                spacing: units.gu(3)

                Icon {
                    id: repeatButton

                    height: units.gu(3)
                    width: units.gu(3)

                    anchors.verticalCenter: parent.verticalCenter

                    name: "media-playlist-repeat"
                }

                Icon {
                    id: previousButton

                    height: units.gu(3)
                    width: units.gu(3)

                    anchors.verticalCenter: parent.verticalCenter

                    name: "media-skip-backward"
                }

                Icon {
                    id: playPauseButton

                    height: units.gu(5)
                    width: units.gu(5)

                    anchors.verticalCenter: parent.verticalCenter

                    name: "media-playback-pause"
                }

                Icon {
                    id: nextButton

                    height: units.gu(3)
                    width: units.gu(3)

                    anchors.verticalCenter: parent.verticalCenter

                    name: "media-skip-forward"
                }

                Icon {
                    id: shuffleButton

                    height: units.gu(3)
                    width: units.gu(3)

                    anchors.verticalCenter: parent.verticalCenter

                    name: "media-playlist-shuffle"
                }
            }
        }
    }
}