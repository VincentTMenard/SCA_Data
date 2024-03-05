

clear
%close all
clc

EVENT_NAME = 'USA';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      3 EVENTS                           %
% Cet evenement permet de creer l'etat initial de stabilite:
% PREMIER EVENEMENT DRAMATIQUE
EVENT{1}.name = '';
EVENT{1}.PACE.centre = -205;
EVENT{1}.PACE.taille = 410;
EVENT{1}.PACE.amplitude = -0.75;
EVENT{1}.RUPTURE.centre = -155;
EVENT{1}.RUPTURE.taille = 410;
EVENT{1}.RUPTURE.amplitude = -1;
EVENT{1}.IDENTITY.centre = -105;
EVENT{1}.IDENTITY.taille = 410;
EVENT{1}.IDENTITY.amplitude = 0.06;

% DEUXIEME EVENEMENT DRAMATIQUE
EVENT{2}.name = 'Lockdown';
EVENT{2}.PACE.centre = 700;
EVENT{2}.PACE.taille = 300;
EVENT{2}.PACE.amplitude = 0.98;
EVENT{2}.RUPTURE.centre = 750;
EVENT{2}.RUPTURE.taille = 300;
EVENT{2}.RUPTURE.amplitude = -0.32;
EVENT{2}.IDENTITY.centre = 800;
EVENT{2}.IDENTITY.taille = 300;
EVENT{2}.IDENTITY.amplitude = 0.07;

% TROISIEME EVENEMENT DRAMATIQUE
EVENT{3}.name = 'Community transmission';
EVENT{3}.PACE.centre = 1100;
EVENT{3}.PACE.taille = 300;
EVENT{3}.PACE.amplitude = 0.78;
EVENT{3}.RUPTURE.centre = 1150;
EVENT{3}.RUPTURE.taille = 300;
EVENT{3}.RUPTURE.amplitude = 0.13;
EVENT{3}.IDENTITY.centre = 1200;
EVENT{3}.IDENTITY.taille = 300;
EVENT{3}.IDENTITY.amplitude = 0.02;


% VOUS POUVEZ EN AJOUTER AUTANT QUE VOUS VOULEZ...
% SEULE CONTRAINTE:LA TAIILE MAXIMALE DE LA DUREE SIMULEE
% EST 2000 ECHANTILLONS DE TEMPS 


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('./ressources'));
make_Simul_COVID19(EVENT,EVENT_NAME);                                  %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

