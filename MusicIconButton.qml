import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Button{
    property string iconSource: ""
    property string toolTip: ""

    /// 是否被选中
    property bool isCheckAble: false
    property bool isChecked: false

    property int iconWidth: 32
    property int iconHeight: 32

    id:self

    icon.source: iconSource
    icon.width: iconWidth
    icon.height: iconHeight

    ToolTip.visible: hovered
    ToolTip.text: toolTip

    background: Rectangle{
        /// 点击时触发down，八位颜色前两位是透明度(值越小越透明，20就是20%)
        color: self.down || (isCheckAble && self.checked) ? "#20497563" : "#e0e0e0"
        radius: 3
    }
    icon.color: self.down || (isCheckAble && self.checked) ? "#ffffff" : "#90000000"

    checkable: isCheckAble
    checked: isChecked
}
