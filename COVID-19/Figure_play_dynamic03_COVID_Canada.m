

clear
%close all
clc

EVENT_NAME = 'COVID-19';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      3 EVENTS                           %
% Cet evenement permet de creer l'etat initial de stabilite:
EVENT{1}.name = '';
EVENT{1}.PACE.centre        = -350;
EVENT{1}.PACE.taille        =  700;
EVENT{1}.PACE.amplitude     = -1;
EVENT{1}.RUPTURE.centre     = -300;
EVENT{1}.RUPTURE.taille     =  700;
EVENT{1}.RUPTURE.amplitude  = -1; 
EVENT{1}.IDENTITY.centre    = -250;
EVENT{1}.IDENTITY.taille    =  700;
EVENT{1}.IDENTITY.amplitude = -0.02;




% PREMIER EVENEMENT DRAMATIQUE
EVENT{2}.name = 'Lockdown';
EVENT{2}.PACE.centre        = 700;
EVENT{2}.PACE.taille        = 300;
EVENT{2}.PACE.amplitude     = 0.35;

EVENT{2}.RUPTURE.centre     = 700;
EVENT{2}.RUPTURE.taille     =  300;
EVENT{2}.RUPTURE.amplitude  = -0.34;

EVENT{2}.IDENTITY.centre    = 700;
EVENT{2}.IDENTITY.taille    = 300;
EVENT{2}.IDENTITY.amplitude = -0.38;

% DEUXIEME EVENEMENT DRAMATIQUE
EVENT{3}.name = 'CSHLD';
EVENT{3}.PACE.centre        = 1010;
EVENT{3}.PACE.taille        = 300;
EVENT{3}.PACE.amplitude     = 0.76;

EVENT{3}.RUPTURE.centre     = 1060;
EVENT{3}.RUPTURE.taille     = 300;
EVENT{3}.RUPTURE.amplitude  = -0.09;

EVENT{3}.IDENTITY.centre    = 1120;
EVENT{3}.IDENTITY.taille    = 300;
EVENT{3}.IDENTITY.amplitude = -0.58;


% VOUS POUVEZ EN AJOUTER AUTANT QUE VOUS VOULEZ...
% SEULE CONTRAINTE:LA TAIILE MAXIMALE DE LA DUREE SIMULEE
% EST 2000 ECHANTILLONS DE TEMPS 


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('./ressources'));
make_Simul_COVID19(EVENT,EVENT_NAME);                                  %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

