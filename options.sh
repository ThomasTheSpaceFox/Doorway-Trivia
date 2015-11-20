#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
export DIALOG='
<window title="Doorway Trivia -options" image-name="DT.png">
  <vbox>
    <text>
      <label>"          Doorway Trivia options menu          "</label>
    </text>
    <entry>
      <variable>TERM</variable>
      <input file>"'$WHEREAMI'/config.TERM.txt"</input>
    </entry>
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
  echo "$TERM" > $WHEREAMI/config.TERM.txt
else
  echo ""
fi