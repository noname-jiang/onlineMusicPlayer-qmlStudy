import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Shapes 1.12
import QtQml 2.12

Frame{

    property var musicList: []
    property int all: 0
    property int pageSize: 60
    property int current: 0

    signal loadMore(int offset, int current)

    onMusicListChanged: {
        listViewModel.clear()
        listViewModel.append(musicList)
    }

    Layout.fillWidth: true
    Layout.fillHeight:true
    clip: true
    padding: 0
    background: Rectangle{
        color: "#00000000"
    }

    ListView{
        id: listView
        anchors.fill: parent
        anchors.bottomMargin: 40
        clip: true
        model: ListModel{
            id:listViewModel
        }
        delegate: listViewDelegate
        ScrollBar.vertical: ScrollBar{
            anchors.right: parent.right
        }
        header: listViewHeader
        highlight: Rectangle{
            /// highlight标识的是当前对象，在下面onCLicked可以显著运用
            color: "#50000000"
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
    }

    Component{
        id: listViewDelegate
        Rectangle{
            id: listViewDelegateItem
            color: "#00000000"
            height: 40
            width: listView.width

            Shape{
                /// 给每一项画一个底部线
                anchors.fill: parent
                ShapePath{
                    strokeColor: "#10000000"
                    strokeStyle: ShapePath.SolidLine
                    startX: 0
                    startY: height
                    PathLine{
                        x: 0
                        y: height
                    }
                    PathLine{
                        x: listView.width
                        y: height
                    }
                }
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    color = "#50AAAAAA"
                }
                onExited: {
                    color = "#00000000"
                }
                onClicked: {
                    listViewDelegateItem.ListView.view.currentIndex = index
                }

                RowLayout{
                    width: parent.width
                    height: parent.height
                    spacing: 15
                    x: 5
                    Text{
                        text: index+1+pageSize*current
                        horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width*0.05
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideRight
                    }
                    Text{
                        text: name
                        //                    horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width*0.4
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideRight
                    }
                    Text{
                        text: artist
                        //                    horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width*0.15
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideRight
                    }
                    Text{
                        text: album
                        //                    horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width*0.15
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideRight
                    }
                    Item{
                        Layout.preferredWidth: parent.width*0.1
                        RowLayout{
                            anchors.centerIn: parent
                            MusicIconButton{
                                iconSource: "qrc:/images/play-list"
                                iconHeight: 16
                                iconWidth: 16
                                toolTip: "播放"
                                onClicked: {
                                    //播放
                                }
                            }
                            MusicIconButton{
                                iconSource: "qrc:/images/favorite"
                                iconHeight: 16
                                iconWidth: 16
                                toolTip: "喜欢"
                                onClicked: {
                                    //喜欢
                                }
                            }
                            MusicIconButton{
                                iconSource: "qrc:/images/clear"
                                iconHeight: 16
                                iconWidth: 16
                                toolTip: "删除"
                                onClicked: {
                                    //删除
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component{
        id: listViewHeader
        Rectangle{
            color: "#AAAAAA"
            height: 45
            width: listView.width
            RowLayout{
                width: parent.width
                height: parent.height
                spacing: 15
                x: 5
                Text{
                    text: "序号"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.05
                    font.pointSize: 13
                    color: "black"
                    elide: Qt.ElideRight
                }
                Text{
                    text: "歌名"
                    //                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.4
                    font.pointSize: 13
                    color: "black"
                    elide: Qt.ElideRight
                }
                Text{
                    text: "歌手"
                    //                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.pointSize: 13
                    color: "black"
                    elide: Qt.ElideRight
                }
                Text{
                    text: "专辑"
                    //                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.pointSize: 13
                    color: "black"
                    elide: Qt.ElideRight
                }
                Text{
                    text: "操作"
                    //                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width*0.1
                    font.pointSize: 13
                    color: "black"
                    elide: Qt.ElideRight
                }
            }
        }
    }

    Item{
        id: pageButton
        visible: musicList.length !== 0
        width: parent.width
        height: 40
        anchors.top: listView.bottom

        ButtonGroup{
            buttons: buttons.children
        }
        RowLayout{
            id: buttons
            anchors.centerIn: parent
            Repeater{
                id: repeater
                model: 9 /*(all/pageSize)>9 ? 9 : (all/pageSize)*/
                Button{
                    Text{
                        anchors.centerIn: parent
                        text: modelData+1
                        font.pointSize: 14
                        color: checked ? "white" : "black"
                    }
                    background: Rectangle{
                        implicitHeight: 30
                        implicitWidth: 30
                        color: checked ? "grey" : "#20e9f4ff"
                        radius: 3
                    }
                    checkable: true
                    checked: modelData === current
                    onClicked: {
                        if(current===index) return
                        loadMore(index*pageSize, index)
                    }
                }
            }
        }
    }
}
