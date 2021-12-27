function YCbCr = rgbVersYCbCr(rgb)
%RGBVERSYCBCR(rgb) convertit une image codée en rgb au format YCbCr
    YCbCr = rgb;
    YCbCr(:, :, 1) =  0.299 *rgb(:, :, 1) + 0.587 *rgb(:, :, 2) + 0.114 *rgb(:, :, 3);
    YCbCr(:, :, 2) = -0.1687*rgb(:, :, 1) - 0.3313*rgb(:, :, 2) + 0.5   *rgb(:, :, 3) + 128;
    YCbCr(:, :, 3) =  0.5   *rgb(:, :, 1) - 0.4187*rgb(:, :, 2) - 0.0813*rgb(:, :, 3) + 128;
end