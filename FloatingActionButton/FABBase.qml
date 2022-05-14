/*
 * MIT License
 *
 * Copyright (c) 2022 Nikolai Gubarev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    property alias diameter: root.width
    property alias text: text.text
    property alias icon: icon.source

    signal pressed()
    signal released()
    signal clicked()

    width: 50
    height: width

    Rectangle {
        id: background

        anchors.fill: parent

        radius: root.diameter / 2
        color: "#6E14EF"

        visible: false
    }

    Image {
        id: icon

        anchors.fill: background

        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    OpacityMask {
        id: iconSource

        anchors.fill: background

        source: icon
        maskSource: background
    }

    ShaderEffectSource {
        id: bgSource

        anchors.fill: background

        sourceItem: root.icon != "" ? iconSource : background
        onSourceItemChanged: console.log(root.icon, sourceItem)
        visible: false
    }

    DropShadow {
        anchors.fill: background
        source: bgSource
        color: "gray"
        verticalOffset: background.radius / 2
        radius: background.radius
        samples: 17
    }

    ShaderEffect {
        id: highlight

        property real radius: background.radius
        property real touchRadius
        property real touchAlpha: 0.5
        property point lastTouch
        property point center: Qt.point(radius, radius)
        property variant src: bgSource

        anchors.fill: background

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;

            uniform highp vec2 lastTouch;
            uniform highp vec2 center;
            uniform mediump float radius;
            uniform mediump float touchRadius;
            uniform lowp float touchAlpha;
            uniform lowp float qt_Opacity;
            uniform sampler2D src;

            void main() {
                highp float dist = touchRadius - distance(lastTouch, gl_FragCoord.xy);
                highp float maxDist = radius - distance(center, gl_FragCoord.xy);
                lowp vec4 col = texture2D(src, qt_TexCoord0);
                if (dist >= 0. && maxDist >= 0.) {
                    col = mix(col, vec4(1., 1., 1., 1.), touchAlpha);
                }
                gl_FragColor = col * qt_Opacity;

            }"

        // Maps gl_FragCoord from scene coordinates to the item coordinates
        layer.enabled: true

        states: [
            State { name: "touched" }
        ]

        transitions: [
            Transition {
                from: ""
                to: "touched"

                ParallelAnimation {
                    NumberAnimation {
                        target: highlight
                        property: "touchAlpha"
                        to: 0.25
                        duration: 100
                    }
                    NumberAnimation {
                        target: highlight
                        property: "touchRadius"
                        to: background.width * 1.1
                        duration: 150
                    }
                }
            },

            Transition {
                from: "touched"
                to: ""

                SequentialAnimation {
                    NumberAnimation {
                        target: highlight
                        property: "touchAlpha"
                        to: 0
                    }
                    ScriptAction { script: { highlight.touchRadius = 0 } }
                }
            }
        ]
    }

    Text {
        id: text
        anchors.centerIn: parent

        font.pixelSize: background.radius
        color: "white"
        text: "+"
    }

    MouseArea {
        anchors.fill: background
        onPressed: {
            highlight.lastTouch = Qt.point(mouse.x, mouse.y)
            highlight.state = "touched"
            root.pressed()
        }
        onReleased: {
            highlight.state = ""
            root.released()
        }
        onClicked: {
            root.clicked()
        }
    }
}
