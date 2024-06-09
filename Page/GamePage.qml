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
Opis: GamePage.qml
Zastowowanie: Klas tworzy wizualną stronę rozgrywki w której będzie
odbywać się cała wizualna część rozgrywki.

Strona zawiera: trzy Cube QML do prezentacji wyników i zmierzonego czasu,
przycisk do rozpoczynania nowej rozgrywki na bazie Cube QML, FieldGame QML
pole z rozgrywką oraz zarządza stroną GameEndPage

Przycisk New Game reaguje na kliknięcie muszą, dotknięcie palce.
Nową rozgrywkę można również rozpocząć naciskając spacje na klawiaturze
co jest obsługiwane przez FieldGame QML.
****************************************************************************/
import QtQuick 6.7
import QtQuick.Controls 6.7

import "../"
import "../Page"

Item {
    id: gamePageMode

    property int  bestScoresGame: 0             //Parametry przechowuje najlepszy wyniki rozgrywki w tej sesji.
    property int  scoresGame: 0                 //Parametry przechowuje aktualny wyniki rozgrywki.
    property string bestTimeGame: "00:00:00"    //Parametry przechowuje czas dla najlepszego wyniku w tej sesji.
    property string timeGame: "00:00:00"        //Parametry przechowuje czas dla aktualnej rozgrywki.

    property int minPointSize: 12               //Przechowuje minimalną wielkość tekstu dla obiektu.
    property int maxPointSize: 200              //Przechowuje maksymalną wielkość tekstu dla obiektu.
    property string fontfamily: "Sagoe UI"      //Przechowuje nazwę czcionki tekstu dla obiektu.
    property string fontColor: "#000000"        //Przechowuje kolor tekstu dla obiektu.

    property string backgroundColor: "#000000"  //Przechowuje kolor tła dla obiektu.
    property string mainColor: "#ffffff"        //Przechowuje główny kolor „motywu” dla obiektu.

    /*
    Sygnał służący do inicjalizacji  zakończenia rozgrywki. Emitowany jest przez
    obiekty GameEndPage QML pod naciśnięciu / dotknięciu ekranu. Powinien zostać
    edytowany przez utworzony obiekty.
    */
    signal endGame

    onEnabledChanged: {
        if (gamePageMode.enabled === true){

            cubeBestScoresGame.bestScoresGame = gamePageMode.bestScoresGame

            fieldGame.newGame()
            fieldGame.focus = true
        }
    }

    Rectangle{
        id: backgroundGameMode
        color: "#ffffff"

        anchors.fill: parent

        Row{
            id: rowScoresGameTab
            width: parent.width
            height: parent.height * 0.2

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Column{
                id: columnScoresGameTab
                width: parent.width * 0.5
                height: parent.height

                Cube{
                    id: cubeBestScoresGame
                    width: parent.width
                    height: parent.height * 0.5
                    border.width: width >= height ? height * 0.05 : width * 0.05

                    border.color: gamePageMode.backgroundColor
                    color: gamePageMode.mainColor

                    property int bestScoresGame: gamePageMode.bestScoresGame

                    text: qsTr("Best\n" + cubeBestScoresGame.bestScoresGame)
                    fontfamily: gamePageMode.fontfamily
                    fontColor: gamePageMode.fontColor
                }

                Cube{
                    id: cubeScoresGame
                    width: parent.width
                    height: parent.height * 0.5
                    border.width: width >= height ? height * 0.05 : width * 0.05

                    border.color: gamePageMode.backgroundColor
                    color: gamePageMode.mainColor

                    text: qsTr("Scores\n" + gamePageMode.scoresGame)
                    fontfamily: gamePageMode.fontfamily
                    fontColor: gamePageMode.fontColor
                }
            }

            Column{
                id: columnRulesGameTab
                width: parent.width * 0.5
                height: parent.height

                Cube{
                    id: labelTimeGame
                    width: parent.width
                    height: parent.height * 0.5
                    border.width: width >= height ? height * 0.05 : width * 0.05

                    border.color: gamePageMode.backgroundColor
                    color: gamePageMode.mainColor

                    text: qsTr("Time\n" + gamePageMode.timeGame)
                    fontfamily: gamePageMode.fontfamily
                    fontColor: gamePageMode.fontColor

                    Timer{
                        id: timerGame
                        property int counter: 0
                        interval: 1000; running: true; repeat: true

                        onTriggered: {
                            timerGame.counter++
                            gamePageMode.timeGame = String(Math.floor(timerGame.counter / 3600)).padStart(2,'0') + ":" +
                                                    String(Math.floor(timerGame.counter / 60) % 60).padStart(2,'0') + ":" +
                                                    String(timerGame.counter % 60).padStart(2,'0')
                        }
                    }

                }

                Cube{
                    id: cubeNewGame
                    width: parent.width
                    height: parent.height * 0.5
                    border.width: width >= height ? height * 0.05 : width * 0.05

                    border.color: gamePageMode.backgroundColor
                    color: gamePageMode.mainColor

                    text: qsTr("New Game")
                    fontfamily: gamePageMode.fontfamily
                    fontColor: gamePageMode.fontColor

                    TapHandler{
                        id: tapHandlerCubeNewGame
                        acceptedButtons: Qt.LeftButton
                        gesturePolicy: TapHandler.ReleaseWithinBounds
                        onTapped: {
                            fieldGame.newGame()
                            fieldGame.focus = true
                        }
                    }
                }
            }
        }

        FieldGame{
            id: fieldGame

            anchors.top: rowScoresGameTab.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            minPointSize: gamePageMode.minPointSize
            maxPointSize: gamePageMode.maxPointSize
            fontfamily: gamePageMode.fontfamily
            fontColor: gamePageMode.fontColor

            backgroundColor: gamePageMode.backgroundColor
            mainColor: gamePageMode.mainColor

            onChangeTabGameData: {
               gamePageMode.scoresGame = scoresGame
            }

            onNewGame: {
                timerGame.counter = 0
                timerGame.start()
            }

            onGameOver: {
                focus = false
                timerGame.stop()

                screenGameEnd.bestScoresGame = gamePageMode.bestScoresGame
                screenGameEnd.scoresGame = gamePageMode.scoresGame
                screenGameEnd.bestTimeGame = gamePageMode.bestTimeGame
                screenGameEnd.timeGame = gamePageMode.timeGame
                screenGameEnd.textGameEnd = qsTr("Game Over")
                screenGameEnd.backgroundColor = "#B42A2A"

                screenGameEnd.visible = true
                screenGameEnd.enabled = true
                screenGameEnd.focus = true

                if (gamePageMode.scoresGame > gamePageMode.bestScoresGame){
                    gamePageMode.bestScoresGame = gamePageMode.scoresGame
                    gamePageMode.bestTimeGame = gamePageMode.timeGame
                }
                else if (gamePageMode.scoresGame === gamePageMode.bestScoresGame){
                    if (gamePageMode.timeGame > gamePageMode.bestTimeGame){
                        gamePageMode.bestTimeGame = gamePageMode.timeGame
                    }
                }
            }

            onGameWin: {
                focus = false
                timerGame.stop()

                screenGameEnd.bestScoresGame = gamePageMode.bestScoresGame
                screenGameEnd.scoresGame = gamePageMode.scoresGame
                screenGameEnd.bestTimeGame = gamePageMode.bestTimeGame
                screenGameEnd.timeGame = gamePageMode.timeGame
                screenGameEnd.textGameEnd = qsTr("Game Win")
                screenGameEnd.backgroundColor = "#006633"

                screenGameEnd.visible = true
                screenGameEnd.enabled = true
                screenGameEnd.focus = true

                if (gamePageMode.scoresGame > gamePageMode.bestScoresGame){
                    gamePageMode.bestScoresGame = gamePageMode.scoresGame
                    gamePageMode.bestTimeGame = gamePageMode.timeGame
                }
                else if (gamePageMode.scoresGame === gamePageMode.bestScoresGame){
                    if (gamePageMode.timeGame > gamePageMode.bestTimeGame){
                        gamePageMode.bestTimeGame = gamePageMode.timeGame
                    }
                }
            }

        }

        GameEndPage{
            id: screenGameEnd
            enabled: false
            visible: false

            anchors.fill: parent

            bestScoresGame: gamePageMode.bestScoresGame
            scoresGame: gamePageMode.scoresGame
            bestTimeGame: gamePageMode.bestTimeGame
            timeGame: gamePageMode.timeGame
            textGameEnd: ""


            minPointSize: gamePageMode.minPointSize
            maxPointSize: gamePageMode.maxPointSize
            fontfamily: gamePageMode.fontfamily
            fontColor: gamePageMode.fontColor

            backgroundColor: gamePageMode.backgroundColor

            onClicked: {
                screenGameEnd.enabled = false
                screenGameEnd.visible = false
                gamePageMode.endGame()
            }
        }
    }
}


