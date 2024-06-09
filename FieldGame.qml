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
Opis: FieldGame.qml
Zastowowanie: Klas tworząca pole gry i zarządzająca tym polem oraz zasadami
rozgrywki. Pole gry składa się z 16 obiektów Cube ułożonych w macierz 4x4.

Analizuje zdarzenia wejściowe otrzymane od użytkownika takie jak: kliknięcie
przycisku na klawiaturze, przesunięcie myszą lub palcem ( gesty mysz lub palca ).
•	A / left arrow / gest lewo mysz / palce – przesunięcie w lewo ( Metoda shuftLeft()),
•	D / right arrow / gest prawo mysz / palce – przesunięcie w prawo ( Metoda shuftLeft()),
•	W / up arrow / gest do góry mysz / palce  – przesunięcie do góry ( Metoda shuftUP()),
•	S / down arrow / gest w dół mysz / palce  – przesunięcie w dół ( Metoda shuftDown()).

Po otrzymaniu zdarzeni wejściowych od użytkownika wykonuje odpowiedni metody
odpowiadające za zasady rozgrywki.
Odbiera i wysłał odpowiednie sygnał takie jak: newGame(), gameOver(), gameWin().
****************************************************************************/
import QtQuick 6.7

Item {
    id: fieldGame

    property var tabGameData: [0,0,0,0,
                               0,0,0,0,
                               0,0,0,0,
                               0,0,0,0]         //Tablica 16 elementowa przechowująca aktualne wartość pola gry.

    property var tabGameDataSum: [0,0,0,0,
                                  0,0,0,0,
                                  0,0,0,0,
                                  0,0,0,0]      //Tablica 16 elementowa przechowująca wartość zaistnienia operacji
                                                //sumy pomiędzy komórkami tablicy tabGameData.

    property int  scoresGame: 0                 //Parametry przechowując wynik aktualnej rozgrywki.

    property int minPointSize: 12               //Przechowuje minimalną wielkość tekstu dla obiektu.
    property int maxPointSize: 200              //Przechowuje maksymalną wielkość tekstu dla obiektu.
    property string fontfamily: "Sagoe UI"      //Przechowuje nazwę czcionki tekstu dla obiektu.


    property string backgroundColor: "#000000"  //Przechowuje kolor tła dla obiektu.
    property string mainColor: "#ffffff"        //Przechowuje główny kolor „motywu” dla obiektu.
    property string borderColor: "#000000"      //Przechowuje kolor ramki na przykład obiektu Cube.
    property string fontColor: "#000000"        //Przechowuje kolor tekstu dla obiektu.

    /*
    Sygnał emitowana za każdym razem gry któraś z metod zmodyfikuje
    tablice tabGameData. Sygnał ten przesyłany jest do utworzonych 16 obiektów Cube.
    */
    signal changeTabGameData
    /*
    Sygnał emitowana za każdym razem gry któraś z metod zmodyfikuje parametry scoresGame.
    */
    signal changeScoresGame

    /*
    Sygnał służący do ustawienia warunków początkowych dla nowej gry. Powinien zostać
    edytowany przez utworzony obiekty. Uwag nie jest on emitowany przez żadną metodę klas.
    */
    signal newGame
    /*
    Sygnał emitowana gdy metoda addNewNumebr() wykryje że tablica jest zapełniona.
    Związane jest to z zasadą zakończenia rozgrywki z warunkiem „przegrana”.
    */
    signal gameOver
    /*
    Sygnał emitowana gdy metody shiftLeft(), shiftRight(), shiftUp() i shiftDown()
    wykryją że w tablicy powstała liczba 2048. Związane jest to z zasadą zakończenia
    rozgrywki z warunkiem „wygrana”.
    */
    signal gameWin


    onChangeTabGameData: repeaterCubeFieldGame.writeDatatoCube(tabGameData)

    onNewGame: {
        scoresGame = 0
        clearTabGameData()
        addNewNumebr()
        addNewNumebr()
    }

    Rectangle{
        id: backgroundFieldGame
        color: fieldGame.backgroundColor

        anchors.fill: parent

        Rectangle{
            id: cubeFieldGame
            color: fieldGame.backgroundColor
            border.color: fieldGame.borderColor


            width: parent.width > parent.height ? parent.height * 0.98 : parent.width * 0.98
            height: width

            anchors.centerIn: parent

            Grid{
                id: gridFieldGame
                rows: 4
                columns: 4

                anchors.fill: parent

                Repeater{
                    id: repeaterCubeFieldGame
                    model: 16
                    Cube{
                        id: cubeGame
                        width: gridFieldGame.width * 0.25
                        height: gridFieldGame.height * 0.25
                        border.width: width >= height ? height * 0.05 : width * 0.05

                        border.color: fieldGame.backgroundColor
                        color: fieldGame.mainColor

                        text: "0"
                        minPointSize: fieldGame.minPointSize
                        maxPointSize: fieldGame.maxPointSize
                        fontfamily: fieldGame.fontfamily
                        fontColor: fieldGame.fontColor
                    }

                    function writeDatatoCube(tabData: var){
                        for (var index = 0; index < 16; index++){

                            switch(tabData[index]){
                            case 2:
                            case 64:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = "#236B8E"
                                break
                            case 4:
                            case 128:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = "#2F4F2F"
                                break
                            case 8:
                            case 256:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = "#545454"
                                break
                            case 16:
                            case 512:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = "#669933"
                                break
                            case 32:
                            case 1024:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = "#0097A7"
                                break
                            case 2048:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = "#2A2A2A"
                                break
                            default:
                                repeaterCubeFieldGame.itemAt(index).text = tabData[index]
                                repeaterCubeFieldGame.itemAt(index).color = fieldGame.mainColor
                                break
                            }


                        }
                    }
                }
            }
        }
    }

    MultiPointTouchArea{
        id: multiPointTouchAreaFieldGame
        anchors.fill: parent
        mouseEnabled: true

        onGestureStarted: (gesture) => {

                              var difX = Math.abs(gesture.touchPoints[0].startX - gesture.touchPoints[0].x) >= width * 0.1 ? Math.abs(gesture.touchPoints[0].startX - gesture.touchPoints[0].x) : 0
                              var difY = Math.abs(gesture.touchPoints[0].startY - gesture.touchPoints[0].y) >= height * 0.1 ? Math.abs(gesture.touchPoints[0].startY - gesture.touchPoints[0].y) : 0

                              if (difX > difY)
                              {
                                  if((gesture.touchPoints[0].startX - gesture.touchPoints[0].x) >= 0){
                                      shiftLeft()
                                      if (isNumberInTabGameData(2048)) gameWin()
                                      else addNewNumebr()
                                      gesture.grab()
                                  }
                                  else{
                                      shiftRight()
                                      if (isNumberInTabGameData(2048)) gameWin()
                                      else addNewNumebr()
                                      gesture.grab()
                                  }

                              }
                              else if (difX < difY){
                                  if((gesture.touchPoints[0].startY - gesture.touchPoints[0].y) >= 0){
                                      shiftUp()
                                      if (isNumberInTabGameData(2048)) gameWin()
                                      else addNewNumebr()
                                      gesture.grab()
                                  }
                                  else{
                                      shiftDown()
                                      if (isNumberInTabGameData(2048)) gameWin()
                                      else addNewNumebr()
                                      gesture.grab()
                                  }
                              }
                              else{}
                          }
        onPressed: {
            parent.focus = true
        }

    }


    Keys.onPressed: (event)=> {

                        if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
                            shiftLeft()
                            if (isNumberInTabGameData(2048)) gameWin()
                            else addNewNumebr()
                            event.accepted = true
                        }
                        if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
                            shiftRight()
                            if (isNumberInTabGameData(2048)) gameWin()
                            else addNewNumebr()
                            event.accepted = true
                        }
                        if (event.key === Qt.Key_Up || event.key === Qt.Key_W) {
                            shiftUp()
                            if (isNumberInTabGameData(2048)) gameWin()
                            else addNewNumebr()
                            event.accepted = true
                        }
                        if (event.key === Qt.Key_Down || event.key === Qt.Key_S) {
                            shiftDown()
                            if (isNumberInTabGameData(2048)) gameWin()
                            else addNewNumebr()
                            event.accepted = true
                        }
                        if (event.key === Qt.Key_Space) {
                            newGame()
                            event.accepted = true
                        }
                    }


    /*
    Metody: shiftLeft(), shiftRight(), shiftUp() i shiftDown()
    przekształcające tablice tabGameData zgodnie z zasadami rozgrywki.

    Przesunięcie przerzucają wszystkie wartość oprócz zer na wybraną stronę
    po kolej. Tworząc w swego rodzaju stos elementów którego kierunek
    określa przesunięcie.

    Metody również podczas zdarzenia sumowania dwóch identycznych liczby
    dokonuje powiększenia wyniku rozgrywki.
    */
    function shiftLeft(){
        for (var loopIndex = 0; loopIndex < 4; loopIndex++){

            for ( var tabIndexR = 0; tabIndexR < 4; tabIndexR++){

                for ( var tabIndexC = 0; tabIndexC < 3; tabIndexC++){
                    if (tabGameData[tabIndexC+(4*tabIndexR)] === 0){
                        if (tabGameData[tabIndexC+(4*tabIndexR)+1] > 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*tabIndexR)+1]
                            tabGameData[tabIndexC+(4*tabIndexR)+1] = 0
                        }
                    }
                    else if (tabGameData[tabIndexC+(4*tabIndexR)] === tabGameData[tabIndexC+(4*tabIndexR)+1]){
                        if (tabGameDataSum[tabIndexC+(4*tabIndexR)] === 0 && tabGameDataSum[tabIndexC+(4*tabIndexR)+1] === 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*tabIndexR)]*2
                            tabGameData[tabIndexC+(4*tabIndexR)+1] = 0
                            tabGameDataSum[tabIndexC+(4*tabIndexR)] = 1

                            scoresGame += tabGameData[tabIndexC+(4*tabIndexR)]
                        }
                    }
                }
            }
        }
        clearTabGameDataSum()
        changeTabGameData()
    }

    function shiftRight(){
        for (var loopIndex = 0; loopIndex < 4; loopIndex++){

            for ( var tabIndexR = 0; tabIndexR < 4; tabIndexR++){

                for ( var tabIndexC = 3; tabIndexC > 0; tabIndexC--){
                    if (tabGameData[tabIndexC+(4*tabIndexR)] === 0){
                        if (tabGameData[tabIndexC+(4*tabIndexR)-1] > 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*tabIndexR)-1]
                            tabGameData[tabIndexC+(4*tabIndexR)-1] = 0
                        }
                    }
                    else if (tabGameData[tabIndexC+(4*tabIndexR)] === tabGameData[tabIndexC+(4*tabIndexR)-1]){
                        if (tabGameDataSum[tabIndexC+(4*tabIndexR)] === 0 && tabGameDataSum[tabIndexC+(4*tabIndexR)-1] === 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*tabIndexR)]*2
                            tabGameData[tabIndexC+(4*tabIndexR)-1] = 0
                            tabGameDataSum[tabIndexC+(4*tabIndexR)] = 1

                            scoresGame += tabGameData[tabIndexC+(4*tabIndexR)]
                        }
                    }
                }
            }
        }
        clearTabGameDataSum()
        changeTabGameData()
    }

    function shiftUp(){
        for (var loopIndex = 0; loopIndex < 4; loopIndex++){

            for ( var tabIndexR = 0; tabIndexR < 3; tabIndexR++){

                for ( var tabIndexC = 0; tabIndexC < 4; tabIndexC++){
                    if (tabGameData[tabIndexC+(4*tabIndexR)] === 0){
                        if (tabGameData[tabIndexC+(4*(tabIndexR+1))] > 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*(tabIndexR+1))]
                            tabGameData[tabIndexC+(4*(tabIndexR+1))] = 0
                        }
                    }
                    else if (tabGameData[tabIndexC+(4*tabIndexR)] === tabGameData[tabIndexC+(4*(tabIndexR+1))]){
                        if (tabGameDataSum[tabIndexC+(4*tabIndexR)] === 0 && tabGameDataSum[tabIndexC+(4*(tabIndexR+1))] === 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*tabIndexR)]*2
                            tabGameData[tabIndexC+(4*(tabIndexR+1))] = 0
                            tabGameDataSum[tabIndexC+(4*tabIndexR)] = 1

                            scoresGame += tabGameData[tabIndexC+(4*tabIndexR)]
                        }
                    }
                }
            }
        }
        clearTabGameDataSum()
        changeTabGameData()
    }

    function shiftDown(){
        for (var loopIndex = 0; loopIndex < 4; loopIndex++){

            for ( var tabIndexR = 3; tabIndexR > 0; tabIndexR--){

                for ( var tabIndexC = 0; tabIndexC < 4; tabIndexC++){
                    if (tabGameData[tabIndexC+(4*tabIndexR)] === 0){
                        if (tabGameData[tabIndexC+(4*(tabIndexR-1))] > 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*(tabIndexR-1))]
                            tabGameData[tabIndexC+(4*(tabIndexR-1))] = 0
                        }
                    }
                    else if (tabGameData[tabIndexC+(4*tabIndexR)] === tabGameData[tabIndexC+(4*(tabIndexR-1))]){
                        if (tabGameDataSum[tabIndexC+(4*tabIndexR)] === 0 && tabGameDataSum[tabIndexC+(4*(tabIndexR-1))] === 0){
                            tabGameData[tabIndexC+(4*tabIndexR)] = tabGameData[tabIndexC+(4*tabIndexR)]*2
                            tabGameData[tabIndexC+(4*(tabIndexR-1))] = 0
                            tabGameDataSum[tabIndexC+(4*tabIndexR)] = 1

                            scoresGame += tabGameData[tabIndexC+(4*tabIndexR)]
                        }
                    }
                }
            }
        }
        clearTabGameDataSum()
        changeTabGameData()
    }

    /*
    Metody dodająca nową wartość do tablicy tabGameData zgodnie z zasadami rozgrywki.

    Na początku jest losowane jedno z pul tablicy które jest równe zero, a następnie
    wartość dodawanej liczby. Liczby które mogą być wylosowane to 2 i 4, a szansa na
    wylosowanie to dla 2: 9/10 i dla 4: 1/10.

    Gdy nie ma wolnych pul w tablicy tabGameData emitowany jest sygnał gameOver(),
    który jest równoważny końcowy rozgrywki z warunkiem „przegrana”.

    Metoda jest wywoływana dwa razy przez sygnał newGame().
    */
    function addNewNumebr(){
        var tabEmptyData = [0,0,0,0,
                            0,0,0,0,
                            0,0,0,0,
                            0,0,0,0]

        var indexTab = [0,0]
        while(indexTab[0] < 16){
            if (tabGameData[indexTab[0]] === 0)
            {
                tabEmptyData[indexTab[1]] = indexTab[0]
                indexTab[1]++
            }
            indexTab[0]++
        }
        if (indexTab[1] === 0){
            gameOver()
            return
        }

        indexTab[0] = Math.round(Math.random() * (indexTab[1]-1))

        indexTab[1] = Math.round(Math.random() * 100)

             if ( 0 < indexTab[1] && indexTab[1] <= 90)  indexTab[1] = 2
        else if (90 < indexTab[1] && indexTab[1] <= 100) indexTab[1] = 4

        tabGameData[tabEmptyData[indexTab[0]]] = indexTab[1]
        changeTabGameData()
    }

    /*
    Metody czyści zawartość ( ustawia zera ) tablicy  tabGameData.
    Metoda jest wywoływana przez sygnał newGame().
    */
    function clearTabGameData(){
        for (var index = 0; index < 16; index++){
            tabGameData[index] = 0
        }
        changeTabGameData()
    }

    /*
    Metody czyści zawartość ( ustawia zera ) tablicy tabGameDataSum.
    Metoda jest wywoływana pod koniec każdej metody:
    shiftLeft(), shiftRight(), shiftUp() i shiftDown().
    */
    function clearTabGameDataSum(){
        for (var index = 0; index < 16; index++){
            tabGameDataSum[index] = 0
        }
    }

    /*
    Metody sprawdza czy w tabeli tabGameData znajduje się podana liczba.
    Metoda jest wykorzystywana do sprawdzenia warunku zwycięstwa w grze
    ( czy jest 2048 ) każdy razowo po przesunięciu wartość w tablicy za
    pomocą metod shiftLeft(), shiftRight(), shiftUp() i shiftDown().

    Number: var – liczba którą chcemy wyszukać w tablicy.
    return: bool – kiedy liczby jest w tablic zwraca true jeżeli nie zwraca false.
    */
    function isNumberInTabGameData(number: var): bool{
        for (var index = 0; index < 16; index++){
            if (tabGameData[index] === number) return true
        }
        return false
    }
}
