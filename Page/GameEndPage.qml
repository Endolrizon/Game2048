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
Opis: GameEndPage.qml
Zastowowanie: Klas tworzy wizualną stronę zakończenia rozgrywki w której
została podsumowana obecna rozgrywka i porównana do najlepszej rozgrywki w tej sesji.

Strona zawiera Text QML: zwierający informacje o przegranej lub wygranej,
wynik i czas obecnej rozgrywki oraz wynik i czas najlepszej rozgrywki w tej sesji.

Aby zaakceptować informacje i wrócić do menu  należy dotknąć ekranu
kliknąć muszką lub nacisnąć spacje.
****************************************************************************/
import QtQuick 6.7

Item{
    id: gameEndPageMode

    property int  bestScoresGame: 0             //Parametry przechowuje najlepszy wyniki rozgrywki w tej sesji.
    property int  scoresGame: 0                 //Parametry przechowuje aktualny wyniki rozgrywki.
    property string bestTimeGame: "00:00:00"    //Parametry przechowuje czas dla najlepszego wyniku w tej sesji.
    property string timeGame: "00:00:00"        //Parametry przechowuje czas dla aktualnej rozgrywki.
    property string textGameEnd: ""             //Parametry przechowuje informacje o zwycięstwie lub przegranej.

    property int minPointSize: 12               //Przechowuje minimalną wielkość tekstu dla obiektu.
    property int maxPointSize: 200              //Przechowuje maksymalną wielkość tekstu dla obiektu.
    property string fontfamily: "Segoe UI"      //Przechowuje nazwę czcionki tekstu dla obiektu.
    property string fontColor: "#000000"        //Przechowuje kolor tekstu dla obiektu.

    property string backgroundColor: "#ffffff"  //Przechowuje kolor tła dla obiektu.

    /*
    Sygnał jest emitowany kiedy użytkowni wejdzie w interakcje ze stroną poprzez
    kliknięcie myszą, dotknięcie palce lub naciśnięcie na klawiaturze spacji.
    */
    signal clicked

    Rectangle{
        id: backgroundGameEnd
        color: gameEndPageMode.backgroundColor
        opacity: 0.8

        anchors.fill: parent
    }

    Text{
        id: labelGameEnd
        width: parent.width * 0.95
        height: parent.height * 0.4

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        text: gameEndPageMode.textGameEnd
        minimumPointSize: gameEndPageMode.minPointSize * 1.5
        font.pointSize: gameEndPageMode.maxPointSize
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: gameEndPageMode.fontfamily
        color: gameEndPageMode.fontColor
    }

    Text{
        id: labelBestScores
        width: parent.width * 0.95
        height: parent.height * 0.6

        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05
        anchors.horizontalCenter: parent.horizontalCenter

        text: qsTr("THE SCORES\n" + gameEndPageMode.scoresGame + "\n" + gameEndPageMode.timeGame + "\n" +
                   "THE BEST SCORES\n" + gameEndPageMode.bestScoresGame + "\n" + gameEndPageMode.bestTimeGame)
        minimumPointSize: gameEndPageMode.minPointSize
        font.pointSize: gameEndPageMode.maxPointSize
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: gameEndPageMode.fontfamily
        color: gameEndPageMode.fontColor
    }

    TapHandler{
        id: tapHandlerGameEnd
        acceptedButtons: Qt.LeftButton
        gesturePolicy: TapHandler.ReleaseWithinBounds
        onTapped: gameEndPageMode.clicked()
    }

    Keys.onPressed: (event)=> {
        if (event.key === Qt.Key_Space) {
            clicked()
            event.accepted = true
        }
    }

}
