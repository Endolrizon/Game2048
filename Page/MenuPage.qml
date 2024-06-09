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
Opis: MenuPage.qml
Zastowowanie: Klas tworzy wizualną stronę menu witającą użytkownika
uruchamiającego aplikacje.

Strona zawiera Text QML: zawierającą nazwę gry, napis start oraz najlepszy
wynik rozgrywki w tej sesji.

Aby uruchomić rozgrywkę należy dotknąć ekranu kliknąć muszką lub nacisnąć spacje.
****************************************************************************/
import QtQuick 6.7

Item {
    id: menuPageMode

    property int bestScores: 0                  //Parametry przechowuje najlepszy wyniki rozgrywki w tej sesji.
    property string bestTime: "00:00:00"        //Parametry przechowuje czas dla najlepszego wyniku w tej sesji.

    property int minPointSize: 12               //Przechowuje minimalną wielkość tekstu dla obiektu.
    property int maxPointSize: 200              //Przechowuje maksymalną wielkość tekstu dla obiektu.
    property string fontfamily: "Segoe UI"      //Przechowuje nazwę czcionki tekstu dla obiektu.
    property string fontColor: "#000000"        //Przechowuje kolor tekstu dla obiektu.

    property string backgroundColor: "#000000"  //Przechowuje kolor tekstu dla obiektu.
    property string mainColor: "#ffffff"        //Przechowuje kolor tła dla obiektu.

    /*
    Sygnał służący do inicjalizacji  nowej gry oraz ustawienia warunków
    początkowych dla nowej gry. Powinien zostać edytowany przez utworzony
    obiekty. Uwag nie jest on emitowany przez żadną metodę klas.
    */
    signal startGame

    focus: true

    onEnabledChanged: {
        if (menuPageMode.enabled === true){

            menuPageMode.focus = true
        }
    }

    Rectangle{
        id: backgroundMenuMode
        color: menuPageMode.mainColor
        anchors.fill: parent

        Text{
            id: labelNameGame
            width: parent.width * 0.95
            height: parent.height * 0.4

            anchors.bottom: labelStartGame.top
            anchors.horizontalCenter: labelStartGame.horizontalCenter

            text: qsTr("2048")
            minimumPointSize: menuPageMode.minPointSize * 1.5
            font.pointSize: menuPageMode.maxPointSize
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: menuPageMode.fontfamily
            color: menuPageMode.fontColor
        }

        Text {
            id: labelStartGame
            width: parent.width * 0.6
            height: parent.height * 0.2

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            text: qsTr("START")
            minimumPointSize: menuPageMode.minPointSize
            font.pointSize: menuPageMode.maxPointSize
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: menuPageMode.fontfamily
            color: menuPageMode.fontColor
        }

        Text{
            id: labelBestScores
            width: parent.width * 0.95
            height: parent.height * 0.4

            anchors.top: labelStartGame.bottom
            anchors.horizontalCenter: labelStartGame.horizontalCenter

            text:{
                if (menuPageMode.bestScores === 0) qsTr("")
                else qsTr("THE BEST SCORES\n" + menuPageMode.bestScores + "\n" + menuPageMode.bestTime)
            }
            minimumPointSize: menuPageMode.minPointSize
            font.pointSize: menuPageMode.maxPointSize
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: menuPageMode.fontfamily
            color: menuPageMode.fontColor
        }

    }

    TapHandler{
        id: tapHandlerMenuPage
        acceptedButtons: Qt.LeftButton
        gesturePolicy: TapHandler.ReleaseWithinBounds
        onTapped: {         
            startGame()
        }
    }

    Keys.onPressed:  (event)=> {

                         if (event.key === Qt.Key_Space) {
                             startGame()
                             event.accepted = true
                         }
                     }

}
