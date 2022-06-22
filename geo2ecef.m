function [x, y, z] = geo2ecef(lat, lon, h, code)
%GEO2ECEF coordenadas cartesianas geocéntricas ECEF.
%
% [X, Y, Z] = GEO2ECEF(LAT, LON, H, C)
%
% Algoritmo obtenido desde Rapp, R. H. Geometric geodesy. (Ohio State 
% University, Department of Geodetic Sciences, 1984).
  

my_ellipsoid = ellipsoid(code);

a = my_ellipsoid.SemiMajorAxis;
b = my_ellipsoid.SemiMinorAxis;
e = my_ellipsoid.FirstExcentricity;

[N, ~, ~, ~] = earthradius(lat, a, e);

x = (N + h) * cosd(lat) * cosd(lon);
y = (N + h) * cosd(lat) * sind(lon);
z = ((b^2 / a^2)*N + h) * sind(lat);

end