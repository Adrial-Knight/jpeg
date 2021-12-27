function blocs = decoupage(YCbCr)
%DECOUPAGE(YCbCr) découpe la luminance et les chrominances en bloc de 8x8
    blocs = cell(3, 1);
    for i = 1:3
        blocs{i} = creerBloc(YCbCr{i});
    end
end

function bloc = creerBloc(canal)
    [h, w] = size(canal);
    bloc = cell(h/8, w/8);
    for i = 1:h/8
        for j = 1:w/8
            bloc{i, j} = canal((i-1)*8+1:i*8, (j-1)*8+1:j*8);
        end
    end
end