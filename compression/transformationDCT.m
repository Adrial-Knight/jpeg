function blocs_DCT = transformationDCT(blocs)
    blocs_DCT = cell(3, 1);
    for k = 1:3
        [h, w] = size(blocs{k});
        blocs_DCT{k} = cell(h, w);
        for i = 1:h
            for j = 1:w
                blocs_DCT{k}{i, j} = DCT(blocs{k}{i, j});
            end
        end
    end
end