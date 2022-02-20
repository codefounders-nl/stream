import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Account 1.0

PageBase {
    id: subsonicLoginPage

    anchors.fill: parent

    showBottomMenu: false

    pageHeader.title: "Subsonic"

    Component.onCompleted: {
        accountNameField.text = provider.settings.category
        accountNameField.enabled = provider.settings.category == ""
        serverurlField.text = provider.settings.serverurl
        usernameField.text = provider.settings.username
        passwordField.text = provider.settings.password
    }

    Image {
        id: icon

        width: units.gu(15)
        height: units.gu(15)

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: pageHeader.bottom
            topMargin: units.gu(2)
        }

        source: Qt.resolvedUrl("../icons/subsonic.png")
    }

    Label {
        id: loginLabel

        width: parent.width - units.gu(4)

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: icon.bottom
            topMargin: units.gu(2)
        }

        text: "Please enter your server URL, username and password, to login to SubSonic"
        textSize: Label.Medium
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }

    Column {
        width: parent.width - units.gu(4)

        anchors {
            top: loginLabel.bottom
            topMargin: units.gu(2)
            bottom: parent.bottom
            bottomMargin: units.gu(2)
            horizontalCenter: parent.horizontalCenter
        }

        spacing: units.gu(1)

        Label {
            id: errorLabel

            width: parent.width
            
            anchors.horizontalCenter: parent.horizontalCenter

            color: theme.palette.normal.negative
            visible: text != ""
        }

        TextField {
            id: accountNameField

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter

            placeholderText: "Account name"
        }

        TextField {
            id: serverurlField

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter

            placeholderText: "https://mysubsonicserver.com"
        }

        TextField {
            id: usernameField

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter

            placeholderText: "Your username"
        }

        TextField {
            id: passwordField

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter

            placeholderText: "Your password"
            echoMode: TextInput.Password
        }

        Button {
            id: loginButton

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter

            color: theme.palette.normal.positive
            text: "Log in"

            onClicked: {
                var loginResult = provider.client.login(serverurlField.text, usernameField.text, passwordField.text,
                                  function(loginResult){
                                    console.log(JSON.stringify(loginResult))
                                    errorLabel.text = loginResult.errormessage
                                    if (loginResult.status == "ok") {
                                        generalSettings.currentAccount = accountNameField.text
                                        provider.settings.serverurl = serverurlField.text
                                        provider.settings.username = usernameField.text
                                        provider.settings.password = passwordField.text
                                        AccountModel.refresh();
                                        mainStack.clear()
                                        mainStack.push( Qt.resolvedUrl("HomePage.qml"),{
                                            streamingProvider:  provider,
                                            pageStack: mainStack
                                        })
                                    }
                                  })
            }
        }

        Button {
            id: cancelButton

            width: parent.width

            anchors.horizontalCenter: parent.horizontalCenter

            text: "Cancel"

            onClicked: mainStack.pop()
        }
   }
}