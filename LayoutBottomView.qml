import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle{ //底部工具栏
    Layout.fillWidth: true
    height: 60
    color: "#e0e0e0"

    RowLayout{
        anchors.fill: parent
        spacing: 0

        Item{
            Layout.fillWidth: true
            width: 40
        }

        MusicIconButton{
            iconSource: "qrc:/images/previous"
            Layout.preferredWidth: 50
            toolTip: "上一曲"
        }
        MusicIconButton{
            iconSource: "qrc:/images/stop"
            Layout.preferredWidth: 50
            toolTip: "停止播放"
        }
        MusicIconButton{
            iconSource: "qrc:/images/next"
            Layout.preferredWidth: 50
            toolTip: "下一曲"
        }

        Item{
            Layout.preferredWidth: parent.width/2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 30
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            Text{
                id:nameText
                anchors.left: musicSlider.left
                anchors.bottom: musicSlider.top
                anchors.leftMargin: 10
                text: "歌曲名-歌手名"
                font.family: "微软雅黑"
                font.pointSize: 12
            }
            Text{
                id:timeText
                anchors.right: musicSlider.right
                anchors.bottom: musicSlider.top
                anchors.rightMargin: 10
                text: "00:00/05:30"
                font.family: "微软雅黑"
                font.pointSize: 12
            }

            Slider{
                id:musicSlider
                width: parent.width
                Layout.fillWidth: true
                height: 20
                anchors.bottomMargin: 20
                background: Rectangle{
                    x: musicSlider.leftPadding
                    y: musicSlider.topPadding+(musicSlider.availableHeight-height)/2
                    width: musicSlider.availableWidth
                    height: 8
                    radius: 4
                    color: "#e9f4ef"
                    Rectangle{
                        width: musicSlider.visualPosition*parent.width
                        height: parent.height
                        color: "#73a7ab"
                        radius: 4
                    }
                }
                handle:Rectangle{
                    x: musicSlider.leftPadding+(musicSlider.availableWidth-width)*musicSlider.visualPosition
                    y: musicSlider.topPadding+(musicSlider.availableHeight-height)/2
                    width: 8
                    height: 8
                    radius: 4
                    color: "#f0f0f0"
                    border.color: "#73a7ab"
                    border.width: 0.5

                }
            }
        }


        MusicIconButton{
            iconSource: "qrc:/images/favorite"
            Layout.preferredWidth: 50
            toolTip: "喜爱"
        }
        MusicIconButton{
            icon.source: "qrc:/images/repeat"
            Layout.preferredWidth: 50
            toolTip: "重复"
        }
        Item{
            Layout.fillWidth: true
            width: 40
        }
    }
}
