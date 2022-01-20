import QtQuick 2.7
import Ubuntu.Components 1.3
import QtMultimedia 5.4


Page {
    id: homePage

    property string streamingProvider

    header: PageHeader {
                id: homePageHeader

                title: i18n.tr('Stream')
                subtitle: i18n.tr(streamingProvider)

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
            }


    VisualItemModel {
        id: homePageTabs
        Item{
            id: tabPlaylists
            
            width: homePageTabView.width
            height: homePageTabView.height

            Label{
                text: 'Playlists'
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
            bottomMargin: bottomMenu.height
        } 

        model: homePageTabs

        currentIndex: 0

        orientation: Qt.Horizontal

        snapMode: ListView.SnapOneItem

        onCurrentIndexChanged: homePageHeaderSections.selectedIndex = currentIndex

    }









}