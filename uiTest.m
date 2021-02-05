% create figure and uicontextmenu
f = figure;
c = uicontextmenu (f);

% create menus in the context menu
m1 = uimenu ("parent",c,"label","Menu item 1","callback","disp('menu item 1')");
m2 = uimenu ("parent",c,"label","Menu item 2","callback","disp('menu item 2')");

% set the context menu for the figure
set (f, "uicontextmenu", c);