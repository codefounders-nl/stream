import QtQuick 2.7
import Ubuntu.Components 1.3
import QtMultimedia 5.4
import ".."


PageBase {
    id: homePage

    property var streamingProvider
    property var pageStack

    pageHeader {

        title: i18n.tr('Stream')
        subtitle: streamingProvider.name

        extension: Sections {
            id: homePageHeaderSections
            selectedIndex: generalSettings.sectionIndex

            actions: [ 
                Action {
                    text: 'Playlists'
                },
                Action {
                    text: 'Starred'
                },
                Action {
                    text: 'Podcasts'
                }
            ]

            onSelectedIndexChanged: {
                generalSettings.sectionIndex = selectedIndex
                homePageTabView.currentIndex = selectedIndex
            } 
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
            id: tabStarred

            width: homePageTabView.width
            height: homePageTabView.height

            ListView {
                id: listview

                anchors {
                    fill: parent
                }

                model: provider.starredModel
                delegate: PlaylistItem {

                            client: provider.client
                            onSongSelected: {
                                playerPage.model = provider.starredModel
                                playerPage.title = title
                                playerPage.artist = artist
                                playerPage.albumart = albumart
                                playerPage.reverse = false
                                //playerPage.player.source = source
                                playerPage.player.addSources(  provider.starredModel.toSourcesArray(), index )
                            }
                        }
                clip: true
            }
        }

        Item{
            id: tabPodcasts

            width: homePageTabView.width
            height: homePageTabView.height

            ListView {
                id: tabPodCastListView
                
                anchors {
                    fill: parent
                }
                
                model: streamingProvider.podcastsModel
                // delegate: PlaylistsItem {
                //     id: playListsItem

                //     client: streamingProvider.client
                //     onPlaylistSelected: {
                //         streamingProvider.client.currentPlaylistId = playlistId
                //         pageStack.push(Qt.resolvedUrl("PlaylistPage.qml"), {
                //                 playlistTitle: playlistTitle,
                //                 provider: streamingProvider
                //             })
                //     }         
                // }

                delegate: PodcastsItem {
                    id: podCastsItem

                    client: streamingProvider.client
                    onPodcastSelected: {
                        streamingProvider.client.currentPodcastId = podcastId
                        pageStack.push(Qt.resolvedUrl("PodcastPage.qml"), {
                                title: podcastTitle,
                                description: podcastDescription,
                                provider: streamingProvider
                            })
                    }         
                }

                clip: true
            }

        }
    }

    ListView {
        id: homePageTabView

        anchors {
            fill: parent
            topMargin: pageHeader.height
        } 

        model: homePageTabs

        currentIndex: 0

        orientation: Qt.Horizontal

        snapMode: ListView.SnapOneItem

        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: UbuntuAnimation.FastDuration

        onCurrentIndexChanged: homePageHeaderSections.selectedIndex = currentIndex
   }
}