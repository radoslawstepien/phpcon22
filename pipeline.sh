#!/bin/bash

cd main
composer install
ret=$?
if [ $ret != 0 ]
then
    exit $ret
fi
FEATURE_FLAG_SHOW_RECOMMENDATIONS_ON_PRODUCT_LOOKUP=0 RECOMMENDATIONS_SERVICE_URL=http://localhost:8182 composer run tests
ret=$?
if [ $ret != 0 ]
then
    exit $ret
fi
FEATURE_FLAG_SHOW_RECOMMENDATIONS_ON_PRODUCT_LOOKUP=1 RECOMMENDATIONS_SERVICE_URL=http://localhost:8182 composer run tests
ret=$?
if [ $ret != 0 ]
then
    exit $ret
fi

cd ..

docker-compose build
ret=$?
if [ $ret != 0 ]
then
    exit $ret
fi

docker-compose stop
docker-compose create
ret=$?
if [ $ret != 0 ]
then
    exit $ret
fi

docker-compose start
ret=$?
if [ $ret != 0 ]
then
    exit $ret
fi
