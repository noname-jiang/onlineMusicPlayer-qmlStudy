import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml 2.12

Item{
    property alias list: gridRepeater.model

    Grid{
        id: gridLayout
        anchors.fill: parent
        columns: 3
        Repeater{
            id: gridRepeater
            Frame{
                padding: 10
                width: parent.width*0.333
                height: parent.width*0.1
                background: Rectangle{
                    id: background
                    color: "#00000000"
                }
                clip: true

                MusicRoundImage{
                    id: img
                    height: parent.width*0.25
                    width: parent.width*0.25
                    imgSource: modelData.album.picUrl
                }

                Text{
                    id: name
                    height: 30
                    width: parent.width*0.72
                    anchors{
                        left: img.right
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                        bottomMargin: 10
                        leftMargin: 5
                    }
                    font.pointSize: 12
                    text: modelData.album.name
                    elide: Qt.ElideMiddle
                }

                Text{
                    height: 30
                    width: parent.width*0.72
                    anchors{
                        left: img.right
                        top: name.bottom
                        leftMargin: 5
                    }
                    font.pointSize: 8
                    text: modelData.artists[0].name
                    elide: Qt.ElideRight
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
