#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
build_list (){
  cd $WHEREAMI/TRIV	
  for f in *.triv
  do
    ButtonString1="$(sed '1q;d' $WHEREAMI/TRIV/$f)"
    export DIALOG="$DIALOG
    <hbox>
      <text>
        <label>"$ButtonString1"</label>
      </text>
      <button>
        <label>$f</label>
        <action>$WHEREAMI/DT-ENG.sh $f</action>
      </button>
    </hbox>"
  done
  cd $WHEREAMI
} 

export DIALOG='
<window title="Doorway Trivia" image-name="DT.png">
  <vbox>'

build_list

export DIALOG="$DIALOG 
    <hbox>
      <button ok></button>
    </hbox>
  </vbox>
</window>"
#echo "$DIALOG"

gtkdialogoutput=$(gtkdialog --program DIALOG)
  
if [ "$EXIT" = "OK" ]; then
  echo ""
else
  echo ""
fi
    