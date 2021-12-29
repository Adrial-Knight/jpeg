%% init
close all; clear; clc;
addpath("compression", "decompression", "image");

%% paramètres
image.nom = "Monstre_Vert.png";
image.echantillonage = struct("a", 2, "b", 0);
compresse.Q = [16 11 10 16  24  40  51  61;
               12 12 14 19  26  58  60  55;
               14 13 16 24  40  57  69  56;
               14 17 22 29  51  87  80  62;
               18 22 37 56  68 109 103  77;
               24 35 55 64  81 104 113  92;
               49 64 78 87 103 121 120 101;
               72 92 95 98 112 100 103  99];
image.EOB = Inf;

%% chargment de l'image
image.rgb = imread("image/"+image.nom);

%% conversion en YCbCr
image.YCbCr = rgbVersYCbCr(image.rgb);

%% sous-echantillonage de la chrominance
image.YCbCr_ech = sousEchantillonage(image.YCbCr, image.echantillonage.a, image.echantillonage.b);

%% découpage en blocs de 8x8
image.blocs = decoupage(image.YCbCr_ech);

%% transformation en cosinus discrète
image.DCT = transformationDCT(image.blocs);

%% quantification
image.quantifie = quantificationCanaux(image.DCT, compresse.Q);

%% lecture en zigzag des blocs des canaux
image.ZigZag = ZigZagCanaux(image.quantifie);

%% compression des fins de blocs
image.RLE = RLE0Canaux(image.ZigZag, image.EOB);

%% compression entropique
[compresse.image, compresse.H] = huffmanCanaux(image.RLE);