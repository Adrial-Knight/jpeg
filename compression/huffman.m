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

%% construction de l'arbre
    arbre = cell(1, n-1);
    arbre{1} = trie(frequence, 2); % les feuilles de l'arbre
    for i = 1:n-1
        frequence{n-i, 1} = strcat(strcat(frequence{n-i+1, 1}, ","), frequence{n-i, 1}); % fusion
        frequence{n-i, 2} = frequence{n-i+1, 2} + frequence{n-i, 2}; % somme des fréquences d'apparition
        frequence = frequence(1:n-i, :); % suppression de la dernière ligne
        if (i < n-1)
            frequence = trie(frequence, 2);
        end
        arbre{i+1} = frequence; % ajout d'un étage à l'arbre
    end

%% parcours de l'arbre pour remplir la table
    % nettoyage de la table
    for i = 1:n
        table(clefs{i}) = [];
    end
    % parcours de la racine (n-1) vers les feuilles (1)
    for i = n-1:-1:1
        if i < n-1
            indice = indiceFusion(arbre{i+1}, arbre{i}); % indices des mots qui ont été fusionnés
        else
            indice = [1 2]; % la racine possède 2 fils, aux indices 1 et 2 de l'étage inférieur
        end
        for j = 1:2
            lettres = strsplit(arbre{i}{indice(j), 1}{1}, ","); % les lettres du mot considéré
            for k = 1:length(lettres)
                table(lettres{k}) = [table(lettres{k}) j-1];
            end
        end
    end

%% codage du mot renseigné
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

function indice = indiceFusion(etage, etageInf)
%INDICEFUSION(etage, etageInf) recherche les deux mots de l'étage inférieur qui ont été fusionnés.
    indice = [-1 -1]; % on a une erreur si ces deux valeurs n'ont pas été remplacées
    ii = 1;
    for i = 1:length(etageInf)
        detect = false;
        for j = 1:length(etage);
            if(strcmp(etageInf{i}{1}, etage{j}{1}))
                detect = true;
                break;
            end
        end
        if(~detect)
            indice(ii) = i;
            ii = 2;
        end
    end
end