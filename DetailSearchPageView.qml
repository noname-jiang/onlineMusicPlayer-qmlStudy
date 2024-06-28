import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

ColumnLayout{
    RowLayout{

        Layout.fillWidth: true
        Layout.leftMargin: 5
        Layout.topMargin: 5


        TextField{
            id: searchInput
            font.pointSize: 12
            selectByMouse: true
            selectionColor: "#999999"
            placeholderText: qsTr("请输入搜索关键字")
            color: "#000000"

            background: Rectangle{
                color: "#00000000"
                border.color: "black"
                border.width: 1
                opacity: 0.5
                implicitHeight: 35
                implicitWidth: 600
            }
            focus: true
            Keys.onPressed: if(event.key===Qt.Key_Enter||event.key===Qt.Key_Return) doSearch()
        }

        MusicIconButton{
            iconSource: "qrc:/images/search"
            toolTip: "搜索"
            onClicked: {
                doSearch()
            }
        }
    }

    MusicListView{
        id: musicListView
        onLoadMore: doSearch(offset, current)
    }

    function doSearch(offset = 0, current = 0){
        var keywords = searchInput.text
        if(keywords.length <= 0) return
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            musicListView.current = current
            var result = JSON.parse(reply).result
            var songsList = result.songs
            musicListView.all = result.songCount
            /// map方法和箭头函数=>都是JS里的方法，一般搭配使用
            /// map生成新数组,这里类型为[{"id":v1,"name":v2,"artist":v3,"album":v4}{...}]JSON数组，直接调用id即可获得v1
            /// item是遍历songList获取的每一个元素,并当做参数传入=>函数，=>函数返回{id:item.id,...}这样JSON类型
            musicListView.musicList = songsList.map(item=>{
                                                        return {
                                                            id: item.id,
                                                            name: item.name,
                                                            artist: item.artists[0].name,
                                                            album: item.album.name
                                                        }
                                                    })
        }
        http.onReplySignal.connect(onReply)
        http.connet("search?keywords="+keywords+"&offset="+offset+"&limit=60")
    }


}
