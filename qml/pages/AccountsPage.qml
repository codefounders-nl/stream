import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Account 1.0
import ".."

PageBase {
    id: accountsPage

    showBottomMenu : false

    pageHeader.title: i18n.tr('Accounts')

    Component.onCompleted: {
        // refresh model and view
        listview.model = null
        AccountModel.refresh();
        listview.model = AccountModel
    }

    Column {

        anchors {
            top: pageHeader.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        spacing: units.gu(1)

        ListView {
            id: listview

            width: parent.width;
            height: parent.height - addAccountsButton.height - units.gu(2)

            model: AccountModel
 
            delegate: SettingsItem {
                        onSettingSelected: {
                            console.debug("settingType:",settingType, "; settingName:", settingName)
                            generalSettings.currentAccount = settingName;
                            mainStack.clear()
                            mainStack.push( Qt.resolvedUrl("HomePage.qml"),{
                                streamingProvider:  provider,
                                pageStack: mainStack
                            })
                        }
                    }
            clip: true
        }

        Button{
            id: addAccountsButton

            width: parent.width - units.gu(4)

            text: 'Add account...'

            onClicked: mainStack.push( Qt.resolvedUrl("AddAccountPage.qml"))

            anchors{
                horizontalCenter: parent.horizontalCenter
             }
        }
    }
    Component{
        id: deleteDialog
        

        Dialog{
            id: deleteConfirm
            //ffonthouden string
            property string accountToDelete
            title: deleteAccount
            text: accountToDelete+'Are you sure you want to delete this account from Stream? If it’s the only account you’re signed in to, you’ll have to sign in to another account to keep using Stream.'
            Button{
                text: 'Delete Account'
                color: UbuntuColors.red

            }
            Button{
                text: 'Cancel'
                onClicked: PopupUtils.close(deleteConfirm)
            }
        }
    }
}