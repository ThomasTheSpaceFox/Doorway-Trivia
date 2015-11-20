#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
TERM=$(cat config.TERM.txt)
export DIALOG='
<window title="Doorway Trivia" image-name="DT.png">
  <vbox>
    <pixmap>
      <input file>'$WHEREAMI'/TITLE.png</input>
    </pixmap>
    <text>
      <label>"          Doorway Trivia v1.2 main menu          "</label>
    </text>
    <button>
      <label>settings</label>
      <action>'$WHEREAMI'/options.sh</action>
      <input file stock="gtk-preferences"></input>
    </button>
    <button>
      <label>about</label>
      <action>'$WHEREAMI'/about.sh</action>
    </button>
    <text>
      <label>""</label>
    </text>
    <hbox>
      <button ok></button>
      <button cancel></button>
    </hbox>
  </vbox>
</window>'

I=$IFS; IFS=""
for STATEMENTS in  $(gtkdialog --program DIALOG); do
  eval $STATEMENTS
done
IFS=$I

if [ "$EXIT" = "OK" ]; then
  $TERM --title "Doorway Trivia" -e "$WHEREAMI/DT-ENG.sh"
  echo ""
else
  echo ""
fi
