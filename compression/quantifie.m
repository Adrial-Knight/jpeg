function bloc_Q = quantifie(bloc, Q)
%BQ(bloc, Q) quantifie un bloc à l'aide de la matrice Q
    bloc_Q = floor((bloc + floor(Q/2))./Q);
end