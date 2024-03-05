function y = profil(centre,taille,N)

% le profil est un decourt temporel sur N points, entre 0 et 0.5
y = zeros(1,N);
% le plateau est fixe a 1/5 de la taille du profil  
bord    = ceil(2*taille/5);

plateau = taille - 2*bord;
% on s'assure que le centre est 'au centre' de l'intervalle de temps
centre = max(centre,bord+plateau);
centre = min(centre,N-bord-plateau);

% hanning sur 2*bord points
h = hanning(2*bord)';
% le pord gauche
% le point gauche = centre - taille/2
g = centre-ceil(taille/2);
y(1,g:g+bord-1) =h (1:bord);
% le plateau
y(1,g+bord-1:g+bord-1+plateau) = 1;
% le bord droit
y(1,g+bord-1+plateau:g+bord-1+plateau+bord-1) = h(1,bord+1:end);

 y = 0.5*y;
 
end
