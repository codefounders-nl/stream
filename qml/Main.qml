import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
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
            
            model: TestModel {}
            delegate: PlaylistItem {}

            clip: true
        }

        BottomMenu {
            id: bottomMenu

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    PlayerPage {
        id: playerPage

        visible: false
    }
}
