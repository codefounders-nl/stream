import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.4
import "../utility.js" as Utility

PageBase {
    id: playerPage

    anchors.fill: parent

    showBottomMenu: false

    property string title
    property string artist
    property string albumart
    property alias player: player

    pageHeader.title: i18n.tr('Now playing')

    Audio {
        id: player

        autoPlay: true
    }
    
    Image {
        id: fullAlbumArt

        width: parent.width
        height: parent.width

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: pageHeader.bottom
        }

        source: albumart
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
                    
                    anchors.horizontalCenter: parent.horizontalCenter
                                        
                    font.bold: true
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    
                    text: title
                }

                Label {
                    id: trackInfoArtist
                    
                    anchors.horizontalCenter: parent.horizontalCenter

                    maximumLineCount: 1
                    elide: Text.ElideRight

                    text: artist
                }
            }
            
            Slider {
                id: slider

                width: parent.width
                height: units.gu(2)

                function formatValue(v) {
                    return Utility.millisecToPlaytime(v)
                }

                onPressedChanged: {
                    player.seek(slider.value)
                }

                minimumValue: 0
                maximumValue: player.duration
                value: player.position

                // live: false // false to let slider be updated
            }

            Item {
                width: parent.width
                height: units.gu(2)

                Label {
                    id: playbacktime
                    
                    anchors {
                        left: parent.left
                    }
                    
                    text: Utility.millisecToPlaytime(player.position)
                }

                Label {
                    id: fullduration
                    
                    anchors {
                        right: parent.right
                    }
                    
                    text: Utility.millisecToPlaytime(player.duration)
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

                MouseArea {
                    height: units.gu(5)
                    width: units.gu(5)

                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: {
                        if (player.playbackState == true) {
                            player.pause()
                        }
                        else {
                            player.play()
                        }
                    }

                    Icon {
                        id: playPauseButton

                        height: units.gu(5)
                        width: units.gu(5)

                        anchors.centerIn: parent

                        name: player.playbackState == true ? "media-playback-pause" : "media-playback-start"
                    }
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