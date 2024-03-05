
function tree = calcul_probability_transition(tree)


    % On construit l'arbre et ses chemins: un triplet [q b c] identifie un
    % chemin dans l'arbre
    paths = zeros(16,3); leaf = 1;
    for j = 1:2 % pace
        for k = 1:4 % RSS-RNS
            for l = 1:2 % CIT
                paths(leaf,:) = [j k l]; leaf = leaf+1;
            end
        end
    end

    % on attribue la proba d'arriver a chaque feuille (eq.2):
    for leaf = 1:tree.Nleaves
        tree.Proba(leaf) =  P_pace(paths(leaf,:),   tree.p_transition) * ...
                            P_RSS_RNS(paths(leaf,:),tree.p_transition) * ...
                            P_CIT(paths(leaf,:),    tree.p_transition);
    end
end

% =========================================================================


function p = P_pace(path,p_transition)  % RAPIDITE (indice a)
if path(1)==1, p = p_transition.Prapid; % denote u dans le texte
else
               p = 1-p_transition.Prapid;
end
end

function p = P_RSS_RNS(path,p_transition) % RUPTURE (indice b)
if path(2)==1, 
    p = p_transition.PStructure * p_transition.Prapid; % q * u dans le texte; q = p_transition.PStructure
elseif (path(2)==2 || path(2)==3)
    p = (p_transition.PStructure + p_transition.Prapid -...
        2*p_transition.Prapid*p_transition.PStructure)/2;
else
    p = (1-p_transition.PStructure)*(1-p_transition.Prapid);
end
end

function p = P_CIT(path,p_transition) % MENACE (indice c)
if path(3)==1, p = p_transition.Pcultural_threat; % denote par s dans le texte
else
               p = 1-p_transition.Pcultural_threat;
end
end


