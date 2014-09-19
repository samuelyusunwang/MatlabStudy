function simple_gui2

% SIMPLE_GUI2 select a data set from the pop-up menu, then 
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.

% create a figure
f = figure('Visible','off', 'Position',[360,500,450,285]);

% construct components 
hsurf = uicontrol('Style','pushbutton', 'String','Surf', 'Position',[315,220,70,25]);
hmesh = uicontrol('Style','pushbutton', 'String','Mesh', 'Position',[315,180,70,25]);
hcontour = uicontrol('Style','pushbutton', 'String','Countour', 'Position',[315,135,70,25]);

hpopup = uicontrol('Style','popupmenu', 'String',{'Peaks','Membrane','Sinc'}, 'Position',[300,50,100,25]);
htext = uicontrol('Style','text', 'String','Select Data', 'Position',[325,90,60,15]);

ha = axes('Units','pixels', 'Position',[50,60,200,185]);

% align the components
align([hsurf,hmesh,hcontour,htext,hpopup], 'Center', 'None');

% make the GUI visible
set(f, 'Visible', 'on');














end % simple_gui2