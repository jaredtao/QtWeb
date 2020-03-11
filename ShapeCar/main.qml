import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12
Item {
    id: root
    width: 400
    height: 600

    //车速
    property real speed: speedSlider.value
    //角度
    property real angle: angleSlider.value

    //车宽
    readonly property int carWidth: 100
    //车高
    readonly property int carHeight: 180
    //头宽
    readonly property int headWidth: 80
    //头高
    readonly property int headHeight: 16
    //尾宽
    readonly property int tailWidth: 60
    //尾高
    readonly property int tailHeight: 24
    //轮宽
    readonly property int wheelWidth: 16
    //轮高
    readonly property int wheelHeight: 30
    //轴高
    readonly property int axiasHeight: 6
    //前轴Y中心
    readonly property int frontAxiasYCenter: 36
    //后轴Y中心
    readonly property int backAxiasYCenter: 136
    //车尾连接杆宽度
    readonly property int tailHandleWidth: 10
    //车尾连接杆高度
    readonly property int tailHandleHeight: 10
    //车身弧高度
    readonly property int bodyArcHeight: 24
    //车身高度
    readonly property int bodyHeight: 54
    //车身Y起点
    readonly property int bodyYStart: 64
    //驾驶位Y终点
    readonly property int driverYEnd: 70
    //驾驶位高度
    readonly property int driverHeight: 30
    //驾驶位宽度
    readonly property int driverWidth: 16
    ScrollBackground {
        scrollSpeed: speed
        anchors.fill: parent
    }
    Shape {
        id: carShape
        width: carWidth
        height: carHeight
        x: (parent.width - width) / 2
        y: parent.height - height

        //抗锯齿
        //启用layer
        layer.enabled: true
        //4倍采样
        layer.samples: 8
        //平滑
        smooth: true
        //抗锯齿
        antialiasing: true

        //前轮架 矩形
        ShapePath {
            fillColor: "gray"
            startX: wheelWidth
            startY: frontAxiasYCenter - axiasHeight / 2
            PathLine { x: carWidth - wheelWidth; y: frontAxiasYCenter - axiasHeight / 2}
            PathLine { x: carWidth - wheelWidth; y: frontAxiasYCenter + axiasHeight / 2}
            PathLine { x: wheelWidth; y: frontAxiasYCenter + axiasHeight / 2}
        }
        //后轮架 矩形
        ShapePath {
            fillColor: "gray"
            startX: wheelWidth
            startY: backAxiasYCenter - axiasHeight / 2
            PathLine { x: carWidth - wheelWidth; y: backAxiasYCenter - axiasHeight / 2}
            PathLine { x: carWidth - wheelWidth; y: backAxiasYCenter + axiasHeight / 2}
            PathLine { x: wheelWidth; y: backAxiasYCenter + axiasHeight / 2}
        }

        //左后轮 矩形
        ShapePath {
            fillColor: "black"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: 0
            startY: backAxiasYCenter - wheelHeight / 2
            PathLine { x: wheelWidth; y: backAxiasYCenter - wheelHeight / 2}
            PathLine { x: wheelWidth; y: backAxiasYCenter + wheelHeight / 2}
            PathLine { x: 0; y: backAxiasYCenter + wheelHeight / 2}
        }
        //右后轮 矩形
        ShapePath {
            fillColor: "black"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: carWidth - wheelWidth
            startY: backAxiasYCenter - wheelHeight / 2
            PathLine { x: carWidth; y: backAxiasYCenter - wheelHeight / 2}
            PathLine { x: carWidth; y: backAxiasYCenter + wheelHeight / 2}
            PathLine { x: carWidth - wheelWidth; y: backAxiasYCenter + wheelHeight / 2}
        }
        //车头 矩形
        ShapePath {
            fillColor: "green"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: (carWidth - headWidth) / 2
            startY: 0
            PathLine { x: carWidth - (carWidth - headWidth) / 2; y: 0}
            PathLine { x: carWidth - (carWidth - headWidth) / 2; y: headHeight}
            PathLine { x: (carWidth - headWidth) / 2; y: headHeight}
        }

        //车尾 矩形
        ShapePath {
            fillColor: "green"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: (carWidth - tailWidth) / 2
            startY: carHeight - tailHeight
            PathLine { x: carWidth - (carWidth - tailWidth) / 2; y: carHeight - tailHeight}
            PathLine { x: carWidth - (carWidth - tailWidth) / 2; y: carHeight}
            PathLine { x: (carWidth - tailWidth) / 2; y: carHeight}
        }
        //车尾连接杆 矩形
        ShapePath {
            fillColor: "green"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: (carWidth - tailHandleWidth) / 2
            startY: carHeight - tailHeight - tailHandleHeight
            PathLine { x: carWidth - (carWidth - tailHandleWidth) / 2; y: carHeight - tailHeight - tailHandleHeight}
            PathLine { x: carWidth - (carWidth - tailHandleWidth) / 2; y: carHeight - tailHeight}
            PathLine { x:(carWidth - tailHandleWidth) / 2; y: carHeight - tailHeight}
        }
        //车身前弧 弓形
        ShapePath {
            fillColor: "green"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: (carWidth - headWidth) / 2
            startY: bodyYStart
            PathArc {
                x: carWidth - (carWidth - headWidth) / 2
                y: bodyYStart
                radiusX: carWidth / 2
                //测试得出的值
                radiusY: bodyYStart - bodyHeight / 2
                useLargeArc: false
            }
        }
        //车身 矩形
        ShapePath {
            fillColor: "green"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: (carWidth - headWidth) / 2
            startY: bodyYStart
            PathLine { x: carWidth - (carWidth - headWidth) / 2; y: bodyYStart}
            PathLine { x: carWidth - (carWidth - headWidth) / 2; y: bodyYStart + bodyHeight}
            PathLine { x: (carWidth - headWidth) / 2; y: bodyYStart + bodyHeight}
        }
        //龙骨 梭形 两个圆弧
        ShapePath {
            fillColor: "green"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            startX: carWidth / 2
            startY: 0
            PathArc {
                x: carWidth / 2
                y: carHeight - tailHeight
                //测试得出的值
                radiusX: carWidth / 2 - headWidth
                radiusY: carHeight / 2
                useLargeArc: false
            }
            PathArc {
                x: carWidth / 2
                y: 0
                //测试得出的值
                radiusX: carWidth / 2 - headWidth
                radiusY: carHeight / 2
                useLargeArc: false
            }
        }
        //驾驶位 矩形+半圆
        ShapePath {
            fillColor: "black"
            capStyle: ShapePath.RoundCap
            startX: (carWidth - driverWidth) / 2
            startY: driverYEnd
            PathLine {
                x: (carWidth - driverWidth) / 2
                y: driverYEnd - driverHeight / 2
            }
            PathArc {
                x: carWidth / 2 + driverWidth / 2
                y: driverYEnd - driverHeight / 2
                useLargeArc: false
                radiusX: carWidth / 2
                //测试值
                radiusY: 420
            }
            PathLine {
                x: carWidth / 2 + driverWidth / 2
                y: driverYEnd
            }
        }
    }
    //左前轮
    Item {
        anchors {
            fill: carShape
            horizontalCenterOffset: -10
        }
        Rectangle {
            id: frontLeftWheel
            width: wheelWidth
            height: wheelHeight
            radius: 2
            x: 0 + 10
            y: frontAxiasYCenter - wheelHeight / 2
            color: angle === 0 ? "black" : "blue"
            antialiasing: true
            smooth: true
            transform: Rotation {
                angle: root.angle
                origin {
                    x: frontLeftWheel.width / 2 + 10
                    y: frontLeftWheel.height / 2
                }
            }
        }
    }
    //右前轮
    Item {
        anchors {
            fill: carShape
            horizontalCenterOffset: 10
        }
        Rectangle {
            id: frontRightWheel
            width: wheelWidth
            height: wheelHeight
            radius: 2
            x: carWidth - wheelWidth - 10
            y: frontAxiasYCenter - wheelHeight / 2
            color: angle === 0 ? "black" : "blue"
            antialiasing: true
            smooth: true
            transform: Rotation {
                angle: root.angle
                origin {
                    x: frontRightWheel.width / 2 - 10
                    y: frontRightWheel.height / 2
                }
            }
        }
    }
    Column {
        anchors {
            top: parent.top
            right: parent.right
        }
        Slider {
            id: angleSlider
            from: -15
            to: 15
            value: 0
        }
        Slider {
            id: speedSlider
            from: 0
            to: 10
            value: 0
        }
    }
}

