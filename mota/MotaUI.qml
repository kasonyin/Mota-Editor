import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    x: 100
    //400, 450,, x= 0
    Image{
        id: weapen
        x: -90; y:400
        width: 30; height: 30
        source: "image/item/"+actor.weapen+".png"
    }
    Image{
        id: shield
        x: -40; y:400
        width:30; height: 30
        source: "image/item/"+actor.sheild+".png"
    }
    function changeWeapen(x){
        weapen.source = "image/item"+x+".png"
    }

    Rectangle{
        id: editor
        visible: true
        x: -90; y:500
        width: 90; height: 20
        color: "white"
        Rectangle{
            x: 5; y: editor.height + 5
            width: 20; height: 20
            color: "black"
        }

        Rectangle{
            x:10; y: editor.height + 10
            width: 10; height: 10
            color: "green"
        }
        Label{
            id: isSuc
            width: 60; height:10
            x: 45; y: editor.height + 8
            text: "done!"
            opacity: 0
        }

        NumberAnimation {
            id: fadeIn; target: isSuc
            property: "opacity"; running: false
            duration: 1000; to: 1
            onStopped: { fadeOut.restart()}
        }
        NumberAnimation {
            id: fadeOut; target: isSuc
            property: "opacity"; running: false
            duration: 1000; to: 0
        }
        function clicked(){
            fadeIn.restart()
        }
    }


    Flickable {
          id: flick
          visible: true
          x: editor.x; y: editor.y+5
          width: 100; height: 20;
          contentWidth: edit.paintedWidth
          contentHeight: edit.paintedHeight
          clip: true

          function ensureVisible(r)
          {
              if (contentX >= r.x)
                  contentX = r.x;
              else if (contentX+width <= r.x+r.width)
                  contentX = r.x+r.width-width;
              if (contentY >= r.y)
                  contentY = r.y;
              else if (contentY+height <= r.y+r.height)
                  contentY = r.y+r.height-height;
          }
          TextEdit {
              id: edit
              width: flick.width
              height: flick.height
              focus: false
              wrapMode: TextEdit.Wrap
              onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
              font.pixelSize: 12
          }
          function getText(){
              edit.enabled = false
              edit.focus = false; event.focus = true
              return edit.text
          }
          function addText(){
              edit.enabled = true
              edit.focus = true; event.focus = false
          }
          function clearText(){

          }
      }
    function addflick(){
        flick.addText()
    }

    function cancelflick(){
        parser.changeCreat(flick.getText())
        console.log("debug"+creatWhat)
    }
    function showEditor(){
        edit.visible = true
        flick.visible = true
    }

    Rectangle{
        id: showTable
        width: 600; height:50
        color: "steelblue"
        x: 0; y: 600
    }
        Flickable {
              id: flick2
              visible: true
              x: showTable.x; y: showTable.y+5
              width: 600; height: 50;
              contentWidth: edit2.paintedWidth
              contentHeight: edit2.paintedHeight
              clip: true

              function ensureVisible(r)
              {
                  if (contentX >= r.x)
                      contentX = r.x;
                  else if (contentX+width <= r.x+r.width)
                      contentX = r.x+r.width-width;
                  if (contentY >= r.y)
                      contentY = r.y;
                  else if (contentY+height <= r.y+r.height)
                      contentY = r.y+r.height-height;
              }
              TextEdit {
                  id: edit2
                  width: flick2.width
                  height: flick2.height
                  focus: false
                  text: "map: "+myWall
                  wrapMode: TextEdit.Wrap
                  onCursorRectangleChanged: flick2.ensureVisible(cursorRectangle)
                  font.pixelSize: 12
              }
              function getText(){
                  edit2.enabled = false
                  edit2.focus = false; event.focus = true
                  return edit2.text
              }
              function addText(){
                  edit2.enabled = true
                  edit2.focus = true; event.focus = false
              }
              function updateText(i){
                  edit2.text = "click: "+i+" "+"map: "+myWall
              }
          }
        function addflick2(){
            flick2.addText()
        }

        function cancelflick2(){
            var ss
            ss = flick2.getText()
            console.log("cancel flick2!!",ss)
        }
        function upDataFlick2(i){
            flick2.updateText(i)
            console.log("update!")
        }

    Image{
        id: logo
        source: "image/ui2.png"
        x: -100; y: 20
    }

    Label{
        width: 100; height: 40
        x: -90; y: 450
        text:"creat:"
        font.family: uiFont.name
        font.pointSize: 18
        Text{
            y:20
            text: creatWhat
            font.family: uiFont.name
            font.pointSize: 18
            color: "red"
        }
    }

    Image{
        id: uiBg
        source: "image/ui1.png"
        x: -100; y: 140
        Repeater{
            model: 5
            Text{
                x: 50; y: 31+index*35
                text: actor.mainTable[index]
                font.family:  "Arial"
                font.pixelSize: 22
            }
        }
    }

    function doClicked(x, y){
        if(x >= editor.x+100 && x <= editor.x+editor.width+100 && y >=editor.y &&
                y<= editor.y+editor.height){
            addflick()
        }else if(x >= editor.x+5+100 && x <= editor.x+25+100 && y >= editor.y+25 &&
                y<= editor.y+45){
            cancelflick();editor.clicked()
            cancelflick2()
            console.log("text input!!")
        }else if(x >= showTable.x && x <= showTable.x+600 && y>= showTable.y && y<= showTable.y+50){
            addflick2()
            console.log("show table")
        }
        else{
            event.onClickedReport()
            console.log(x, y)
        }
    }

    Image{
        id: showEnemy
        visible: false
        width: 100; height: 100
        source: "image/enemyBg.png"
        Repeater{
            model: 4
            Text{
                width: 40; height: 80
                x: 50; y: 5+index*26
                text: {
                    if(index == 0) return actor.e_name+''
                    else return actor.e_table[index-1]
                }
            }
        }
    }

   property bool isShowEnemyOn: false
   function enemyShow(x, y){
       isShowEnemyOn = true
       showEnemy.x = x-100; showEnemy.y = y
       showEnemy.visible = true; event.transing = false
   }
   function enemyHide(){
       isShowEnemyOn = false
       showEnemy.visible = false; event.transing = true
   }
}
