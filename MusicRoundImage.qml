import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.13

Item {
    property string imgSource: "qrc:/images/player"
    property int borderRadius: 5

    Image{
        id: image
        anchors.centerIn: parent
        source: imgSource
        visible: false
        smooth: true
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        antialiasing: true //去除锯齿
    }
    Rectangle{
        id: mask
        color: "black"
        anchors.fill: parent
        visible: false
        smooth: true
        radius: borderRadius
    }

    OpacityMask{
        anchors.fill: parent
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }

}
