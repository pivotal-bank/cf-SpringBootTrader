#!/bin/sh

# set some variables

delete()
{
  cf delete -f -r $1
}

cf apps

APPS=`cat microServices.list`
for app in ${APPS[@]}
do
  app=`echo $app | cut -d "-" -f1`
  delete $app
done

#Annoying hack
delete webtrader
