import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml 2.12

Frame{

    property int current: 0
    property alias bannerList: bannerView.model //第一种实现方式使用
//    property var bannerList: []  //第二种实现方式使用

    background: Rectangle{
        color: "#00000000"
    }

    /// 第一种实现方式
    PathView{
        id: bannerView
        width: parent.width
        height: parent.height

        clip: true


        delegate: Item{
            id: delegateItem
            width: bannerView.width * 0.7
            height: bannerView.height
            z: PathView.z?PathView.z:0
            scale: PathView.scale?PathView.scale:0
            MusicRoundImage{
                id: image
                imgSource: modelData.imageUrl
                width: delegateItem.width
                height: delegateItem.height
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    bannerTimer.stop()
                }
                onExited: {
                    bannerTimer.start()
                }
                onClicked: {
                    if(bannerView.currentIndex === index){

                    }else{
                        bannerView.currentIndex = index
                    }
                }
            }
        }

        pathItemCount: 3
        path: bannerPath
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Path{
        id: bannerPath
        startX: 0
        startY: bannerView.height/2 - 15

        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}

        PathLine{
            x: bannerView.width/2
            y: bannerView.height/2 - 15
        }

        PathAttribute{name:"z";value:2}
        PathAttribute{name:"scale";value:0.85}

        PathLine{
            x: bannerView.width
            y: bannerView.height/2 - 15
        }

        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}
    }

    PageIndicator{
        id: indicator
        anchors{
            top: bannerView.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: -15
        }
        count: bannerView.count
        currentIndex: bannerView.currentIndex
        spacing: 10
        delegate: Rectangle{
            width: 20
            height: 5
            radius: 5
            color: index === bannerView.currentIndex?"black":"gray"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    bannerTimer.stop()
                    bannerView.currentIndex = index
                }
                onExited: {
                    bannerTimer.start()
                }
            }
        }
    }

    Timer{
        id: bannerTimer
        running: true
        repeat: true
        interval: 2000
        onTriggered: {
            if(bannerList.length > 0)
                bannerView.currentIndex = (bannerView.currentIndex+1)%bannerView.count
        }
    }


    /// 第二种实现方式
//    MouseArea{
//        anchors.fill: parent
//        hoverEnabled: true
//        cursorShape: Qt.PointingHandCursor
//        onEntered: {
//            bannerTimer.stop()
//        }
//        onExited: {
//            bannerTimer.start()
//        }
//    }

//    MusicRoundImage{
//        id:leftImage
//        anchors{
//            left: parent.left
//            verticalCenter: parent.verticalCenter
//        }
//        width:parent.width*0.6*0.8
//        height:parent.height*0.8*0.8
//        imgSource: getLeftImageSrc()

//        MouseArea{
//            anchors.fill: parent
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if(bannerList.length>0)
//                    current = current==0?bannerList.length-1:current-1
//            }
//        }
//        onImgSourceChanged: {
//            leftImageAnim.start()
//        }
//        NumberAnimation{
//            id: leftImageAnim
//            target: leftImage
//            property: "scale"
//            from: 0.8
//            to: 1.0
//            duration: 200
//        }
//    }

//    MusicRoundImage{
//        id:centerImage
//        z:2
//        anchors.centerIn: parent
//        width:parent.width*0.6
//        height:parent.height*0.8
//        imgSource: getCenterImageSrc()
//        MouseArea{
//            anchors.fill: parent
//            cursorShape: Qt.PointingHandCursor
//        }
//        onImgSourceChanged: {
//            centerImageAnim.start()
//        }
//        NumberAnimation{
//            id: centerImageAnim
//            target: centerImage
//            property: "scale"
//            from: 0.8
//            to: 1.0
//            duration: 200
//        }
//    }

//    MusicRoundImage{
//        id:rightImage
//        anchors{
//            right: parent.right
//            verticalCenter: parent.verticalCenter
//        }
//        width:parent.width*0.6*0.8
//        height:parent.height*0.8*0.8
//        imgSource: getRightImageSrc()

//        MouseArea{
//            anchors.fill: parent
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if(bannerList.length>0)
//                    current = current==bannerList.length-1?0:current+1
//            }
//        }
//        onImgSourceChanged: {
//            rightImageAnim.start()
//        }
//        NumberAnimation{
//            id: rightImageAnim
//            target: rightImage
//            property: "scale"
//            from: 0.8
//            to: 1.0
//            duration: 200
//        }
//    }
//    PageIndicator{
//        anchors{
//            top: centerImage.bottom
//            horizontalCenter: parent.horizontalCenter
//        }
//        count: bannerList.length
//        interactive: true
//        onCurrentIndexChanged: {
//            current = currentIndex
//        }
//        delegate: Rectangle{
//            width: 20
//            height: 5
//            radius: 5
//            color: current===index?"black":"grey"
//            MouseArea{
//                anchors.fill: parent
//                cursorShape: Qt.PointingHandCursor
//                hoverEnabled: true
//                onEntered: {
//                    bannerTimer.stop()
//                    current = index
//                }
//                onExited: {
//                    bannerTimer.start()
//                }
//            }
//        }
//    }

//    Timer{
//        id: bannerTimer
//        running: true
//        interval: 2000
//        repeat: true
//        onTriggered: {
//            if(bannerList.length>0)
//                current = current==bannerList.length-1?0:current+1
//        }
//    }

//    function getLeftImageSrc(){
//        return bannerList.length?bannerList[(current-1+bannerList.length)%bannerList.length].imageUrl:""
//    }

//    function getCenterImageSrc(){
//        return bannerList.length?bannerList[current].imageUrl:""
//    }

//    function getRightImageSrc(){
//        return bannerList.length?bannerList[(current+1+bannerList.length)%bannerList.length].imageUrl:""
//    }
}
