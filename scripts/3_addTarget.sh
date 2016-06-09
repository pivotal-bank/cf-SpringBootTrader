#!/bin/sh

addTarget()
{
  cf set-env $1 CF_TARGET $CF_TARGET
  cf restage $1
}

# Work out the CF_TARGET
CF_TARGET=`cf target | grep "API" | cut -d" " -f5| xargs`
# Disable PWS because of SCS Tile
PWS=`echo $CF_TARGET | grep "run.pivotal.io" | wc -l`
if [ $PWS -ne 0 ]
then
  echo_msg "This won't run on PWS, please use another environment"
  exit 1
fi

echo "Attaching apps to Spring Cloud Services, watch progress in the Service Discovery Service"

APPS=`cat microServices.list`
for app in ${APPS[@]}
do
  app=`echo $app | cut -d "-" -f1`
  addTarget $app
done

#Annoying hack
addTarget webtrader
