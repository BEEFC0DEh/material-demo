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

import QtQuick 2.6

FABBase {
    id: root
    property alias model: repeater.model

    onClicked: model ? model = null : model = 5

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: -height
        }

        spacing: 20
        bottomPadding: spacing

        Repeater {
            id: repeater

            delegate: FABBase {
                diameter: root.diameter * 0.8
                icon: "https://static.wikia.nocookie.net/memes9731/images/d/da/IA2G3ORVG.jpg/revision/latest/scale-to-width-down/250?cb=20200528160845&path-prefix=ru"
                text: index

                onClicked: console.log("clicked", index)
            }
        }
    }
}
