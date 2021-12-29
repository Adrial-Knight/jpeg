#Remarques en vrac

## Conversion rgb -> YCbCr
Matlab utilise le standard CCIR 601. Il est utilisé pour la vidéo et la télévision, mais pas pour JPEG.

## EOB
Pour l'instant, les seuls caractères EOB utilisables sont Inf, -Inf et NaN. Cela est dû à l'utilisation de cellules dans RLE0Canaux qui oblige à faire un _cell2mat_ dans huffmanCanaux. La conversion ne permet que des nombres (ainsi que Inf, -Inf et NaN). 