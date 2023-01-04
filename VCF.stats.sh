#!/bin/bash

# set -euxo pipefail

#project=$1
run=$1
echo $run

HOME=/SAN4NFS/Projects/02_Population_Egypt_Genome/$run
mkdir -p $HOME/04_Stats

STATS=$HOME/04_Stats/$run.vc_metrics.tsv
rm -fr $STATS

ls -1 $HOME/02_Analysis/ | while read sample
do
    echo $sample
    cd $HOME/02_Analysis/$sample
    if [ ! -f "$STATS" ]; then
        cat $sample"_dragen.vc_metrics.csv" | sed 's/,/\t/g' | cut -f 3 | sed ':a;N;$!ba;s/\n/\t/g' | awk '{print "project\trun\tsample\t"$0;}' > $STATS
    fi
    cat $sample"_dragen.vc_metrics.csv" | sed 's/,/\t/g' | cut -f 4 | sed ':a;N;$!ba;s/\n/\t/g' | awk -v _project=$project -v _run=$run -v _sample=$sample '{print _project"\t"_run"\t"_sample"\t"$0;}' >> $STATS
done

echo "Done!"
