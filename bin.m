%% init
close all; clear; clc;
addpath("compression", "decompression", "image");

%% paramètres
image.nom = "Monstre_Vert.png";
image.echantillonage = struct("a", 2, "b", 0);

%% chargment de l'image
image.rgb = imread("image/"+image.nom);

%% conversion en YCbCr
image.YCbCr = rgbVersYCbCr(image.rgb);

%% sous-echantillonage de la chrominance
image.YCbCr_ech = sousEchantillonage(image.YCbCr, image.echantillonage.a, image.echantillonage.b);