import QtQuick 2.7
import Ubuntu.Components 1.3

Page {

    property bool showBottomMenu: true
    property alias pageHeader: _header

    header: PageHeader {
        id: _header
    }

}