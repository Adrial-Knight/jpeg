function ligne = ZigZag(bloc)
%%ZIGZAG(bloc, EOB) lit un bloc en zigzag pour former un vecteur ligne
    [nMax, ~] = size(bloc);
    ligne = NaN * ones(1, nMax*nMax);
    n = 0;
    dH = false; % décalage horizontale
    iTop = 1;
    while n < nMax % triangle supérieur
        h = 1 + ~dH*n;
        w = 1 +  dH*n;
        ligne(iTop) = bloc(h, w); % premier élément de la diagonale
        for i = 1:n
            h = h + 2*dH - 1;
            w = w - 2*dH + 1;
            ligne(iTop + i) = bloc(h, w);
        end
        n = n+1;
        iTop = iTop + n;
        dH = ~dH;
    end
    n = n-2; % décalage dû à la diagonale centrale
    dH = ~dH;
    while n >= 0 % triangle inférieur
        h = nMax - ~dH*n;
        w = nMax -  dH*n;
        ligne(iTop) = bloc(h, w); % premier élement de la diagonale
        for i = 1:n
            h = h - 2*dH + 1;
            w = w + 2*dH - 1;
            ligne(iTop + i) = bloc(h, w);
        end
        n = n-1;
        iTop = iTop + n + 2;
        dH = ~dH;
    end
end