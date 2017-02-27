WORK_FOLDER=/Users/mac/test
echo $WORK_FOLDER
IFS=","
for file in $WORK_FOLDER/*.csv
do
  MAX_GC=0
  IS_FULL_GC=false
  MAX_FULL_GC=0
  while read col1 col2 col3 col4
  do 
     if [ "$col4" = "GC" ]; then
        if [ $MAX_GC -lt $col2 ] ; then
            MAX_GC=$col2
        fi 
        if $IS_FULL_GC ; then
          if [ $MAX_FULL_GC -lt $col2 ] ; then
            MAX_FULL_GC=$col2
          fi
        fi
        IS_FULL_GC=false
     elif [ "$col4" = "FULLGC" ] ; then
        IS_FULL_GC=true 
     fi 
     #echo "the second column is : $col2"
  done < $file 
  
  echo "$file:   $MAX_GC,$MAX_FULL_GC   MAX_GC,MAX_FULL_GC"  
done 
