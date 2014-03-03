#! /bin/bash

java -Xmx${heap}m -jar ${picard}/ValidateSamFile.jar INPUT\=${bampath}/${bamfile} OUTPUT\=${output_dir}/${subjectID}.valid.bam 

