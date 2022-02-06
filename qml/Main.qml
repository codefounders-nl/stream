import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'stream.slft'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    //Component.onCompleted: mainStack.push( Qt.resolvedUrl("pages/HomePage.qml"), {
    Component.onCompleted: mainStack.push( Qt.resolvedUrl("pages/WelcomePage.qml"), {
                                streamingProvider:  provider,
                                pageStack: mainStack
                            })

    PageStack {
        id: mainStack

        anchors {
           fill: parent
           bottomMargin: bottomMenu.height
        }
    }

    BottomMenu {
        id: bottomMenu

        height: visible ? units.gu(9) : 0
        visible: title != "" && mainStack.currentPage != playerPage

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        title: playerPage.title
        artist: playerPage.artist
        albumart: playerPage.albumart
        player: playerPage.player
    }

    SubsonicProvider {
        id: provider
    }

    PlayerPage {
        id: playerPage
        
        visible: false
    }
}
