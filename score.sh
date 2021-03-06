#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
SCORE=$(cat $WHEREAMI/SCORE.txt)
SCOREOF=$(cat $WHEREAMI/SCOREOF.txt)
export DIALOG='
<window title="Doorway Trivia -score" image-name="DT.png">
  <vbox>
    <text>
      <label>"SCORE:'$SCORE'/'$SCOREOF'"</label>
    </text>
    <text>
      <label>""</label>
    </text>
    <hbox>
      <button ok></button>
    </hbox>
  </vbox>
</window>'

I=$IFS; IFS=""
for STATEMENTS in  $(gtkdialog --program DIALOG); do
  eval $STATEMENTS
done
IFS=$I

if [ "$EXIT" = "OK" ]; then
  echo ""
else
  echo ""
fi