#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
export DIALOG='
<window title="Doorway Trivia" image-name="DT.png">
  <vbox>
    <pixmap>
      <input file>'$WHEREAMI'/DOOR_OPEN_HALL.PNG</input>
    </pixmap>
    <text>
      <label>"CORRECT"</label>
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