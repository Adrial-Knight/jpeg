%% init
close all; clear; clc;
addpath("compression", "decompression");

%% transformation DCT d'un bloc 8x8
DCTbloc.origine = [139 144 149 153 155 155 155 155;
                   144 151 153 156 159 156 156 156;
                   150 155 160 163 158 156 156 156;
                   159 161 162 160 160 159 159 159;
                   159 160 161 162 162 155 155 155;
                   161 161 161 161 160 157 157 157;
                   162 162 161 163 162 157 157 157;
                   162 162 161 161 163 158 158 158];

DCTbloc.solution = [1260  -1 -12 -5  2 -2 -3  1;
                    -23  -17  -6 -3 -3  0  0 -1;
                    -11   -9  -2  2  0 -1 -1  0;
                    -7    -2   0  1  1  0  0  0;
                    -1    -1   1  2  0 -1  1  1;
                     2     0   2  0 -1  1  1 -1;
                    -1     0   0 -1  0  2  1 -1;
                    -3     2  -4 -2  2  1 -1  0];

DCTbloc.calcul = DCT(DCTbloc.origine);
DCTbloc.erreur = DCTbloc.calcul - DCTbloc.solution;

tests.DCT = sum(abs(DCTbloc.erreur(:))) == 0;

%% quantification du précédent bloc 8x8
Qbloc.origine = DCTbloc.solution;
Qbloc.Q = [16 11 10 16  24  40  51  61;
           12 12 14 19  26  58  60  55;
           14 13 16 24  40  57  69  56;
           14 17 22 29  51  87  80  62;
           18 22 37 56  68 109 103  77;
           24 35 55 64  81 104 113  92;
           49 64 78 87 103 121 120 101;
           72 92 95 98 112 100 103  99];

Qbloc.solution = [79  0 -1 0 0 0 0 0;
                  -2 -1  0 0 0 0 0 0;
                  -1 -1  0 0 0 0 0 0;
                    zeros(5, 8)     ];

Qbloc.calcul = quantifie(Qbloc.origine, Qbloc.Q);
Qbloc.erreur = Qbloc.calcul - Qbloc.solution;

tests.Q = sum(abs(Qbloc.erreur(:))) == 0;