function bloc = DCTI(bloc_DCT)
%DCT(bloc) transfomation en cosinus discrète inverse d'un bloc de taille NxN
    N = length(bloc_DCT);
    bloc = zeros(N);
    for x = 1:N
        for y = 1:N
            sum = 0;
            for i = 1:N
                cosi = C(i-1) * cos((2*x-1)*(i-1)*pi/(2*N));
                for j = 1:N
                    sum = sum + cosi*C(j-1)*bloc_DCT(i, j)*cos((2*y-1)*(j-1)*pi/(2*N));
                end
            end
            bloc(x, y) = round(2/N * sum);
        end
    end
end

function c = C(x)
    c = 1 + (x==0) * (1/sqrt(2) - 1);
end