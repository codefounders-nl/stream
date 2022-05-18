import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.6
import "../utility.js" as Utility


PageBase {
    id: playerPage

    anchors.fill: parent

    showBottomMenu: false

    property string title
    property string artist
    property string albumart
    property string starred
    property string id
    property alias player: player
    property var model
    property bool reverse

    pageHeader.title: i18n.tr('Now playing')
    pageHeader.trailingActionBar.actions: [
                Action {
                    iconName: starred ? "starred" : "non-starred"
                    text: starred ? "Star" : "Unstar"
                    onTriggered: starred ? provider.client.unstar(id) : provider.client.star(id)
                }
            ]



    Audio {
        id: player

        autoPlay: true

        onStopped: {
            if (playlist.currentIndex == -1) {
                playlist.currentIndex = 0
                player.pause()
            }
        }

        playlist: Playlist {
            id: playlist

            onCurrentIndexChanged: {
                playerPage.title = model.get(currentIndex).title
                playerPage.artist = model.get(currentIndex).artist
                playerPage.albumart = provider.client.getCoverArt(model.get(currentIndex).albumart)
                playerPage.starred = model.get(currentIndex).starred
                playerPage.id = model.get(currentIndex).source
            }

        }
        function addSources(sources, index){
            player.stop()
            playlist.clear()
            playlist.addItems(sources);
            playlist.currentIndex = index;
        }
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

                    width: parent.width
                    
                    anchors.left: parent.left
                                        
                    font.bold: true
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                    
                    text: title
                }

                Label {
                    id: trackInfoArtist

                    width: parent.width

                    anchors.left: parent.left

                    maximumLineCount: 1
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter

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

                Connections {
                    target: player
                    onPositionChanged: {
                        slider.value = player.position
                    }
                    onStopped: {
                        slider.value = 0.00
                    }
                }

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

                MouseArea{
                    height: units.gu(3)
                    width: units.gu(3)

                    anchors.verticalCenter: parent.verticalCenter  

                    onClicked: {
                        // 1 == CurrentItemInLoop => Sequential
                        if (playlist.playbackMode == 1) {
                            repeatButton.name = "media-playlist-repeat"
                            repeatButton.color = theme.palette.disabled.baseText
                            playlist.playbackMode = 2
                        // 2 == Sequential || 4 == Random => Loop
                        } else if (playlist.playbackMode == 2 || playlist.playbackMode == 4) {
                            // set disabled color for shuffle button
                            shuffleButton.color = theme.palette.disabled.baseText
                            repeatButton.name = "media-playlist-repeat"
                            repeatButton.color = theme.palette.normal.baseText
                            playlist.playbackMode = 3
                        // 3 == Loop => CurrentItemInLoop
                        } else if (playlist.playbackMode == 3) {
                            repeatButton.name = "media-playlist-repeat-one"
                            repeatButton.color = theme.palette.normal.baseText
                            playlist.playbackMode = 1
                        }
                    }

                    Icon {
                        id: repeatButton

                        height: units.gu(3)
                        width: units.gu(3)

                        anchors.verticalCenter: parent.verticalCenter
                        color: theme.palette.disabled.baseText

                        name: "media-playlist-repeat"
                    }
                }

                MouseArea{
                    height: units.gu(3)
                    width: units.gu(3)
                    enabled: previousButton.enabled

                    anchors.verticalCenter: parent.verticalCenter  

                    onClicked: {
                        if(reverse){
                            playlist.next()
                        }else{
                            playlist.previous()
                        }
                    }
                    
                    Icon {
                        id: previousButton

                        height: units.gu(3)
                        width: units.gu(3)
                        enabled: reverse ? playlist.currentIndex < playlist.itemCount - 1 : playlist.currentIndex > 0
                        color: enabled ? theme.palette.normal.baseText : theme.palette.disabled.baseText

                        anchors.verticalCenter: parent.verticalCenter

                        name: "media-skip-backward"
                    }
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
                        color: theme.palette.normal.baseText
                        anchors.centerIn: parent

                        name: player.playbackState == true ? "media-playback-pause" : "media-playback-start"
                    }
                }
                MouseArea{
                    height: units.gu(3)
                    width: units.gu(3)
                    enabled: nextButton.enabled

                    anchors.verticalCenter: parent.verticalCenter  

                    onClicked: {
                        if(reverse){
                            playlist.previous()
                        }else{
                            playlist.next()
                        }

                    }

                    Icon {
                        id: nextButton

                        height: units.gu(3)
                        width: units.gu(3)
                         enabled: !reverse ? playlist.currentIndex < playlist.itemCount - 1 : playlist.currentIndex > 0           
                        color: enabled ? theme.palette.normal.baseText : theme.palette.disabled.baseText
                        anchors.centerIn: parent

                        name: "media-skip-forward"
                    }


                }

                MouseArea{
                    height: units.gu(3)
                    width: units.gu(3)

                    anchors.verticalCenter: parent.verticalCenter  

                    onClicked: {
                        // 4 == Random => Sequential
                        if (playlist.playbackMode == 4) {
                            shuffleButton.color = theme.palette.disabled.baseText
                            playlist.playbackMode = 2
                        } else {
                            // set disabled color for shuffle button
                            shuffleButton.color = theme.palette.normal.baseText
                            repeatButton.name = "media-playlist-repeat"
                            repeatButton.color = theme.palette.disabled.baseText
                            playlist.playbackMode = 4
                        }
                    }

                    Icon {
                        id: shuffleButton

                        height: units.gu(3)
                        width: units.gu(3)

                        anchors.verticalCenter: parent.verticalCenter
                        color: theme.palette.disabled.baseText

                        name: "media-playlist-shuffle"
                    }
                }
            }
        }
    }
}