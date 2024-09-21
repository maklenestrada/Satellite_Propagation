function [num_launches, num_spacecraft, satellite_list] = loadConstellation(filename)
name = filename; 
fid = fopen(name); 
rawdat = fread(fid,inf); 
str = char(rawdat'); 
fclose(fid); 
data = jsondecode(str);
nl = length(data.launches);
idx = 1;
%Calculates Number of Launches
for i = 1:nl
    for j = 1:length(data.launches(i).payload)
        outer(idx) = data.launches(i).payload(j);
        idx = idx+1;
    end
end
%Calculates number of Spacecraft
ns = length(outer);

% %Pre-allocate the satellite_list struct
for i = 1:ns
    satellite_list(i).name = '';
    satellite_list(i).oe0 = NaN(6,1);
end

%Assigns the name to the satellite_list
count = 1;
for i = 1:length(data.launches)
    for j = 1:length(data.launches(i).payload)
        satellite_list(count).name = data.launches(i).payload(j).name;
        count = count +1;
    end
end

%Adds the orbit elem to oe
count = 1;
for i = 1:length(data.launches)
    for j = 1:length(data.launches(i).payload)
        oe(count,1:5) = cell2mat(struct2cell(data.launches(i).orbit(:)));
    count = count +1;
   end
end

%Adds the foci to oe
count = 1;
for i = 1:length(data.launches)
    for j = 1:length(data.launches(i).payload)
        oe(count,6) = data.launches(i).payload(j).f;
        count = count +1;
    end
end
for i = 1:ns
    satellite_list(i).oe0 = oe(i,:);
end

%Outputs
num_launches = nl;
num_spacecraft = ns;
end