function YCbCr_ech = sousEchantillonage(YCbCr, a, b)
%SOUSECHANTILLONAGE(YCbCr, J, a, b) sous-échantillonne la chrominance.
%L'opération diffère selon le format J:a:b
%Supportés: (4:1:1) | (4:2:0) | (4:2:2) | (4:4:4)
    YCbCr_ech = cell(3, 1);
    YCbCr_ech{1} = YCbCr(:, :, 1);
    [h, w, ~] = size(YCbCr);
    if(a == 1 && b == 1)
        YCbCr_ech{2} = zeros(h, w/4);
        YCbCr_ech{3} = zeros(h, w/4);
        for i = 1:h
            for j = 1:w/4
                YCbCr_ech{2}(i, j) = sum(YCbCr(i, (j-1)*4+1:j*4, 2))/4;
                YCbCr_ech{3}(i, j) = sum(YCbCr(i, (j-1)*4+1:j*4, 3))/4;
            end
        end
    elseif(a == 2 && b == 0)
        YCbCr_ech{2} = zeros(h/2, w/2);
        YCbCr_ech{3} = zeros(h/2, w/2);
        for i = 1:h/2
            for j = 1:w/2
                YCbCr_ech{2}(i, j) = sum(sum(YCbCr((i-1)*2+1:i*2, (j-1)*2+1:j*2, 2)))/4;
                YCbCr_ech{3}(i, j) = sum(sum(YCbCr((i-1)*2+1:i*2, (j-1)*2+1:j*2, 3)))/4;
            end
        end
    elseif(a == 2 && b == 2)
        YCbCr_ech{2} = zeros(h, w/2);
        YCbCr_ech{3} = zeros(h, w/2);
        for i = 1:h
            for j = 1:w/2
                YCbCr_ech{2}(i, j) = sum(YCbCr(i, (j-1)*2+1:j*2, 2))/2;
                YCbCr_ech{3}(i, j) = sum(YCbCr(i, (j-1)*2+1:j*2, 3))/2;
            end
        end
    elseif(a == 4 && b == 4)
        YCbCr_ech{2} = YCbCr(:, :, 2);
        YCbCr_ech{3} = YCbCr(:, :, 3);
    else
        fprintf(2, "format de sous-échantillonage 4:" + num2str(a) + ":" + num2str(b) + " non pris en charge.");
    end
end