function [] = make_Simul_COVID19(EVENT,EVENT_NAME)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set_up;
rng('shuffle');

% Here, we are initializing the three with the first out of 4 quetions: What initial
% societal state (initial_state) the tree starts from? ;

name_answer = EVENT_NAME;

TREE.initial_state = 4;
%%%%% RANDOM:
% fonction qui selectionne aleatoirement le modele d'arbre de depart
% (l'etat des feuilles etant donne le noeud initial)
TREE = random_generator_of_leaves(TREE);

% OK the programm keeps going and 0 the program quits
OK = 1; c = 0;

% Here, we initialize, this allows the model to run. The values here are by
% default in order to start building the model.
characteristics = {'speed','structure','identity'};
attribute       = {'rapid','rupture',  'threat'};
TREE.p_transition.Prapid           = 0.5; % u
TREE.p_transition.PStructure       = 0.5; % q
TREE.p_transition.Pcultural_threat = 0.5; % s

% Nombre de pas de temps (N), temps < N avec temps = 1 correspondant à l'etat initial   
N = 2000; temps = 2; 
% vecteur d'etat estime au cours du temps 
ETAT    = zeros(1,N);
ETAT(1) = TREE.initial_state;

% Nombre d'evenements:
Nev = numel(EVENT);

% dynamique?
% profil de la rapidite
p1dynamique = 0.5;
for i = 1:Nev
    centre = EVENT{i}.PACE.centre;
    taille = EVENT{i}.PACE.taille;
    intervalle = [centre-taille/2 centre+taille/2];
    amplitude = EVENT{i}.PACE.amplitude;  % entre -1 et 1
    p1dynamique = p1dynamique  + amplitude*profil(centre,taille,N);
end

% profil de la rupture
p2dynamique = 0.5;
for i = 1:Nev
    centre = EVENT{i}.RUPTURE.centre;
    taille = EVENT{i}.RUPTURE.taille;
    intervalle = [min(centre-taille/2,intervalle(1)) max(centre+taille/2,intervalle(2))];
    amplitude = EVENT{i}.RUPTURE.amplitude; % entre -1 et 1
    p2dynamique = p2dynamique  + amplitude*profil(centre,taille,N);
end

% profil de la menace
p3dynamique = 0.5;
for i = 1:Nev
    centre = EVENT{i}.IDENTITY.centre;
    taille = EVENT{i}.IDENTITY.taille; %700;
    intervalle = [min(centre-taille/2,intervalle(1)) max(centre+taille/2,intervalle(2))];
    amplitude =  EVENT{i}.IDENTITY.amplitude; % entre -1 et 1
    p3dynamique = p3dynamique  + amplitude*profil(centre,taille,N);
end



TREE = calcul_probability_transition(TREE);

        P = zeros(1,TREE.Nleaves);
        for i = 1:4;
            leaves = find(TREE.leaves == i);
            if isempty(leaves), P(i) = 0; else P(i) = sum(TREE.Proba(leaves)); end
        end
        
        % On cherche le winner:
        [v,win] = max(P);
        
        ETAT(temps) = win;
        
        TREE.initial_state = win;


% The function While allows to build the model in cycle and erase previous
% values if we want. c means transition and 3 means that the cycle can run
% 3 times. 
    while temps < N
        
        TREE.p_transition.Prapid           = p1dynamique(temps);
        TREE.p_transition.PStructure       = p2dynamique(temps);
        TREE.p_transition.Pcultural_threat = p3dynamique(temps);
        
        TREE = random_generator_of_leaves(TREE);
        TREE = calcul_probability_transition(TREE);

        P = zeros(1,TREE.Nleaves);
        for i = 1:4;
            leaves = find(TREE.leaves == i);
            if isempty(leaves), P(i) = 0; else P(i) = sum(TREE.Proba(leaves)); end
        end
        
        % On cherche le winner:
        [v,win] = max(P);
        
        ETAT(temps) = win;
        TREE.initial_state = win;
        temps = temps + 1;
        
    end

    
% Visualisation
figure('position',[100 100 900 250]); 


%subplot(1,9,[4 9]); 

%ordre = [4 2 1 3];
ordre = [3 1 2 4];
ETATn = ETAT;

for i = 1:4; ETATn((ETAT == ordre(i))) = i; end
plot(ETATn,'or'); hold on; 
plot(1:N, 0.5+ 4*p1dynamique,'-m');
plot(1:N, 0.5+ 4*p2dynamique,'-g'); 
plot(1:N, 0.5+ 4*p3dynamique,'-b'); ylim([0 5]);
xlabel('time');
%title(name_answer,'fontsize',14);
text(400,4.5,name_answer,'fontsize',22,'Color','b');
a = gca; set(a,'Color','none');
a.YTick = [0 1 2 3 4 5]; a.YTickLabel = {'' 'INER' 'DSC' 'ISC' 'STAB' ''};
a.XTickLabel = {};
a.FontSize = 16;
for i = 1:numel(EVENT)
    xx = 1/3*(EVENT{i}.PACE.centre + ...
    EVENT{i}.RUPTURE.centre + ...
    EVENT{i}.IDENTITY.centre);
    text(xx,4.5,EVENT{i}.name,'fontsize',14,'Color','k','fontangle','italic');
end
xlim([350 1500])

hold off

% subplot(1,9,[1 2]); 
% bar([0.7 2 3.3],[a1 a2 a3],0.6); ylabel('amplitude');
% ylim([-1 1])
% a = gca; set(a,'Color','none');
% a.XTick = [0.7 2 3.3]; a.XTickLabel = {'pace' 'rupture' 'threat'};
% a.FontSize = 14;
% 
% 
% U = ETATn(intervalle(1):intervalle(2));
% U_INER = numel(find(U==1));
% U_DSC = numel(find(U==2));
% U_ISC = numel(find(U==3));
% U_STAB = numel(find(U==4));
% U_tot = numel(U);

% fprintf('\n\nPendant la ''crise'':\n');
% fprintf('\t INERTIE =\t %d sur %d \n',U_INER,U_tot);
% fprintf('\t DSC =\t\t %d sur %d \n',U_DSC,U_tot);
% fprintf('\t ISC =\t\t %d sur %d \n',U_ISC,U_tot);
% fprintf('\t STABILITE =\t %d sur %d \n\n---- fini!\n',U_STAB,U_tot);
% 
