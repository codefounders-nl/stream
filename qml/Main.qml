import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0
import Qt.labs.platform 1.0

import Account 1.0

import "pages"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'stream.slft'
    automaticOrientation: true
    Settings{
        id: generalSettings

        category: "General"
        property bool darkMode: false
        property string currentAccount

        onDarkModeChanged: Theme.name = darkMode ? "Ubuntu.Components.Themes.SuruDark" : "Ubuntu.Components.Themes.Ambiance"
        onCurrentAccountChanged: provider.settings.category = currentAccount

        Component.onCompleted: {
            console.debug( "CurrentAccount: ", currentAccount, "; Accounts#: ", AccountModel.rowCount())
            if (currentAccount == "" && AccountModel.rowCount() > 0) {
                currentAccount = AccountModel.get(0).name;
            }
        }
    }

    width: units.gu(45)
    height: units.gu(75)

    Component.onCompleted: {
        mainStack.push( Qt.resolvedUrl("pages/PodcastPage.qml"))
     /*   
        if (provider.settings.needsCredentials())
            mainStack.push( Qt.resolvedUrl("pages/WelcomePage.qml"))
        else
            mainStack.push( Qt.resolvedUrl("pages/HomePage.qml"), {
                                streamingProvider:  provider,
                                pageStack: mainStack
                            })
    */
    }
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
        visible: title != "" && mainStack.currentPage.showBottomMenu

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
        settings.category: generalSettings.currentAccount
    }

    PlayerPage {
        id: playerPage
        
        visible: false
    }
}
