function fig = make_tree()

if nargin==0

% Starting here, we are building the tree (Figure)
% position and size of the figure
fig = figure('position',[100 10 500 500]);
axis square
axis off

% the commands add to eachother
hold on

% key variables defined
X = 0.10;
Y = 0.50;
D = 0.15;

% line between Stability and Rapidity
plot([X,X+D],[Y,Y+0.2], 'k'); % To Rapid Event
plot([X,X+D],[Y,Y-0.2], 'k'); % To Slow Event

% lines between Rapid Event and Ruptures
plot([X+D,X+2*D],[Y+0.2,Y+0.25], 'k');
plot([X+D,X+2*D],[Y+0.2,Y+0.35], 'k');
plot([X+D,X+2*D],[Y+0.2,Y+0.15], 'k');
plot([X+D,X+2*D],[Y+0.2,Y+0.05], 'k');

% lines between Slow Event and Ruptures
plot([X+D,X+2*D],[Y-0.2,Y+0.25-0.4], 'k');
plot([X+D,X+2*D],[Y-0.2,Y+0.35-0.4], 'k');
plot([X+D,X+2*D],[Y-0.2,Y+0.15-0.4], 'k');
plot([X+D,X+2*D],[Y-0.2,Y+0.05-0.4], 'k');

% There are the parameters for plotting the tree
for k = [7 5 3 1]
for j = [1 -1]
  plot([X+2*D X+3*D],[Y+0.05*k,Y+0.05*k+j*0.03], 'k'); 
end
end

for k = [1 3 5 7]
for j = [-1 1]
  plot([X+2*D X+3*D],[Y+0.05*k-0.4,Y+0.05*k+j*0.03-0.4], 'k'); 
end
end
end

if nargin>0
    % Here, we keep building the tree
% labels of leaves:
    u = 1;
    for l = [0 -1]
        for k = [7 5 3 1]
            for j = [1 -1]
                x = X+3*D;
                y = Y+0.4*l+0.05*k+j*0.03;
                text(x,y,TREE.leaves{TREE.selection_random(u)});
                u = u + 1;
            end
        end
    end


% First node: Societal state (DSC, ISC, Inertia or Stability)
plot(X,Y,'ok','markersize',20, 'MarkerFaceColor', [1 0 1]);

% label Societal state
text(0.05,0.5,TREE.leaves{initial_state},'fontsize',10);

% nodes Rapid and Slow event
plot(X+D,Y+0.2,'ok','markersize',16,'MarkerFaceColor', [1 1 0]);
plot(X+D,Y-0.2,'ok','markersize',16,'MarkerFaceColor', [0 1 1]);

% label Rapid event and Slow event
text(X+0.10,Y+0.2,'Rapid','fontsize',10);
text(X+0.10,Y-0.2,'Slow','fontsize',10);

% nodes Ruptures with Rapid event
% Ruptures = Rupture of social structure and Rupture of normative structure
plot(X+2*D,Y+0.35,'ok','markersize',14,'MarkerFaceColor', [0 1 1]);
plot(X+2*D,Y+0.25,'ok','markersize',14,'MarkerFaceColor', [1 0 0]);
plot(X+2*D,Y+0.15,'ok','markersize',14,'MarkerFaceColor', [1 0 1]);
plot(X+2*D,Y+0.05,'ok','markersize',14,'MarkerFaceColor', [0 0 1]);

% labels for Ruptures and Rapid event
% labels - Rupture of social structure (SS or NSS)
% labels - Rupture of normative structure (NS or NNS)
text(3*X,Y+0.35,'SS+NS','fontsize',8);
text(3*X,Y+0.25,'SS+NNS','fontsize',8);
text(3*X,Y+0.15,'NSS+NS','fontsize',8);
text(3*X,Y+0.05,'NSS+NNS','fontsize',8);

% nodes Ruptures with Slow event
plot(X+2*D,Y+0.35-0.4,'ok','markersize',14,'MarkerFaceColor', [1 0 0]);
plot(X+2*D,Y+0.25-0.4,'ok','markersize',14,'MarkerFaceColor', [1 0 0]);
plot(X+2*D,Y+0.15-0.4,'ok','markersize',14,'MarkerFaceColor', [1 0 0]);
plot(X+2*D,Y+0.05-0.4,'ok','markersize',14,'MarkerFaceColor', [1 0 0]);

% labels for Ruptures and Slow event
% labels - Rupture of social structure (SS or NSS)
% labels - Rupture of normative structure (NS or NNS)
text(3*X,Y+0.35-0.4,'SS+NS','fontsize',8);
text(3*X,Y+0.25-0.4,'SS+NNS','fontsize',8);
text(3*X,Y+0.15-0.4,'NSS+NS','fontsize',8);
text(3*X,Y+0.05-0.4,'NSS+NNS','fontsize',8);

% the limits of the x and y axes
xlim([0 1]); ylim([0 1]);

hold off
end




end