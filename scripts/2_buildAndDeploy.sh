#!/bin/sh

# set some variables
BASE_DIR=../.

abort()
{
    if [ "$?" = "0" ]
    then
        return
    else
      echo >&2 '
      ***************
      *** ABORTED ***
      ***************
      '
      echo "An error occurred on line $1. Exiting..." >&2
      exit 1
    fi
}

summary()
{
  echo_msg "Current Apps & Services in CF_SPACE"
  cf apps
  cf services
}

echo_msg()
{
  echo ""
  echo "************** ${1} **************"
}

deploy()
{
  cd $BASE_DIR/$1
  cf push -f build/manifest.yml
}

build()
{
  cd $BASE_DIR/$1
  ./gradlew build
}

main()
{
  APPS=`cat microServices.list`
  for app in ${APPS[@]}
  do
    echo_msg "Deploying $app"
    build $app
    deploy $app
  done
  
  summary
}


trap 'abort $LINENO' 0
SECONDS=0

main

echo_msg "Deployment Complete in $SECONDS seconds."
