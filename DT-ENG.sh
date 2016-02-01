#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
echo "" > $WHEREAMI/score.txt
echo "" > $WHEREAMI/scoreof.txt
echo "" > $WHEREAMI/qtext.txt
FNAME1="$WHEREAMI/TRIV/$1"
SCOREOF=0
SCORE=0
QCOUNT=2
ISERROR=0
ERRORFOUND() {
export DIALOG='
<window title="Doorway Trivia" image-name="DT.png">
  <vbox>
    <text>
      <label>"          ERROR!        "</label>
    </text>
    <text>
      <label>"'${ERRORIS}'"</label>
    </text>
    <hbox>
      <button ok></button>
    </hbox>
  </vbox>
</window>'
ERRORDIAGOUTPUT=$(gtkdialog --program DIALOG)
}
until [[ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "END" || "$ISERROR" = "1" ]]
do
  if [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "" ]; then
    ISERROR=1
    ERRORIS="ERROR1: UNEXPECTED END Of File at line: ${QCOUNT}"
    ERRORFOUND
  fi
  if [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "QUIZ-Q" ]; then
    echo "Issue Quiz"
    CNT1=$(echo "${QCOUNT}+1" | bc)
    QCOUNT=$CNT1
    CNT3=$(echo "${SCOREOF}+1" | bc)
    SCOREOF=$CNT3
    echo "" > $WHEREAMI/qtext.txt
    until [[ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "END-QUIZ-Q" || "$ISERROR" = "1" ]]
    do
      until [[ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "-A" || "$ISERROR" = "1" ]]
      do
      echo $(sed ''$QCOUNT'q;d' $FNAME1) >> $WHEREAMI/qtext.txt
      CNT1=$(echo "${QCOUNT}+1" | bc)
      QCOUNT=$CNT1
      if [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "END-QUIZ-Q" ]; then
        ISERROR=1
        ERRORIS="ERROR2: Quiz Awnser Decalation:
-A not found in question: ${SCOREOF}!"
        ERRORFOUND
      fi
      done
      CNT1=$(echo "${QCOUNT}+1" | bc)
      QCOUNT=$CNT1
      echo $SCOREOF > $WHEREAMI/qnum.txt
      if [ "$ISERROR" = "0" ]; then
        $WHEREAMI/question.sh
      fi
      AWNS=$(cat $WHEREAMI/qawns.txt)
      if [[ "$AWNS" = "$(sed ''$QCOUNT'q;d' $FNAME1)" && "$ISERROR" = "0" ]]; then
        $WHEREAMI/correct.sh
        CNT2=$(echo "${SCORE}+1" | bc)
        SCORE=$CNT2
        CNT1=$(echo "${QCOUNT}+1" | bc)
        QCOUNT=$CNT1
      else
        if [ "$ISERROR" = "0" ]; then
          $WHEREAMI/wrong.sh
        fi
        CNT1=$(echo "$QCOUNT+1" | bc)
        QCOUNT=$CNT1
      fi
    done
    CNT1=$(echo "$QCOUNT+1" | bc)
    QCOUNT=$CNT1
    AWNS=nullvaliue
  fi
done
echo "$SCORE" > $WHEREAMI/SCORE.txt
echo "$SCOREOF" > $WHEREAMI/SCOREOF.txt
$WHEREAMI/score.sh
