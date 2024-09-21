function inLoS = testLoS(r_site,r_sc,elevation_limit)
rcross = dot(r_site,r_sc);
theta = acos(norm(rcross)/(norm(r_site)*norm(r_sc)));
if theta < elevation_limit 
    inLoS = 1;
else 
    inLoS = 0;
end
end
%