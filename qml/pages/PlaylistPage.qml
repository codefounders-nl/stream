import QtQuick 2.7
import Ubuntu.Components 1.3
import QtMultimedia 5.4
import ".."


Page {
    id: playlistPage

    property alias playlistTitle : header.title
    property var provider

    anchors.fill: parent

    header: PageHeader {
                id: header
            }
            
    ListView {
        id: listview

        anchors {
            fill: parent
            topMargin: header.height
            bottomMargin: bottomMenu.height
        }
        
        model: provider.playlistModel
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
