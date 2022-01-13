import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'stream.slft'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Component.onCompleted: mainStack.push(mainPage)

    PageStack {
        id: mainStack

        anchors.fill: parent
    }

    SubsonicProvider {
        id: provider
    }

    property var client : provider.client

    Page {
        id: mainPage

        anchors.fill: parent

        header: PageHeader {
                    id: header

                    title: i18n.tr('Stream')
                }
                
        ListView {
            anchors {
                fill: parent
                topMargin: header.height
                bottomMargin: bottomMenu.height
            }
            
            model: provider.model
            delegate: PlaylistItem {
                        client: provider.client
                        onSongSelected: {
                            playerPage.title = title
                            playerPage.artist = artist
                            playerPage.albumart = albumart
                            playerPage.player.source = source
                        }
                      }

            clip: true
        }

        BottomMenu {
            id: bottomMenu

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            title: playerPage.title
            artist: playerPage.artist
            albumart: playerPage.albumart
            player: playerPage.player
        }
    }

    PlayerPage {
        id: playerPage
        
        visible: false
    }
}
