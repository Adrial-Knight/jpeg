function [code, table] = huffman(mot)
%HUFFMAN(mot) code le mot donné en argument et renvoie la table de codage

%% conversion pour suppporter les chaînes de caractères
    if (isstring(mot))
        mot = char(cellstr(mot));
    end

%% construction d'une table de fréquence
    table = containers.Map;
    for i = 1:length(mot)
        clef = num2str(mot(i));
        if ~isKey(table, clef)
            table(clef) = 1;
        else
            table(clef) = table(clef) + 1;
        end
    end
    n = table.Count; % nombre d'étage dans l'arbre de Huffman
    frequence = cell(n, 2);
    clefs = table.keys;
    for i = 1:n
        frequence{i, 1} = clefs(i);
        frequence{i, 2} = table(clefs{i});
    end
    occurence = frequence; % utilisé plus tard pour connaitre la mémoire à allouer pour le codage du mot
    frequence = trie(frequence, 2);

%% construction de la table de codage
    % nettoyage de la table
    for i = 1:n
        table(clefs{i}) = [];
    end
    for i = 1:n-1
        for j = 0:1
            lettres = strsplit(frequence{n-i+j, 1}{:}, ","); % les lettres du fils de gauche (n-i) et du droit (n-1+1)
            for k = 1:length(lettres)
                table(lettres{k}) = [j table(lettres{k})];
            end
        end
        frequence{n-i, 1} = strcat(strcat(frequence{n-i, 1}, ","), frequence{n-i+1, 1}); % fusion
        frequence{n-i, 2} = frequence{n-i+1, 2} + frequence{n-i, 2}; % somme des fréquences d'apparition
        frequence = frequence(1:n-i, :); % suppression de la dernière ligne
        if (i < n-1)
            frequence = trie(frequence, 2);
        end
    end

%% codage du mot
    % évaluation de la mémoire nécessaire
    memoire = 0;
    for i = 1:length(occurence)
        memoire = memoire + occurence{i, 2}*length(table(occurence{i, 1}{1}));
    end

    % codage
    code = zeros(1, memoire);
    curseur = 1;
    for i = 1:length(mot)
        codage = table(num2str(mot(i)));
        code(curseur:curseur+length(codage)-1) = codage;
        curseur = curseur+length(codage);
    end
    code = logical(code); % conversion en booléen
end

function tab = trie(tab, i)
%TRIE(tab, i) effectue un tri bulle sur les lignes en se basant sur la ième colone
    n = length(tab);
    for j = 1:n-1
        k = j+1;
        while(k > 1)
            if(tab{k-1, i} < tab{k, i})
                [tab(k-1, :), tab(k, :)] = echange(tab(k-1, :), tab(k, :));
                k = k-1;
            else
                break;
            end
        end
    end
end

function [a, b] = echange(b, a)
end