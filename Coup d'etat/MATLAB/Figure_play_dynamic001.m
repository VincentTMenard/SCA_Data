

clear
close all
clc

set_up;
rng('shuffle');


%A          = csvread('fichier_PAYS.txt',1,0,[0,0,0,4]);
fid = fopen('fichier_PAYS.txt','r');
Id = []; Rap = []; Rup = []; Men = []; Som = []; k = 1;
line = fgetl(fid);
line = fgetl(fid);
while ischar(line)
A = strsplit(line,';');
    Id(k) = str2num(A{1});
    Rap(k) = str2num(A{2});
    Rup(k) = str2num(A{3});
    Men(k) = str2num(A{4});
    Som(k) = str2num(A{5}); k = k+1;
    line = fgetl(fid);
end
Ncountries = length(Id);

fid_sortie = fopen('fichier_PAYS_sortie.txt','w');
X = [];
for C = 1:Ncountries

SOMME = Som(C);

        % Here, we are initializing the three with the first out of 4 quetions: What initial
        % societal state (initial_state) the tree starts from? 

        % fprintf('\n\n1 = %s, 2 = %s, 3 = %s, 4 = %s\n',TREE.states{1},TREE.states{2},TREE.states{3},TREE.states{4});
        % answer = input('Initial state (1 to 4)? ','s');

        TREE.initial_state = 1; % WE FORCE IT .... str2num(answer);

        fprintf('\n %d',Id(C));


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
        N = 1500; temps = 2; 
        % vecteur d'etat estime au cours du temps 
        ETAT = zeros(1,N);
        ETAT(1) = TREE.initial_state;

        % dynamique?
        % profil de la rapidite
        centre = 500;
        taille = 250;
        intervalle = [centre-taille/2 centre+taille/2];
        amplitude = Rap(C);  % entre -1 et 1
        p1dynamique = 0.5  + amplitude*profil(centre,taille,N);
        % profil de la rupture
        centre = 550;
        taille = 250;
        intervalle = [min(centre-taille/2,intervalle(1)) max(centre+taille/2,intervalle(2))];
        amplitude = Rup(C);
        p2dynamique = 0.5  + amplitude*profil(centre,taille,N);
        % profil de la menace
        centre = 600;
        taille = 250;
        intervalle = [min(centre-taille/2,intervalle(1)) max(centre+taille/2,intervalle(2))];
        amplitude =  Men(C);
        p3dynamique = 0.5  + amplitude*profil(centre,taille,N);


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


        % NO Visualisation
        
        %ordre = [4 2 1 3];
        ordre = [3 1 2 4];
        ETATn = ETAT;

        for i = 1:4; ETATn((ETAT == ordre(i))) = i; end
%         plot(ETATn,'or'); hold on; 
%         plot(1:N, 0.5+ 4*p1dynamique,'-m');
%         plot(1:N, 0.5+ 4*p2dynamique,'-g'); 
%         plot(1:N, 0.5+ 4*p3dynamique,'-b'); ylim([0 5]);
%         xlabel('time');
%         %title(name_answer,'fontsize',14);
%         text(50,4.5,name_answer,'fontsize',22);
%         a = gca;
%         a.YTick = [0 1 2 3 4 5]; a.YTickLabel = {'' 'INER' 'DSC' 'ISC' 'STAB' ''};
%         a.XTickLabel = {};
%         a.FontSize = 16;
%         plot(intervalle(1),0,'.k','markersize',12);
%         plot(intervalle(2),0,'.k','markersize',12);
%         hold off
% 
%         subplot(1,9,[1 2]); 
%         bar([0.7 2 3.3],[a1 a2 a3],0.6); ylabel('amplitude');
%         ylim([-1 1])
%         a = gca; set(a,'Color','none');
%         a.XTick = [0.7 2 3.3]; a.XTickLabel = {'pace' 'rupture' 'threat'};
%         a.FontSize = 14;


        U = ETATn(intervalle(1):intervalle(2));
        U_INER = numel(find(U==1));
        U_DSC = numel(find(U==2));
        U_ISC = numel(find(U==3));
        U_STAB = numel(find(U==4));
        U_tot = numel(U);
        

        fprintf('\n\nPendant la ''crise'' %d:\n',C);
        fprintf('\t INERTIE =\t %d sur %d \n',U_INER,U_tot);
        fprintf('\t DSC =\t\t %d sur %d \n',U_DSC,U_tot);
        fprintf('\t ISC =\t\t %d sur %d \n',U_ISC,U_tot);
        fprintf('\t STABILITE =\t %d sur %d \n\n---- fini!\n',U_STAB,U_tot);
        
        fprintf(fid_sortie,'%d; %4.3f; %4.3f; %4.3f; %4.3f; %4.3f\n',Id(C),100*U_INER/U_tot,100*U_DSC/U_tot,100*U_ISC/U_tot,100*U_STAB/U_tot,SOMME);


        X(C,:) = [100*U_INER/U_tot,100*U_DSC/U_tot,100*U_ISC/U_tot,100*U_STAB/U_tot,SOMME];
end
        
fclose(fid_sortie);


[R, P] = corrcoef(X)



