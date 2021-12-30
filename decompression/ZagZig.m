function bloc = ZagZig(ligne)
%ZAGZIG(ligne) transforme un vecteur ligne en matrice en zigzaguant
    nMax = sqrt(length(ligne));
    bloc = zeros();
    n = 0;
    dH = false; % décalage horizontale
    iTop = 1;
    while n < nMax % triangle supérieur
        h = 1 + ~dH*n;
        w = 1 +  dH*n;
        bloc(h, w) = ligne(iTop); % premier élément de la diagonale
        for i = 1:n
            h = h + 2*dH - 1;
            w = w - 2*dH + 1;
            bloc(h, w) = ligne(iTop + i);
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
        bloc(h, w) = ligne(iTop); % premier élement de la diagonale
        for i = 1:n
            h = h - 2*dH + 1;
            w = w + 2*dH - 1;
            bloc(h, w) = ligne(iTop + i);
        end
        n = n-1;
        iTop = iTop + n + 2;
        dH = ~dH;
    end
end