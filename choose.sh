#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
export DIALOG='
<window title="Doorway Trivia" image-name="DT.png">
  <vbox>
    <text>
      <input file>"'$WHEREAMI'/trivchoose.txt"</input>
    </text>
    <text>
      <label>"choice:"</label>
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
  echo "$CHOICE" > $WHEREAMI/choose.txt
else
  echo ""
fi