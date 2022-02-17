import QtQuick 2.7
import Ubuntu.Components 1.3

PageBase {
    id: addAccountPage

    showBottomMenu : false

    pageHeader.title: i18n.tr('Add Account')

    Column{
        id: addAccountColumn

        anchors {
            topMargin: pageHeader.height
            fill: parent
        }

        ListItem{
            id: subSonicListItem

            onClicked: mainStack.push( Qt.resolvedUrl("SubsonicLoginPage.qml"))

            Image {
                id: subSonicIcon

                height: units.gu(2.5)
                width: units.gu(2.5)

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: units.gu(2)
                }

                source: Qt.resolvedUrl("../icons/subsonic.png")
            }
            Label{
                id: subSonicLabel
                
                text: 'SubSonic'

                anchors{
                    verticalCenter: parent.verticalCenter
                    left: subSonicIcon.right
                    leftMargin: units.gu(1) 
                }
            }
            Icon{
                name: 'next'

                height: units.gu(2.5)
                width: units.gu(2.5)

                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: units.gu(2)    
                }
            }  
        }
    }
}