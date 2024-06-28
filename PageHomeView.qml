import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQml 2.12


RowLayout{
    spacing: 0

    property int defaultIndex: 1
    property var qmlList: [
        {icon:"recommend-white", value:"推荐内容", qml:"DetailRecommendPageView"},
        {icon:"cloud-white", value:"搜索音乐", qml:"DetailSearchPageView"},
        {icon:"local-white", value:"本地音乐", qml:"DetailLocalPageView"},
        {icon:"history-white", value:"播放历史", qml:"DetailHistoryPageView"},
        {icon:"favorite-big-white", value:"我喜欢的", qml:"DetailFavoritePageView"}
    ]

    Frame{ //主体右边框架
        padding: 0 //取消间隔
        Layout.preferredWidth: mPAGE_HOME_WIDTH
        Layout.fillHeight: true
        background: Rectangle{
            color: "#757575"
        }

        ColumnLayout{
            anchors.fill: parent

            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                MusicRoundImage{
                    anchors.centerIn: parent
                    borderRadius: 100
                    height: 100
                    width: 100
                }
            }
            ListView{
                id:listView
                height: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: true
                model:ListModel{
                    id:listViewModel
                }
                delegate: menuViewDelegate
                highlight: Rectangle{
                    color: "#000000"
                    radius: 10
                }
            }
        }

        Component{
            id:menuViewDelegate
            Rectangle{
                id: menuViewDelegateItem
                height: 40
                width: mPAGE_HOME_WIDTH
                color: "#70757575"
                radius: 10
                RowLayout{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing: 10
                    Image{
                        source: "qrc:/images/"+icon
                        Layout.leftMargin: 20
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                    }
                    Text{
                        text:value
                        Layout.leftMargin: 10
                        Layout.fillWidth: true
                        height: 50
                        font.pointSize: 12
                        color: "white"
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        color= "#50ffffff"
                    }
                    onExited: {
                        color= "#50757575"
                    }
                    onClicked: {
                        repeater.itemAt(menuViewDelegateItem.ListView.view.currentIndex).visible = false
                        menuViewDelegateItem.ListView.view.currentIndex = index
                        var loader = repeater.itemAt(index)
                        loader.visible = true
                        loader.source = qmlList[index].qml+".qml"
                    }
                }
            }
        }
        Component.onCompleted: {
            listViewModel.append(qmlList)
            /// defaultIndex=1是为了方便调试
            /// loader直接加载第几个页面，例如itemAt(0)就是“推荐内容”页面
            var loader = repeater.itemAt(defaultIndex)
            loader.visible = true
            loader.source = qmlList[defaultIndex].qml+".qml"
        }
    }

    Repeater{
        id: repeater
        model: qmlList.length
        Loader{
            visible: false
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

}


