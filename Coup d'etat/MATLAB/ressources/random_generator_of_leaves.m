
function tree = random_generator_of_leaves(tree)
% initial state est un entier ente 1 et 4
% 1: DSC
% 2: ISC
% 3: Inertie 
% 4: Stabilite
% states of leaves est une cellule de tableaux:
% states_of_leaves{i}.table est une matrice de 16 lignes par 4 colonnes
% les 4 colonnes sont les etats dans le meme ordre que precdement.
% les entrees de ces tables sont 3 nombres dont la somme est 1;
% representent la probabilite de l'etat dans la feuille en question.
% tree en sortie contient tree.leaves qui est une selection aleatoire des
% etats de sortie


% tree.initial_state = initial_state;
% tree.P_of_leaves{i}
% tree.leaves

% On specifie la matrice 16x4 a la sortie de l'arbre en fonction de l'etat
% du noeud d'entree. P est une matrice 16 x 4
P = tree.P_of_leaves{tree.initial_state};

% On regarde toutes les feuilles de l'arbre, 
 tree.leaves = zeros(16,1); 
 for i = 1:16; % on parcourt les feuilles 
     ok = 0;
     while ~ok
     r = rand; % r est un nbr aleatoire entre 0 et 1
     T = cumsum(P(i,:))-r; % fonction de repatition - r
     TT = find(T>=0,1,'first');
     if ~isempty(TT), tree.leaves(i) = TT; ok = 1; end
     end
 end

end

