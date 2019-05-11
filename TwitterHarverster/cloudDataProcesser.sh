#!/usr/bin/env bash

#(2014 2015 2016 2017 2018 2019)
years=(2014 2017 2018 2019)
cities=(adelaide brisbane canberra hobart melbourne perth sydney)
#（1 2 3 4 5 6 7 8 9 10 11 12)
month=(2 3 4 5 6)

for year in "${years[@]}"
do
    for city in "${cities[@]}"
    do
        for month in "${cities[@]}"
        do
             echo ${city}${year}.json
            a='start_key=["'${city}'",'${year}','${month}',1]'
            echo $a

            curl "http://45.113.232.90/couchdbro/twitter/_design/twitter/_view/summary" \
            -G \
            --data-urlencode 'start_key=["'${city}'",'${year}','${month}',1]' \
            --data-urlencode 'end_key=["'${city}'",'${year}','${month}',31]' \
            --data-urlencode 'reduce=false' \
            --data-urlencode 'include_docs=true' \
            --user "readonly:ween7ighai9gahR6" \
            -o /data/${city}${year}${month}.json

            echo start docReader ${city}${year}${month}.json
            python3 docReader.py ${city}${year}${month}.json 1>docout.txt 2>docerror.txt

            # nohup python3 docReader.py 1>docout.txt 2>docerror.txt &
            rm ${city}${year}${month}.json

        done


    done
done


