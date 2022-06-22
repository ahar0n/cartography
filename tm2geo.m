function [phi, lambda] = tm2geo(north, east, ell, mc, k0, fn, fe)
% TM2GEO coordenadas norte y este Tranverse de Mercator (TM).
%
%   [PHI, LB] = TM2GEO(N, E, ELL, MC, K0, FN, FE) retorna las coordenadas
%   geodesicas latitud (PDI) y longitud (LB) sobre el elipsoide (ELL)
%   a partir de las coordenadas TM norte (N) y este (E). Además, recibe 
%   como argumento el código EPSG del elipsoide (ELL), y los parametros 
%   del huso TM: meridiano central (MC) expresado en grados decimales del 
%   huso TM, factor de escala en el meridiano central (K0), falso norte 
%   (FN) y falso este (FE) en metros.
%
%   Algorithm: Geographical Coordinates into TM Coordinates
%   Blachut, T. J., Chrzanowski, A., & Saastamoinen, J. H. (1979). 
%   Urban Surveying and Mapping. New York, NY: Springer New York. pp. 24
%
%   author: ahar0n
%     date: 2016.10.23
%
% See also GEO2TM ELIPSOIDGRS MERIDIONALARC

% Algoritmo utiliza la formulacion convencional (iterativa)

my_ellipsoid = ellipsoid(ell);
a = my_ellipsoid.SemiMajorAxis;
e = my_ellipsoid.FirstExcentricity;
ee = my_ellipsoid.SecondExcentricity;
c = my_ellipsoid.PolarRadiusCurvature;

x = (north - fn) / k0;
y = (east - fe) / k0;

A0 = meridionalarc(NaN, ee, c);

phi1 = x / (A0*c);
B1 = meridionalarc(rad2deg(phi1), ee, c);
while abs(B1 - x) > 0.00005             % end with precision of 0.05mm
    phi1 = phi1 + (x - B1)/(A0*c);
    B1 = meridionalarc(rad2deg(phi1), ee, c);
end

[~, ~, ~, P1] = earthradius(rad2deg(phi1), a, e);
b1 = 1/P1;
b2 = -1/2*b1^2*sin(phi1)*cos(phi1)*(1 + ee^2*cos(phi1)^2);
b3 = -1/6*b1^3*(2 - cos(phi1)^2 + ee^2*cos(phi1)^4);
b4 = -1/12*b1^2*b2*(3 + (2-9*ee^2)*cos(phi1)^2 + 10*ee^2*cos(phi1)^4 - 4*ee^4*cos(phi1)^6);
b5 = 1/120*b1^5*(24 - 20*cos(phi1)^2 + (1 + 8*ee^2)*cos(phi1)^4 - 2*ee^2*cos(phi1)^6);
b6 = 1/360*b1^4*b2*(45 + 16*cos(phi1)^4);

phi = rad2deg(phi1 + b2*y^2 + b4*y^4 + b6*y^6);
lambda = rad2deg(deg2rad(mc) + b1*y + b3*y^3 + b5*y^5);

end