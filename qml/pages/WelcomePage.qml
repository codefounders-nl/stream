import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

PageBase {
    id: welcomePage

    anchors.fill: parent

    showBottomMenu: false

    pageHeader.title: "Stream"

    UbuntuShape {
        id: appIcon

        width: units.gu(15)
        height: units.gu(15)

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: pageHeader.bottom
            topMargin: units.gu(2)
        }

        source: Image {
                    source: Qt.resolvedUrl("../icons/stream.svg")
                }
    }

    Label {
        id: welcomeLabel

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: appIcon.bottom
            topMargin: units.gu(2)
        }

        text: "Hi there!<br>Welcome to Stream"
        textSize: Label.Large
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: introductionLabel

        width: parent.width - units.gu(4)

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: welcomeLabel.bottom
            topMargin: units.gu(1)
        }

        text: "Choose a music streaming service to get started"
        textSize: Label.Medium
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }

    Row {
        id: streamingServicesRow

        height: units.gu(8)
        width: parent.width - units.gu(4)

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: introductionLabel.bottom
            topMargin: units.gu(2)
        }

        spacing: units.gu(1)

        Image {
            id: subSonicIcon

            height: units.gu(8)
            width: units.gu(8)

            source: Qt.resolvedUrl("../icons/subsonic.png")

            MouseArea {
                anchors.fill: parent

                onClicked: mainStack.push( Qt.resolvedUrl("SubsonicLoginPage.qml"))
            }
        }
    }
}