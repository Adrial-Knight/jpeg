function [code, table] = huffmanCanaux(canaux)
    [code, table] = huffman(cell2mat([canaux{1}{:} canaux{2}{:} canaux{3}{:}]));
end