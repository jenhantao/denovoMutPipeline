bash ./pipe_single_direct.sh /home/moores/mnt/denovo/ea0d44b0-3f65-457e-9ea7-5b56aa9abc5d denovo TCGA-DD-A114 TP 
bash ./pipe_single_direct.sh /home/moores/mnt/denovo/a9188f3b-6b6e-4b00-8aa6-0a7704479f4b denovo TCGA-DD-A114 NB 
bash ./pipe_single_direct.sh /home/moores/mnt/denovo/69305af6-f4b0-4eb4-8598-3868d0882b56 denovo TCGA-DD-A114 NT 
bash ./pipe_mutect_direct.sh denovo TCGA-DD-A114 NB NT
bash ./pipe_mutect_direct.sh denovo TCGA-DD-A114 NB TP
bash ./pipe_mutect_direct.sh denovo TCGA-DD-A114 NT TP
tasks/removeIntermediates_direct.sh denovo TCGA-DD-A114 >> jhtao_direct.log

