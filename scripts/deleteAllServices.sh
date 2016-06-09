#!/bin/sh
IFS=' '

delete()
{
  cf delete-service -f $1
}

#SERVICES=`cat PCFServices.list`
file=./PCFServices.list
#for service in ${SERVICES[@]}
while read service plan si
do
  delete $si
done < "$file"
