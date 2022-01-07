function B = RLEpad0(A, n)
%PADDING0(A, n) opération inverse de RLE0
%enlève le dernier caractère
%ajoute des zéros à la fin du vecteur B pour atteindre la taille n
    [h, w] = size(A);
    if w == 1
        B = [A(1:end-1); zeros(n-h+1, 1)];
    elseif h == 1
        B = [A(1:end-1), zeros(1, n-w+1)];
    else
        fprintf(2, "RLEpad0: Ne supporte pas les matrices");
    end
end