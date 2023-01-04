#!/bin/bash

# set -euxo pipefail

#project=$1
run=$1
echo $run

HOME=/SAN4NFS/Projects/02_Population_Egypt_Genome/$run
rm -fr $HOME/04_Stats
mkdir -p $HOME/04_Stats

MAPPING_STATS=$HOME/04_Stats/$run.all.mapping_metrics.tsv

VC_STATS=$HOME/04_Stats/$run.all.vc_metrics.tsv

CNV_STATS=$HOME/04_Stats/$run.all.cnv_metrics.tsv

SV_STATS=$HOME/04_Stats/$run.all.sv_metrics.tsv

ROH_STATS=$HOME/04_Stats/$run.all.roh_metrics.tsv

ls -1 $HOME/02_Analysis/ | while read sample
do
    echo $sample
    cd $HOME/02_Analysis/$sample
    if [ ! -f "$MAPPING_STATS" ]; then
        cat $sample"_dragen.mapping_metrics.csv" | sed 's/,/\t/g' | cut -f 3 | sed ':a;N;$!ba;s/\n/\t/g' | awk '{print "project\trun\tsample\t"$0;}' > $MAPPING_STATS
    fi
    cat $sample"_dragen.mapping_metrics.csv" | sed 's/,/\t/g' | cut -f 4 | sed ':a;N;$!ba;s/\n/\t/g' | awk -v _project=$project -v _run=$run -v _sample=$sample '{print _project"\t"_run"\t"_sample"\t"$0;}' >> $MAPPING_STATS

    if [ ! -f "$VC_STATS" ]; then
        cat $sample"_dragen.vc_metrics.csv" | sed 's/,/\t/g' | cut -f 3 | sed ':a;N;$!ba;s/\n/\t/g' | awk '{print "project\trun\tsample\t"$0;}' > $VC_STATS
    fi
    cat $sample"_dragen.vc_metrics.csv" | sed 's/,/\t/g' | cut -f 4 | sed ':a;N;$!ba;s/\n/\t/g' | awk -v _project=$project -v _run=$run -v _sample=$sample '{print _project"\t"_run"\t"_sample"\t"$0;}' >> $VC_STATS

    if [ ! -f "$CNV_STATS" ]; then
        cat $sample"_dragen.cnv_metrics.csv" | sed 's/,/\t/g' | cut -f 3 | sed ':a;N;$!ba;s/\n/\t/g' | awk '{print "project\trun\tsample\t"$0;}' > $CNV_STATS
    fi
    cat $sample"_dragen.cnv_metrics.csv" | sed 's/,/\t/g' | cut -f 4 | sed ':a;N;$!ba;s/\n/\t/g' | awk -v _project=$project -v _run=$run -v _sample=$sample '{print _project"\t"_run"\t"_sample"\t"$0;}' >> $CNV_STATS
    
    if [ ! -f "$SV_STATS" ]; then
        cat $sample"_dragen.sv_metrics.csv" | sed 's/,/\t/g' | cut -f 3 | sed ':a;N;$!ba;s/\n/\t/g' | awk '{print "project\trun\tsample\t"$0;}' > $SV_STATS
    fi
    cat $sample"_dragen.sv_metrics.csv" | sed 's/,/\t/g' | cut -f 4 | sed ':a;N;$!ba;s/\n/\t/g' | awk -v _project=$project -v _run=$run -v _sample=$sample '{print _project"\t"_run"\t"_sample"\t"$0;}' >> $SV_STATS
    
    if [ ! -f "$ROH_STATS" ]; then
        cat $sample"_dragen.roh_metrics.csv" | sed 's/,/\t/g' | cut -f 3 | sed ':a;N;$!ba;s/\n/\t/g' | awk '{print "project\trun\tsample\t"$0;}' > $ROH_STATS
    fi
    cat $sample"_dragen.roh_metrics.csv" | sed 's/,/\t/g' | cut -f 4 | sed ':a;N;$!ba;s/\n/\t/g' | awk -v _project=$project -v _run=$run -v _sample=$sample '{print _project"\t"_run"\t"_sample"\t"$0;}' >> $ROH_STATS
    
done

echo "Done!"

