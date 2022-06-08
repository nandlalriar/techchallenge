#!/usr/bin/bash
HOSTNAME="$(hostname)"
ORATAB=/etc/oratab
if [ ! -f $ORATAB ]
then
exit 1
fi
# Loop for every entry in ORATAB file
cat $ORATAB|grep -v '^$' | while read LINE
do        case $LINE in
\#*)    # Comment-Line in ORATAB
;;        *)
# Setup ORACLE_SID and ORACLE_HOME
# if third field in ORATAB is 'Y'
ORACLE_SID=`echo $LINE | awk -F: '{print $1}' -`
if [ "$ORACLE_SID" = '*' ]
then
ORACLE_SID=""
fi
ORACLE_HOME=`echo $LINE | awk -F: '{print $2}' -`

export ORACLE_SID=$ORACLE_SID
export ORACLE_HOME=$ORACLE_HOME

exit| echo "HOSTNAME,SID,ORACLE_HOME,Database,OPatch,PATCH" > /tmp/opatchversion.csv
PATCH=$(echo $(hostname);\
        echo $ORACLE_SID;\
                echo $ORACLE_HOME;\
                echo $($ORACLE_HOME/OPatch/opatch lsinventory |grep -E 'Oracle Database'|sed  's/  */ /g');\
                echo $($ORACLE_HOME/OPatch/opatch lsinventory |grep -E 'Release|OPatch version'|sed  's/  */ /g'|sed 's/ :/:/g');\
                echo $($ORACLE_HOME/OPatch/opatch lsinventory |grep -E 'applied'|sed  's/  */ /g'))

        echo "$(echo $PATCH |cut -d " " -f 1), \
              $(echo $PATCH |cut -d " " -f 2), \
                  $(echo $PATCH |cut -d " " -f 3), \
                  $(echo $PATCH |cut -d " " -f 4-7), \
                  $(echo $PATCH |cut -d " " -f 8-10), \
                  $(echo $PATCH |cut -d " " -f 11-300)" \
                  >> /tmp/opatchversion.csv

esac # End case $LINE
done
