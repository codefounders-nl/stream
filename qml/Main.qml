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

    Component.onCompleted: mainStack.push( Qt.resolvedUrl("pages/HomePage.qml"), {
                                streamingProvider:  provider,
                                pageStack: mainStack
                            })

    PageStack {
        id: mainStack

        anchors.fill: parent
    }

    SubsonicProvider {
        id: provider
    }

    PlayerPage {
        id: playerPage
        
        visible: false
    }
}
