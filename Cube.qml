/****************************************************************************
**
** Copyright (C) 2024 Endolrizon.
** Contact: --
**
** This file is part of Game2048.
**
** GNU Lesser General Public License Usage
** Game2048 is free software: you can redistribute it and/or modify
** it under the terms of the GNU Lesser General Public License as published by
** the Free Software Foundation; either version 3 of the License, or
** (at your option) any later version.
**
** Game2048 is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU lesser General Public License for more details.
**
** You should have received a copy of the GNU Lesser General Public License
** along with Game2048.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/
/****************************************************************************
Opis: Cube.qml
Zastowowanie: Klas tworząca pojedynczą komórkę w polu gry. Komórka składa
się z głównego Rectangla QML oraz Text QML.

Cube ma kształty kwadratu i można w nim modyfikować rozmiary, teksty,
kolor tła, kolor ramki oraz wielkość ramki.
****************************************************************************/
import QtQuick 6.7

Rectangle {
    id: backgroundCube

    property int minPointSize: 12           //Przechowuje minimalną wielkość tekstu dla obiektu.
    property int maxPointSize: 200          //Przechowuje maksymalną wielkość tekstu dla obiektu.
    property string fontfamily: "Segoe UI"  //Przechowuje nazwę czcionki tekstu dla obiektu.
    property string fontColor: "#000000"    //Przechowuje kolor tekstu dla obiektu.
    property string text: ""                //Przechowuje wartość wyświetlanego tekstu przez obiekty Text QML.


    color: "#ffffff"            //Domyślny kolor tła
    border.color: "#000000"     //Domyślny kolor ramki
    border.width: 10            //Domyślna wielkość ramki


    Text {
        id: textCube
        width: parent.width - parent.border.width * 2
        height: parent.height - parent.border.width * 2

        anchors.centerIn: parent

        text: parent.text
        minimumPointSize: parent.minPointSize
        font.pointSize: parent.maxPointSize
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: parent.fontfamily
        color: parent.fontColor
    }
}
