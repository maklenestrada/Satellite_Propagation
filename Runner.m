clear all;clc
[num_launches, num_spacecraft, satellite_list] = loadConstellation('example_constellation.json');

%% Constants
J2=1082.63*10^(-6);
Re=6378.137;%km
MU=398600;
t_o = 0;

%% Orbits Data
%Presets Orbit List
for i = 1:length(satellite_list)
    orbit(:,i).traj = [];
end

count = 1;
for i = 1:length(satellite_list)
    clear orb
    for t = 0:30:86400
        x = propagateState(satellite_list(i).oe0,t,t_o,MU,J2,Re);
        orb(count,1:3) = x(1:3);
        count = count +1;
    end
    orbit(i).traj = orb;  
end
%For Loop to get the total num of rows and col
for i = 1:length(satellite_list)
[row col] = size(orbit(end).traj);
end

%For Loop to print 1 orbit at a time
count = 1;
for i = 1:length(satellite_list)
    step = row/col;  
    o = orbit(i).traj;
    if count == 1
       plot3(o(:,1),o(:,2),o(:,3),'r')
       hold on
    else
        count = count -1;
        step = step*count +1;
        plot3(o((step):end,1),o((step):end,2),o((step):end,3),'r')
        count = count +1;
    end
    count = count +1;
end
%% Map
%Load Data
load('world_coastline_low.txt');
WorldCit = readtable('worldcities.csv');

%Converting coastlines to 3d
lat = deg2rad(world_coastline_low(:,1));
lon = deg2rad(world_coastline_low(:,2));
[Coast_x,Coast_y,Coast_z] =  sph2cart(lat,lon,Re);

%Converting World Cit to 3d
latcit = deg2rad(table2array(WorldCit(:,3)));
loncit = deg2rad(table2array(WorldCit(:,4)));
[Cit_x,Cit_y,Cit_z] = sph2cart(loncit,latcit,Re);

%% Plots
hold on
plot3(Coast_x,Coast_y,Coast_z,'k')
scatter3(Cit_x,Cit_y,Cit_z,'.b')
%Making a Sphere
rx = Re;
ry = Re;
rz = Re;
[rx ry rz] = sphere;
surf(rx,ry,rz,'FaceColor','k','EdgeColor','k')
grid on
axis equal

% %%
% %For Loop for LoS check
% count = 1;
% elev = 15;%Deg
% Cit = length(Cit_x)
% inLos = zeros(Cit,length(orb));
% for i = 1:length(satellite_list)
%     step = row/col;  
%     o = orbit(i).traj;
%     if count == 1
%        list(:,i) = inLosFunc([Cit_x(:),Cit_y(:),Cit_z(:)],o(1:step,:),elev,step,Cit);
%        hold on
%     else
%         count = count -1;
%         step = step*count +1;
%         list(:,i) = inLosFunc([Cit_x(:),Cit_y(:),Cit_z(:)],o((step):end,:),elev,step,Cit);
%          count = count +1;
%     end
%     count = count +1;
% end
% %% InLoS Func
% function inLos = inLosFunc(r_city,r_sat,elev,step,Cit)
%     for t = 1:step
%            for c = 1:Cit
%                inLos(c,t) = testLoS(r_city(c,:),r_sat(t,:),elev)
%            end
%     end
% end
