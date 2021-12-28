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

%% lecture en ZigZag d'un bloc de dimension pair
zigzag.origine1 = [ 1  2  6  7 15 16 28 29;
                    3  5  8 14 17 27 30 43;
                    4  9 13 18 26 31 42 44;
                   10 12 19 25 32 41 45 54;
                   11 20 24 33 40 46 53 55;
                   21 23 34 39 47 52 56 61;
                   22 35 38 48 51 57 60 62;
                   36 37 49 50 58 59 63 64];

zigzag.solution1 = 1:64;
zigzag.calcul1 = ZigZag(zigzag.origine1);
zigzag.erreur1 = zigzag.calcul1 - zigzag.solution1;
tests.zigzagPair = sum(abs(zigzag.erreur1(:))) == 0;

%% lecture en ZigZag d'un bloc de dimension impair
zigzag.origine2 = [ 1  2  6  7 15 16 28 29 45;
                    3  5  8 14 17 27 30 44 46;
                    4  9 13 18 26 31 43 47 60;
                   10 12 19 25 32 42 48 59 61;
                   11 20 24 33 41 49 58 62 71;
                   21 23 34 40 50 57 63 70 72;
                   22 35 39 51 56 64 69 73 78;
                   36 38 52 55 65 68 74 77 79;
                   37 53 54 66 67 75 76 80 81];

zigzag.solution2 = 1:81;
zigzag.calcul2 = ZigZag(zigzag.origine2);
zigzag.erreur2 = zigzag.calcul2 - zigzag.solution2;
tests.zigzagImpair = sum(abs(zigzag.erreur2(:))) == 0;

%% codage de fin de bloc
RLE.EOB = Inf;
RLE.origine = ZigZag(Qbloc.solution);
RLE.solution = [79 0 -2 -1 -1 -1 0 0 -1 RLE.EOB];
RLE.calcul = RLE0(RLE.origine, RLE.EOB);
tests.RLE = sum(RLE.calcul == RLE.solution) == length(RLE.solution);