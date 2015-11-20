#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
qtext=$(cat $WHEREAMI/qtext.txt)
qnum=$(cat $WHEREAMI/qnum.txt)
export DIALOG='
<window title="Doorway Trivia'$qnum'" image-name="DT.png">
  <vbox>
    <text>
      <input file>"'$WHEREAMI'/qtext.txt"</input>
    </text>
    <text>
      <label>"Answer:"</label>
    </text>
    <entry>
      <variable>CHOICE</variable>
    </entry>
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
  echo "$CHOICE" > $WHEREAMI/qawns.txt
else
  echo ""
fi