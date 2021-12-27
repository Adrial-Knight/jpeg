%% init
close all; clear; clc;
addpath("compression", "decompression", "image");

%% paramètres
image.nom = "Monstre_Vert.png";

%% chargment de l'image
image.rgb = imread("image/"+image.nom);

%% conversion en YCbCr
image.YCbCr = rgbVersYCbCr(image.rgb);