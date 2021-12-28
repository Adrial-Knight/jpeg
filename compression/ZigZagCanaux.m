function canaux_ZZ = ZigZagCanaux(canaux)
%ZIGZAGCANAUX lit les blocs des canaux en ZigZag
    canaux_ZZ = cell(3, 1);
    for k = 1:3
        [h, w] = size(canaux{k});
        canaux_ZZ{k} = cell(h, w);
        for i = 1:h
            for j = 1:w
                canaux_ZZ{k}{i, j} = ZigZag(canaux{k}{i, j});
            end
        end
    end
end