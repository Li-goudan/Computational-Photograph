%% my_gui
function my_gui(R,G,B)
fig = figure('Name', 'test', 'KeyPressFcn', @myKeyPress, ...
    'WindowButtonDownFcn', @myWindowButtonDown);

%[height, width] = size(R);

Roff = struct('img', R, 'x', 0, 'y', 0);
Goff = struct('img', G, 'x', 0, 'y', 0);
Boff = struct('img', B, 'x', 0, 'y', 0);

Icol = reconstruct(Roff.img, Goff.img, Boff.img);

% figure layout
ax(1) = subplot(3,4,1);
im(1) = imshow(Roff.img);
title({'Red Channel', '[x: 0, y: 0]'});

ax(2) = subplot(3,4,5);
im(2) = imshow(Goff.img);
title({'Green Channel', '[x: 0, y: 0]'});

ax(3) = subplot(3,4,9);
im(3) = imshow(Boff.img);
title({'Blue Channel', '[x: 0, y: 0]'});

ax(4) = subplot(3,4,[2:4 6:8 10:12]);
im(4) = imshow(Icol);
title('Color Reconstruction');

step = 1;
xinc = 0;
yinc = 0;
axes(ax(1));
set(get(ax(1),'Title'),'Color','r','FontWeight','bold');

%% myKeyPress
    function myKeyPress(src,evnt)
        key_id = double(evnt.Character);

        if(~isempty(strfind(cell2mat(evnt.Modifier), 'shift')))
            step = 10;
        else
            step = 1;
        end

        xinc = 0;
        yinc = 0;
        if(~isempty(key_id))
            switch(key_id)
                case {28, 65, 97} % -- arrow left / a
                    xinc = -step;
                case {29, 68, 100} % -- arrow right / d
                    xinc =  step;
                case {30, 87, 119} % -- arrow up / w
                    yinc = -step;
                case {31, 83, 115} % -- arrow down / s
                    yinc =  step;
                case {49, 114} % -- 1 / r
                    axes(ax(1));
                    %disp('red');
                case {50, 103} % -- 2 / g
                    axes(ax(2));
                    %disp('green');
                case {51,  98} % -- 3 / b
                    axes(ax(3));
                    %disp('blue');
                case {99} % -- c clear settings
                    Roff = struct('img', R, 'x', 0, 'y', 0);
                    Goff = struct('img', G, 'x', 0, 'y', 0);
                    Boff = struct('img', B, 'x', 0, 'y', 0);
                    Icol = reconstruct(Roff.img, Goff.img, Boff.img);

                    set(im(1),'CData',Roff.img);
                    set(get(ax(1),'Title'),'String',{'Red Channel', ...
                        '[x: 0, y: 0]'});

                    set(im(2),'CData',Goff.img);
                    set(get(img,'Title'),'String',{'Green Channel', ...
                        '[x: 0, y: 0]'});

                    set(im(3),'CData',Boff.img);
                    set(get(ax(3),'Title'),'String',{'Blue Channel', ...
                        '[x: 0, y: 0]'});

                    set(im(4),'CData',Icol);
                    set(get(ax(4),'Title'),'String','Color Reconstruction');
                    return

                    %case {13} % -- enter
                    %case {27} % -- esc
            end
        end

        switch(gca)
            case ax(1)
                Roff.img = circshift(Roff.img, [yinc xinc]);
                set(im(1),'CData',Roff.img);
                Roff.x = Roff.x + xinc;
                Roff.y = Roff.y + yinc;
                set(get(ax(1),'Title'),'String',{'Red Channel', ...
                    ['[x: ', num2str(Roff.x), ...
                    ', y: ', num2str(Roff.y),']']});
            case ax(2)
                Goff.img = circshift(G, [Goff.y+yinc Goff.x+xinc]);
                set(im(2),'CData',Goff.img);
                Goff.x = Goff.x + xinc;
                Goff.y = Goff.y + yinc;
                set(get(ax(2),'Title'),'String',{'Green Channel', ...
                    ['[x: ', num2str(Goff.x), ...
                    ', y: ', num2str(Goff.y),']']});
            case ax(3)
                Boff.img = circshift(B, [Boff.y+yinc Boff.x+xinc]);
                set(im(3),'CData',Boff.img);
                Boff.x = Boff.x + xinc;
                Boff.y = Boff.y + yinc;
                set(get(ax(3),'Title'),'String',{'Blue Channel', ...
                    ['[x: ', num2str(Boff.x), ...
                    ', y: ', num2str(Boff.y),']']});
        end

        set(get(ax(1),'Title'),'Color','k','FontWeight','normal');
        set(get(ax(2),'Title'),'Color','k','FontWeight','normal');
        set(get(ax(3),'Title'),'Color','k','FontWeight','normal');
        set(get(ax(4),'Title'),'Color','k','FontWeight','normal');
        set(get(gca,'Title'),'Color','r','FontWeight','bold');

        Icol = reconstruct(Roff.img,Goff.img,Boff.img);
        set(im(4),'CData',Icol);
        set(get(ax(4),'Title'),'String','Color Reconstruction');
    end

%% myWindowButtonDown
    function myWindowButtonDown(src,evnt)
        set(get(ax(1),'Title'),'Color','k','FontWeight','normal');
        set(get(ax(2),'Title'),'Color','k','FontWeight','normal');
        set(get(ax(3),'Title'),'Color','k','FontWeight','normal');
        set(get(ax(4),'Title'),'Color','k','FontWeight','normal');
        set(get(gca,'Title'),'Color','r','FontWeight','bold');

        switch(gca)
            case ax(1)
                %disp('red');
            case ax(2)
                %disp('green');
            case ax(3)
                %disp('blue');
            case ax(4)
                %disp('color');
                Icol = reconstruct(Roff.img,Goff.img,Boff.img);
                set(im(4),'CData',Icol);
                set(get(ax(4),'Title'),'String','Color Reconstruction');
        end
    end
end
