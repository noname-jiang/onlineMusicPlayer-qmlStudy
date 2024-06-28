import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12

ToolBar{
    padding: 0
    background: Rectangle{
        color: "#E0E0E0"
    }

    width: parent.width
    Layout.fillWidth: true

    RowLayout{
        anchors.fill: parent
        spacing: 0

        MusicToolButton{
            icon.source: "qrc:/images/music"
            toolTip: "空名"
        }
        MusicToolButton{
            icon.source: "qrc:/images/about"
            toolTip: "关于"
            onClicked: {
                aboutPop.open()
            }
        }
        MusicToolButton{
            id:smallWindow
            icon.source: "qrc:/images/small-window"
            toolTip: "小窗播放"
            onClicked: {
                setWindowSize(350, 500)

                normalWindow.visible = true
                smallWindow.visible = false
            }
        }
        MusicToolButton{
            id:normalWindow
            icon.source: "qrc:/images/exit-small-window"
            toolTip: "退出小窗"
            visible : false
            onClicked: {
                setWindowSize()
                normalWindow.visible = false
                smallWindow.visible = true
            }
        }
        Rectangle{
            x: -1
            color: "#efefef"
        }
        Text{
            Layout.fillWidth: true
            text: qsTr("空名的音乐播放器")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "微软雅黑"
            font.pointSize: 14
        }

        MusicToolButton{
            icon.source: "qrc:/images/minimize-screen"
            toolTip: "最小化"
            onClicked: {
                window.visibility = Window.Minimized
            }
        }
        MusicToolButton{
            id:fullWindow
            icon.source: "qrc:/images/full-screen"
            toolTip: "全屏播放"
            onClicked: {
                window.visibility = Window.Maximized
                fullWindow.visible = false
                exitFullWindow.visible = true
            }
        }
        MusicToolButton{
            id:exitFullWindow
            icon.source: "qrc:/images/small-window"
            toolTip: "退出全屏"
            visible: false
            onClicked: {
                window.visibility = Window.Windowed
                fullWindow.visible = true
                exitFullWindow.visible = false
            }
        }
        MusicToolButton{
            icon.source: "qrc:/images/power"
            toolTip: "退出"
            onClicked: {
                window.close()
            }
        }
    }

    Popup{
        id: aboutPop

        parent: overlay
        x: (parent.width-width)/2
        y: (parent.height-height)/2

        width: 400
        height: 360

        background: Rectangle{
            color:"#6080CBC4"
            radius: 10
        }

        contentItem: ColumnLayout{
            Text {
                text: qsTr("关于")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 30
                font.bold: true
            }
            Image {
                Layout.preferredHeight: 100
                Layout.fillWidth: true
                source: "qrc:/images/Pika"
                fillMode: Image.PreserveAspectFit
            }
            Text {
                text: qsTr("空名的音乐播放器")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.bold: true
            }
            Text {
                text: qsTr("QML简单学习项目")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.bold: true
            }
            Text {
                text: qsTr("作者：NonamePika（空名）")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.bold: true
            }
            Text {
                text: qsTr("参考B站UP续加仪的教学视频制作完成")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.bold: true
            }
            Text {
                text: qsTr("（点击其他地方关闭此界面）")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
                font.bold: true
            }
        }

    }

    function setWindowSize(width=window.mWINDOW_WIDTH, height=window.mWINDOW_HEIGHT){
        window.height = height
        window.width = width
        window.x=(Screen.desktopAvailableWidth-window.width)/2
        window.y=(Screen.desktopAvailableHeight-window.height)/2
    }

}
