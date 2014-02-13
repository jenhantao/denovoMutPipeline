# 1. uses grep to grab "KEEP" variants from vcv files (given in tsv format)
# 2. calls python script for counting variants and computing statistics
# 3. calls R scripts for visualizing variants

# input three vcf files in the following order: NB_NT, NB_TP, NT_TP

# calls to grep
grep -v REJECT $1 > nb_nt_nonRejected.tsv
grep -v REJECT $2 > nb_tp_nonRejected.tsv
grep -v REJECT $3 > nt_tp_nonRejected.tsv
sampleName=$4
# calls to python script
python variantCounter.py nb_nt_nonRejected.tsv nb_tp_nonRejected.tsv nt_tp_nonRejected.tsv sampleName

# remove extra tsv files
rm nb_nt_nonRejected.tsv
rm nb_tp_nonRejected.tsv
rm nt_tp_nonRejected.tsv
# calls to Rscript
# produce plots for individual matched sets


#produce plots for all matched sets
