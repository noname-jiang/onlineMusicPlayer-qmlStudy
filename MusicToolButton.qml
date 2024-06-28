import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

ToolButton{
    property string iconSource: ""
    property string toolTip: ""

    /// 是否被选中
    property bool isCheckAble: false
    property bool isChecked: false

    id:self

    ToolTip.visible: hovered
    ToolTip.text: toolTip

    background: Rectangle{
        color: self.down || (isCheckAble && self.checked) ? "#20497563" : "#e0e0e0"
    }
    icon.color: self.down || (isCheckAble && self.checked) ? "#00ffffff" : "#90000000"

    checkable: isCheckAble
    checked: isChecked
}
