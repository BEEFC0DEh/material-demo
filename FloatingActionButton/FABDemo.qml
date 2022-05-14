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

Item {
    id: root

    width: 300
    height: 500

    ListModel {
        id: model

        ListElement {
            text: "1"
            icon: "https://static.wikia.nocookie.net/memes9731/images/d/da/IA2G3ORVG.jpg/revision/latest/scale-to-width-down/250?cb=20200528160845&path-prefix=ru"
        }

        ListElement {
            text: "2"
            icon: "https://avatanplus.com/files/resources/original/5791db7e03bbf15611c1643f.png"
        }

        ListElement {
            text: "3"
            icon: "https://memepedia.ru/wp-content/uploads/2019/12/screenshot_22-1.png"
        }

        ListElement {
            text: "4"
            icon: "https://www.meme-arsenal.com/memes/f4ea27de0c4f8ab0c50f3264cb66d06c.jpg"
        }
    }

    FAB {
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            right: parent.right
            rightMargin: 20
        }

        diameter: 100
        model: model
    }
}
