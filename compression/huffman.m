function [code, table] = huffman(entree)
%HUFFMAN(mot) code le mot donné en argument et renvoie la table de codage

%% construction d'une table de fréquence
    table = containers.Map;
    for i = 1:length(entree)
        clef = num2str(entree(i));
        if ~isKey(table, clef)
            table(clef) = 1;
        else
            table(clef) = table(clef) + 1;
        end
    end
    n = table.Count;
    frequence = cell(n, 2);
    clefs = table.keys;
    for i = 1:n
        frequence{i, 1} = clefs(i);
        frequence{i, 2} = table(clefs{i});
    end
    composition_mot = frequence; % utilisé plus tard pour connaitre la mémoire à allouer pour le codage du mot

%% construction de l'arbre
    arbre = cell(1, n-1);
    arbre{1} = trie(frequence, 2);
    for i = 1:n-2
        frequence{n-i, 1} = strcat(strcat(frequence{n-i+1, 1}, ","), frequence{n-i, 1}); % fusion
        frequence{n-i, 2} = frequence{n-i+1, 2} + frequence{n-i, 2}; % somme proba
        tmp = frequence(1:n-i, :); % suppression de la dernière ligne...
        frequence = tmp; % ... en deux temps (limite des cellules sous MATLAB)
        frequence = trie(frequence, 2);
        arbre{i+1} = frequence; % ajout
    end

%% parcours de l'arbre pour remplir la table
    % nettoyage de la table
    for i = 1:n
        table(clefs{i}) = [];
    end
    etage = arbre{n-1};
    % première attribution
    for j = 1:2
        mot = etage{j, 1};
        lettres = strsplit(mot{1}, ",");
        for i = 1:length(lettres)
            table(lettres{i}) = [table(lettres{i}) j-1];
        end
    end
    % les autres attributions
    for k = n-2:-1:1
        indice = motFusionne(arbre{k+1}, arbre{k}); % indices des mots qui ont été fusionnés
        etage = arbre{k};
        for j = 1:2
            mot = etage{indice(j), 1};
            lettres = strsplit(mot{1}, ",");
            for i = 1:length(lettres)
                table(lettres{i}) = [table(lettres{i}) j-1];
            end
        end
    end

%% codage du mot renseigné
    % évaluation de la mémoire nécessaire
    nCode = 0;
    for i = 1:length(composition_mot)
        nCode = nCode + composition_mot{i, 2} * length(table(composition_mot{i, 1}{1}));
    end

    % codage
    code = zeros(1, nCode);
    curseur = 1;
    for i = 1:length(entree)
        codage = table(num2str(entree(i)));
        ncodage = length(codage);
        code(curseur:curseur+ncodage-1) = codage;
        curseur = curseur + ncodage;
    end
    code = logical(code); % conversion en booléen
end

function tab = trie(tab, i)
%TRIE(tab, i) effectue un trie bulle sur les lignes en se basant sur la ième colone
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

function indice = motFusionne(etage, etageInf)
    indice = zeros(1, 2);
    trouve = 1;
    for i = 1:length(etageInf)
        detect = 0;
        for j = 1:length(etage)
            motInf = etageInf{i}{1};
            mot = etage{j}{1};
            if (length(motInf) == length(mot))
                 if (etageInf{i}{1} == etage{j}{1})
                    detect = 1;
                    break;
                end
            end
        end
        if (detect == 0)
            indice(trouve) = i;
            trouve = trouve + 1;
        end
    end
end