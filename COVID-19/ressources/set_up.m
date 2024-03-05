% Set-up

% this command clears the variables and cleans the window of command  
% this command makes a link with the ressources that contains the necessary functions to run the program

addpath('./ressources');

% ===== Roxane's model (de la Sablonnière, 2017; de la Sablonnière, Lina, 
% & Cárdenas, 2018; Stability= 2017 and ISC = 2017 and 2018)
% DSC= dramatic social change and ISC = incremental social change

TREE.states = {'DSC','ISC','Inertia','Stability'};

TREE.initial_state = 0;
TREE.P_of_leaves   = {};
TREE.Nleaves       = 16;
TREE.leaves        = zeros(TREE.Nleaves,1);


    P_DSC;       TREE.P_of_leaves{1} = P;
    P_ISC;       TREE.P_of_leaves{2} = P;
    P_inertia;   TREE.P_of_leaves{3} = P;
    P_stability; TREE.P_of_leaves{4} = P;


