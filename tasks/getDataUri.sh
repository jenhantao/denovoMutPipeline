#! /bin/bash

# Retrieve analysis data uri and sample type from 

# Arg 1: Path to xmlfile (file with list of cgquery xml filenames)

export xmlfile=$(echo ${1##*/})
export path=$(dirname $1)

rm $path/urilist.txt
rm $path/sampletypelist.txt
rm $path/barcodelist.txt
rm $path/platformlist.txt
rm $path/librarylist.txt
rm $path/meta.txt
for xmlfile in $(cat $1)
do
    awk -F"[><]" '$2 == "analysis_data_uri"{print $3}' $path/$xmlfile >> $path/urilist.txt
    awk -F"[><]" '$2 == "sample_type"{print $3}' $path/$xmlfile >> $path/sampletypelist.txt
    awk -F"[><]" '$2 == "legacy_sample_id"{print $3}' $path/$xmlfile >> $path/barcodelist.txt
    awk -F"[><]" '$2 == "platform"{print $3}' $path/$xmlfile >> $path/platformlist.txt
    awk -F"[><]" '$2 == "library_strategy"{print $3}' $path/$xmlfile >> $path/librarylist.txt
done
paste $path/barcodelist.txt $path/sampletypelist.txt $path/urilist.txt $path/platformlist.txt $path/librarylist.txt> $path/meta.txt

