function bloc_DCT = DCT(bloc)
%DCT(bloc) transfomation en cosinus discrète d'un bloc de taille NxN
    N = length(bloc);
    bloc_DCT = zeros(N);
    for i = 1:N
        for j = 1:N
            sum = 0;
            for x = 1:N
                cosx = cos((2*x-1)*(i-1)*pi/(2*N));
                for y = 1:N
                    sum = sum + cosx * cos((2*y-1)*(j-1)*pi/(2*N)) * bloc(x, y);
                end
            end
            bloc_DCT(i, j) = round(2/N * C(i-1) * C(j-1) * sum);
        end
    end
end

function c = C(x)
    c = 1 + (x==0) * (1/sqrt(2) - 1);
end