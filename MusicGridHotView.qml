import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml 2.12

Item{
    property alias list: gridRepeater.model

    Grid{
        id: gridLayout
        anchors.fill: parent
        columns: 5
        Repeater{
            id: gridRepeater
            Frame{
                padding: 10
                width: parent.width*0.2
                height: parent.width*0.2+30
                background: Rectangle{
                    id: background
                    color: "#00000000"
                }
                clip: true

                MusicRoundImage{
                    id: img
                    width: parent.width
                    height: parent.width
                    imgSource: modelData.coverImgUrl

                }

                Text{
                    height: 30
                    anchors{
                        top: img.bottom
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: parent.width
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData.name
                    elide: Qt.ElideMiddle
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        background.color = "#50000000"
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                }
            }
        }
    }
}
