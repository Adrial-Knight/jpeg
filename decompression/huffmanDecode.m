function mot = huffmanDecode(code, table)
%HUFFMANDECODE(code, table) décode un code de huffman associé à sa table
    curseur.code = 1;
    curseur.mot  = 1;
    for i = 1:length(code)
        valeur = code(curseur.code : i);
        clef = isValue(table, valeur);
        if clef
            mot(curseur.mot) = clef;
            curseur.mot  = curseur.mot + 1;
            curseur.code = curseur.code + length(valeur);
        end
    end
end

function key = isValue(M, value)
%ISVALUE(M, value) indique si une valeur apartient à la carte M
%en retournant sa clef ou un booléen valant false
    tab.values = values(M);
    tab.keys = keys(M);
    n = length(value);
    for i = 1:length(tab.values)
        if (length(tab.values{i}) == n && sum(value == tab.values{i}) == n)
            key = tab.keys{i};
            return;
        end
    end
    key = false;
end