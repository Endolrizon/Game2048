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
Opis: Main.qml
Zastowowanie: Klas główna projektu tworząca główne okno programu ( QML Windows )
i zarządzająca trybami pracy. Przełącza trybu pracy po między obiektami: MenuPage
oraz GamePage, które reprezentuje wizualną interpretacje tych trupów.
****************************************************************************/
import QtQuick 6.7

import "Page"

Window {
    id: window
    width: 480
    height: 640
    visible: true
    title: qsTr("Game 2048")

    readonly property int minPointSize: 12              //Przechowuje minimalną wielkość tekstu dla aplikacji.
    readonly property int maxPointSize: 200             //Przechowuje maksymalną wielkość tekstu dla aplikacji.
    readonly property string fontfamily: "Sagoe UI"     //Przechowuje nazwę czcionki tekstu dla aplikacji.
    readonly property string fontColor: "#FFCC00"       //Przechowuje kolor tekstu dla aplikacji.
    readonly property string backgroundColor: "#6B4226" //Przechowuje kolor tła dla aplikacji.
    readonly property string mainColor: "#A62A2A"       //Przechowuje główny kolor „motywu” dla aplikacji.

    MenuPage{
       id: menuPage
       enabled: true
       visible: true

       anchors.fill: parent

       minPointSize: window.minPointSize
       maxPointSize: window.maxPointSize
       fontfamily: window.fontfamily
       fontColor: window.fontColor

       backgroundColor: window.backgroundColor
       mainColor: window.mainColor

       onStartGame: {         
           menuPage.enabled = false; menuPage.visible = false
           gamePage.visible = true; gamePage.enabled = true
       }
    }

    GamePage{
        id: gamePage
        enabled: false
        visible: false

        anchors.fill: parent

        minPointSize: window.minPointSize
        maxPointSize: window.maxPointSize
        fontfamily: window.fontfamily
        fontColor: window.fontColor

        backgroundColor: window.backgroundColor
        mainColor: window.mainColor

        onEndGame: {
            gamePage.timeGame = "00:00:00"
            menuPage.bestScores = gamePage.bestScoresGame
            menuPage.bestTime = gamePage.bestTimeGame

            gamePage.enabled = false; gamePage.visible = false
            menuPage.visible = true; menuPage.enabled = true
        }
    }
}
