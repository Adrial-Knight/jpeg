function canaux_Q = quantificationCanaux(canaux, Q)
%QUANTIFICATION quantifie les canaux à l'aide de la matrice Q
    canaux_Q = cell(3, 1);
    for k = 1:3
        [h, w] = size(canaux{k});
        canaux_Q{k} = cell(h, w);
        for i = 1:h
            for j = 1:w
                canaux_Q{k}{i, j} = quantifie(canaux{k}{i, j}, Q);
            end
        end
    end
end