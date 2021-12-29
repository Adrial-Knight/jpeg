function x = RLE0(x, EOB)
%RLE0(x) enlève le dernier groupe de 0 de x pour le remplacer par le charactère EOB (End Of Block)
    j = 0;
    for i = 1:length(x)-1
        if x(i)
            j = i;
        end
    end
    x = num2cell(x(1:j+1));
    x{j+1} = EOB;
end