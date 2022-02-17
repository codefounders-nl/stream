import QtQuick 2.7
import Ubuntu.Components 1.3
import QtMultimedia 5.4
import ".."


PageBase {
    id: homePage

    property var streamingProvider
    property var pageStack

    header: PageHeader {
                id: homePageHeader

                title: i18n.tr('Stream')
                subtitle: streamingProvider.name

                extension: Sections {
                    id: homePageHeaderSections
                    actions: [ 
                        Action {
                            text: 'Playlists'
                        },
                        Action {
                            text: 'Artists'
                        },
                        Action {
                            text: 'Albums'
                        },
                        Action {
                            text: 'Podcasts'
                        }
                    ]

                    onSelectedIndexChanged: homePageTabView.currentIndex = selectedIndex
                }

                trailingActionBar {
                    actions: [
                        Action {
                            iconName: "settings"
                            text: "Settings"
                            onTriggered: mainStack.push( Qt.resolvedUrl("SettingsPage.qml"))
                        }
                    ]
                }
            }


    VisualItemModel {
        id: homePageTabs
        Item{
            id: tabPlaylists
            
            width: homePageTabView.width
            height: homePageTabView.height

            ListView {
                id: tabPlayListListView
                
                anchors {
                    fill: parent
                }
                
                model: streamingProvider.playlistsModel
                delegate: PlaylistsItem {
                    id: playListsItem

                    client: streamingProvider.client
                    onPlaylistSelected: {
                        streamingProvider.client.currentPlaylistId = playlistId
                        pageStack.push(Qt.resolvedUrl("PlaylistPage.qml"), {
                                playlistTitle: playlistTitle,
                                provider: streamingProvider
                            })
                    }         
                }

                clip: true
            }
        }

        Item{
            id: tabArtists

            width: homePageTabView.width
            height: homePageTabView.height

            Label{
                text: 'Artists'
            }
        }

        Item{
            id: tabAlbums

            width: homePageTabView.width
            height: homePageTabView.height

            Label{
                text: 'Albums'
            }
        }

        Item{
            id: tabPodcasts

            width: homePageTabView.width
            height: homePageTabView.height

            Label{
                text: 'Podcasts'
            }
        }
    }

    ListView {
        id: homePageTabView

        anchors {
            fill: parent
            topMargin: homePageHeader.height
        } 

        model: homePageTabs

        currentIndex: 0

        orientation: Qt.Horizontal

        snapMode: ListView.SnapOneItem

        onCurrentIndexChanged: homePageHeaderSections.selectedIndex = currentIndex
   }
}