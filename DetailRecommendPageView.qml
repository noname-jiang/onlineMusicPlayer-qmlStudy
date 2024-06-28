import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQml 2.12

ScrollView{
    clip: true
    ColumnLayout {

        MusicBannerView{
            id:bannerView
            Layout.preferredWidth: Window.width-150
            Layout.preferredHeight: (Window.width-150)*0.3
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle{
            Layout.fillWidth: true
            width: parent.width
            height: 20
            color: "#00000000"
            Text {
                x:10
//                anchors.centerIn: parent
                verticalAlignment: Text.AlignBottom
                text: qsTr("热门歌单")
                font.pointSize: 15
            }
        }

        MusicGridHotView{
            id: hotView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width-250)*0.2*4+30*4+20
            Layout.bottomMargin: 20
        }

        Rectangle{
            Layout.topMargin: 40
            Layout.fillWidth: true
            width: parent.width
            height: 20
            color: "#00000000"
            Text {
                x:10
//                anchors.centerIn: parent
                verticalAlignment: Text.AlignBottom
                text: qsTr("新歌速递")
                font.pointSize: 15
            }
        }

        MusicGridLatestView{
            id: latestView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width-230)*0.1*10+20
            Layout.bottomMargin: 50
        }

    }


    Component.onCompleted: {
        getBannerList()
    }

    function getBannerList(){
        function onReply(reply){ //只有请求结束时才调用
            http.onReplySignal.disconnect(onReply)
            var banners = JSON.parse(reply).banners
            bannerView.bannerList = banners
            getHotList()
        }
        http.onReplySignal.connect(onReply)
        http.connet("banner")
    }

    function getHotList(){
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var playLists = JSON.parse(reply).playlists
            hotView.list = playLists
            getLatestList()
        }
        http.onReplySignal.connect(onReply)
        http.connet("top/playlist/highquality?limit=20")
    }

    function getLatestList(){
        function onReply(reply){
            http.onReplySignal.disconnect(onReply)
            var latestList = JSON.parse(reply).data
            latestView.list = latestList.slice(0, 30)
        }
        http.onReplySignal.connect(onReply)
        http.connet("top/song")
    }
}


