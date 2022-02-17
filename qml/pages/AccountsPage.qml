import QtQuick 2.7
import Ubuntu.Components 1.3

PageBase {
    id: accountsPage

    showBottomMenu : false

    header : PageHeader {
                id: accountsPageHeader
                title: i18n.tr('Accounts')
            }
    Button{
        id: addAccountsButton

        width: parent.width - units.gu(4)

        text: 'Add account...'

        onClicked: mainStack.push( Qt.resolvedUrl("AddAccountPage.qml"))

        anchors{
            horizontalCenter: parent.horizontalCenter
            top: accountsPageHeader.bottom
            topMargin: units.gu(2)
        }
    }

}