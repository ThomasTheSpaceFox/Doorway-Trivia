#!/bin/bash
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
echo "" > $WHEREAMI/score.txt
echo "" > $WHEREAMI/scoreof.txt
echo "" > $WHEREAMI/qtext.txt
echo "IF THINGS GO ARAY CLOSE THIS TERMINAL WINDOW!"
echo "these .triv files were found:" > $WHEREAMI/trivchoose.txt
$WHEREAMI/TRIV/trivsearch.sh >> $WHEREAMI/trivchoose.txt
echo "" >> $WHEREAMI/trivchoose.txt
WHEREAMI="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd && echo)"
cd $WHEREAMI
echo "enter name of valid .triv file" >> $WHEREAMI/trivchoose.txt
echo "only type .triv files found above" >> $WHEREAMI/trivchoose.txt
echo "triv files should be in TRIV directory in the script's directory" >> $WHEREAMI/trivchoose.txt
until [ "$FILEEXIST" = "1" ]; do
  $WHEREAMI/choose.sh
  FILE=$(cat $WHEREAMI/choose.txt)
  if [ "$FILE" = "" ]; then
    echo "ERROR NO ENTRY"
  else
    if test -e "$WHEREAMI/TRIV/$FILE"; then
      FILEEXIST=1
    else
      echo "ERROR NON-EXISTANT"
    fi
  fi
done
FNAME1="$WHEREAMI/TRIV/$FILE"
SCOREOF=0
SCORE=0
QCOUNT=1
until [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "END" ]
do
  if [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "QUIZ-Q" ]; then
    CNT1=$(echo "${QCOUNT}+1" | bc)
    QCOUNT=$CNT1
    CNT3=$(echo "${SCOREOF}+1" | bc)
    SCOREOF=$CNT3
    echo "" > $WHEREAMI/qtext.txt
    until [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "END-QUIZ-Q" ]
    do
      until [ "$(sed ''$QCOUNT'q;d' $FNAME1)" = "-A" ]
      do
      echo $(sed ''$QCOUNT'q;d' $FNAME1) >> $WHEREAMI/qtext.txt
      CNT1=$(echo "${QCOUNT}+1" | bc)
      QCOUNT=$CNT1
      done
      CNT1=$(echo "${QCOUNT}+1" | bc)
      QCOUNT=$CNT1
      echo $SCOREOF > $WHEREAMI/qnum.txt
      $WHEREAMI/question.sh
      AWNS=$(cat $WHEREAMI/qawns.txt)
      if [ "$AWNS" = "$(sed ''$QCOUNT'q;d' $FNAME1)" ]; then
        $WHEREAMI/correct.sh
        CNT2=$(echo "${SCORE}+1" | bc)
        SCORE=$CNT2
        CNT1=$(echo "${QCOUNT}+1" | bc)
        QCOUNT=$CNT1
      else
        $WHEREAMI/wrong.sh
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
