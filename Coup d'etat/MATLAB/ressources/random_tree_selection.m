function TREE = random_tree_selection(TREE)

% les feuilles de l'arbres:
a = TREE.state_of_leaves{TREE.initial_state};
% on regarde les doublons:
u = [0]; for i = 1:numel(a), u(i)=numel(a{i}); end;
% on genere un choix aleatoire
v = [0]; for i = 1:numel(u), v(i) = randi(u(i)); end
% on definit les feuilles en fonction de ce choix:
TREE.selection_random = []; for i = 1:numel(a), TREE.selection_random(i,1) = a{i}{v(i)}; end
end