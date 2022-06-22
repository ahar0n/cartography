function [lat, lon, h] = ecef2geo(x, y, z, code)
%ECEF2GEO coordenadas geodésicas.
%
%   [LAT, LON, H] = ECEF2GEO(X, Y, Z, ELL) convierte las coordenadas
%   cartesiandas tridimensionales (ECEF) del punto con posición (X,Y,Z) en
%   coordenadas geodésicas (phi, lambda, height) sobre el eliposoide de
%   referencia con codigo EPSG (ELL).
%
%   Algoritmo obtenido desde Rapp, R. H. Geometric geodesy. (Ohio State 
%   University, Department of Geodetic Sciences, 1984).

my_ellipsoid = ellipsoid(code);

a = my_ellipsoid.SemiMajorAxis;
e = my_ellipsoid.FirstExcentricity;

% conversion
lon = atand(y/x);

phi0 = atand(z/sqrt(x^2 + y^2) * (1+e^2/(1-e^2)));
while true
    [N, ~, ~, ~] = earthradius(phi0, a, e);
    lat = atand( z/sqrt(x^2 + y^2) * (1+ e^2*N*sind(phi0)/z) );
    if abs(lat-phi0) < 0.0000000001
        break
    end
    phi0 = lat;
end

[N, ~, ~, ~] = earthradius(lat, a, e);
if abs(lat) == 90
    h = z/sind(lat) - N*(1-e^2);
else
    h = sqrt(x^2 + y^2)/cosd(lat) - N;
end

end