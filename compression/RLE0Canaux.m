function c = RLE0Canaux(canaux, EOB)
%RLE0CANAUX(canaux) compresse la fin des lignes des blocs remplies de 0
    c = cell(3, 1);
    for k = 1:3
        l = length(canaux{k});
        c{k} = cell(1, l);
        for i = 1:l
            c{k}{i} = RLE0(canaux{k}{i}, EOB);
        end
    end
end