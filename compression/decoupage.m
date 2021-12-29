function blocs = decoupage(YCbCr)
%DECOUPAGE(YCbCr) découpe la luminance et les chrominances en bloc de 8x8
    blocs = cell(3, 1);
    for i = 1:3
        blocs{i} = creerBloc(padding8(YCbCr{i}));
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

function canal = padding8(canal)
%PADDING8 effectue un 0-padding pour que les dimensions du canal soient multiples de 8
    [h, w] = size(canal);
    h0 = (mod(h, 8) ~= 0) * (8 - mod(h, 8));
    w0 = (mod(w, 8) ~= 0) * (8 - mod(w, 8));
    canal = [canal; zeros(h0, w)];
    canal = [canal zeros(h+h0, w0)];
end