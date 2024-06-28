/* main.qml
* 改成App.qml有利于置顶
*/
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import MyUtils 1.0

ApplicationWindow {
    id: window

    property int mWINDOW_WIDTH: 1200
    property int mWINDOW_HEIGHT: 800
    property int mPAGE_HOME_WIDTH: 150

    width: mWINDOW_WIDTH
    height: mWINDOW_HEIGHT
    visible: true //是否显示窗口
    title: qsTr("JJY's Music Player")

    HttpUtils{
        id: http
    }


    ColumnLayout{
        anchors.fill: parent

        spacing: 0

        LayoutHeaderView{
            id:layoutHeaderView
        }

        PageHomeView{
            id:pageHomeView
        }

        LayoutBottomView{
            id:layoutBottomView
        }
    }
}
