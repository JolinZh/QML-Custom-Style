import QtQuick 2.9
import QtQuick.Controls 2.2

BusyIndicator {
    id: control

    contentItem: Item {
        implicitWidth: 64   //圈圈背景是个矩形，此属性为宽度
        implicitHeight: 64  //圈圈背景是个矩形，此属性为高度

        Item {
            id: item
            x: parent.width / 2 - 32
            y: parent.height / 2 - 32
            width: 64   //圈圈自身的宽度，如果比背景的宽度大的话，圈圈会显示不全
            height: 64  //圈圈自身的高度，如果比背景的高度大的话，圈圈会显示不全
            opacity: control.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 250
                }
            }

            RotationAnimator {
                target: item
                running: control.visible && control.running
                from: 0     //旋转的角度，从0到360度
                to: 360
                loops: Animation.Infinite   //循环次数，Infinite表示无限次，可以改成数字比如5
                duration: 1250  //每转一圈需要的时间
            }

            //下面的转换比较麻烦，一般改下颜色就行了
            Repeater {
                id: repeater
                model: 6

                Rectangle {
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - height / 2
                    implicitWidth: 10
                    implicitHeight: 10
                    radius: 5
                    color: "#21be2b"    //圆圈上每个点点的颜色
                    transform: [
                        Translate {
                            y: -Math.min(item.width, item.height) * 0.5 + 5
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: 5
                            origin.y: 5
                        }
                    ]
                }
            }
        }
    }
}
