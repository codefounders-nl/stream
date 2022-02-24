import QtQuick 2.7
import Ubuntu.Components 1.3

PageBase {
    id: settingsPage

    showBottomMenu : false

    pageHeader.title: i18n.tr('Settings')

    Column{
        id: tabSettingsColumn
        
        anchors {
            topMargin: pageHeader.height
            fill: parent
        }

        ListItem{
            id: accountsItem

            onClicked: mainStack.push( Qt.resolvedUrl("AccountsPage.qml"))

            Label{
                text: 'Accounts'

                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: units.gu(2)
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
        ListItem{
            id: darkModeListItem

            Label{

                text: 'Dark Mode'

                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: units.gu(2)
                }
            }

            Switch{
                checked: generalSettings.darkMode
                onCheckedChanged: generalSettings.darkMode = checked
                
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: units.gu(2)
                } 
            }
        }        
    }
}