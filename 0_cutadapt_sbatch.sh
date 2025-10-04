#!/bin/bash
#SBATCH --account giuz
#SBATCH -c 8
#SBATCH --mem 16g
#SBATCH --time 01:00:00

source /home/giuz/.bashrc
conda activate 16s_ill_preprocess

# perform trimming on all files using the sequences of forward and reverse primers:
# forward: GTGCCAGCMGCCGCGGTAA
# reverse: GGACTACHVGGGTWTCTAAT
# and the reverse complements:
# forward rc: TTACCGCGGCKGCTGGCAC
# reverse rc: ATTAGAWACCCBDGTAGTCC

# list of sample IDs
samples=(s22.379.1
s22.379.10
s22.379.11
s22.379.12
s22.379.13
s22.379.14
s22.379.15
s22.379.16
s22.379.17
s22.379.18
s22.379.19
s22.379.20
s22.379.21
s22.379.22
s22.379.23
s22.379.24
s22.379.25
s22.379.26
s22.379.27
s22.379.28
s22.379.29
s22.379.2
s22.379.3
s22.379.30
s22.379.31
s22.379.32
s22.379.33
s22.379.34
s22.379.35
s22.379.36
s22.379.37
s22.379.38
s22.379.39
s22.379.4
s22.379.40
s22.379.41
s22.379.42
s22.379.43
s22.379.44
s22.379.45
s22.379.46
s22.379.47
s22.379.48
s22.379.49
s22.379.5
s22.379.50
s22.379.51
s22.379.52
s22.379.53
s22.379.54
s22.379.55
s22.379.56
s22.379.57
s22.379.58
s22.379.59
s22.379.6
s22.379.60
s22.379.61
s22.379.62
s22.379.63
s22.379.64
s22.379.65
s22.379.66
s22.379.67
s22.379.68
s22.379.69
s22.379.7
s22.379.70
s22.379.71
s22.379.72
s22.379.73
s22.379.74
s22.379.75
s22.379.76
s22.379.8
s22.379.9
s.zymo1
s.zymo2
mlo.w01
mlo.w02
mlo.w03
mlo.w04
mlo.w05
mlo.w06
mlo.w07
mlo.w08
mlo.w09
mlo.w10
mlo.w11
mlo.w12
mlo.w13
mlo.w14
mlo.w15
mlo.w16
mlo.w17
mlo.w18
mlo.w19
mlo.w20
mlo.w21
mlo.w22
mlo.w23
mlo.w24
mlo.w25
mlo.w26
mlo.w27
mlo.w28
mlo.w29
mlo.w30
mlo.w31
mlo.w32
mlo.w33
mlo.w34
mlo.w35
mlo.w36
mlo.w37
mlo.w38
mlo.w39
mlo.w40
mlo.w41
mlo.w42
mlo.w43
mlo.w44
mlo.w45
mlo.w46
mlo.w47
mlo.w48
mlo.w49
mlo.w50
mlo.w51
mlo.w52
mlo.w53
mlo.w54
mlo.w55
mlo.w56
zymo)

# cutadapt on all samples in above list
for s in ${samples[@]};
do
     cutadapt -a GTGCCAGCMGCCGCGGTAA...ATTAGAWACCCBDGTAGTCC -A GGACTACHVGGGTWTCTAAT...TTACCGCGGCKGCTGGCAC -j 12 -o ${s}.raw_1_trimmed.fastq.gz -p ${s}.raw_2_trimmed.fastq.gz ../01.RawData/${s}/${s}.raw_1.fastq.gz ../01.RawData/${s}/${s}.raw_2.fastq.gz  -m 20;

done 
