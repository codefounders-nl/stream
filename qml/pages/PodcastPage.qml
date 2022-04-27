import QtQuick 2.7
import Ubuntu.Components 1.3
import QtMultimedia 5.4
import ".."


PageBase {
    id: podcastPage

    property string title 
    property alias description : podcastDescription.text
    property var provider

    anchors.fill: parent

    pageHeader.title: title

    Item {
        id: podcastDescriptionItem

        anchors {
            top: pageHeader.bottom
            horizontalCenter: parent.horizontalCenter
        }

        width: parent.width
        height: podcastDescription.contentHeight + units.gu(4)

        Label {
            id: podcastDescription

            width: parent.width - units.gu(4)
            anchors.centerIn: parent

            text: description
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            height: units.gu(0.1)
            width: parent.width

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            color: theme.palette.normal.base
        }
        
    }

    ListView {
        id: listview

        anchors {
            fill: parent
            topMargin: pageHeader.height + podcastDescriptionItem.height
        }

        model: provider.podcastModel
        delegate: PodcastItem {
                    client: provider.client
                    onSongSelected: {
                        playerPage.model = provider.podcastModel
                        playerPage.title = title   
                        playerPage.artist = artist
                        playerPage.albumart = albumart
                        playerPage.reverse = true
                       // playerPage.player.source = source
                        playerPage.player.addSources(provider.podcastModel.toSourcesArray(), index)
                    }
                }
        clip: true
    }
}
