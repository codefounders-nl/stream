import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Account 1.0

ListItem {
    id: settingItem

    height: units.gu(9)

    signal settingSelected(string settingName, string settingType)

    leadingActions: ListItemActions {
                        id: listItemActions

                        actions: [
                            Action {
                                iconName: "delete"
                                onTriggered: {
                                    accountsPage.accountToDelete = accountName
                                    PopupUtils.open(deleteDialog)
                                    console.debug("About to delete account:", accountName)                                   
                                }
                            }
                        ]
                    }
 


    onClicked: settingSelected(accountName, accountType)

    UbuntuShape {
        id: settingShape

        height: units.gu(7)
        width: height

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        // Put album art in UbuntuShape
        source: Image {
                    source: Qt.resolvedUrl("../icons/subsonic.png")
                }

        aspect: UbuntuShape.Inset
    }

    // Put labels in a 'box'
    Item {
        width: parent.width - units.gu(12)
        height: units.gu(4.5)

        anchors {
            left: settingShape.right
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: nameText

            width: parent.width - settingShape.width

            anchors {
                left: parent.left
                top: parent.top
            }

            font.bold: true
            maximumLineCount: 1
            elide: Text.ElideRight

            text: accountName
        }

        Label {
            id: usernameText

            width: parent.width - settingShape.width

            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            maximumLineCount: 1
            elide: Text.ElideRight

            text: accountUsername
        }
    }
    Icon{
        name: 'toolkit_tick'

        visible: generalSettings.currentAccount == accountName

        height: units.gu(2.5)
        width: units.gu(2.5)

        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.gu(2)    
        }
    }
}