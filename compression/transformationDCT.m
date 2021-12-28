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

function bloc_DCT = DCT(bloc)
    N = length(bloc);
    bloc_DCT = zeros(N);
    for i = 1:N
        for j = 1:N
            sum = 0;
            for x = 1:N
                for y = 1:N
                    sum = sum + bloc(x, y) * cos((2*y-1)*(j-1)*pi/(2*N));
                end
                sum = cos((2*x-1)*(i-1)*pi/(2*N)) * sum;
            end
            bloc_DCT(i, j) = 2/N * C(i) * C(j) * sum;
        end
    end
end

function c = C(x)
    c = 1 + (x==1) * (1/sqrt(2) - 1);
end