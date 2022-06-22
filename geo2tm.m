function [north, east] = geo2tm(phi, lambda, ell, mc, k0, fn, fe)
% GEO2TM coordenadas norte y este Tranverse de Mercator (TM).
%
%   [N, E] = GEO2TM(PHI, LB, ELL, MC, K0, FN, FE) retorna las cordenadas 
%   norte (N) y este (E) de la proyeccion TM para las coordenadas 
%   geodesicas latitud (PHI) y longitud (LAMBDA), expresadas en deg. 
%   Además, recibe como argumento el código EPSG del elipsoide (ELL), y los
%   parametros del huso TM: meridiano central (MC) expresado en grados 
%   decimales del huso TM, factor de escala en el meridiano central (K0), 
%   falso norte (FN) y falso este (FE) en metros.
%
%   Geographical Coordinates into TM Coordinates Algorithm.
%   Blachut, T. J., Chrzanowski, A., & Saastamoinen, J. H. (1979). 
%   Urban Surveying and Mapping. New York, NY: Springer New York. pp. 22-23
%
%   author: ahar0n
%     date: 2016.10.23
%
% See also MERIDIONALARC ELLIPSOID

my_ellipsoid = ellipsoid(ell);
a = my_ellipsoid.SemiMajorAxis;
e = my_ellipsoid.FirstExcentricity;
ee = my_ellipsoid.SecondExcentricity;
c = my_ellipsoid.PolarRadiusCurvature;

[~, ~, ~, P] = earthradius(phi, a, e);

B = meridionalarc(phi, ee, c);

a1 = P;
a2 = a1/2 * sind(phi);
a3 = a1/6 * (-1 + 2*cosd(phi)^2 + ee^2*cosd(phi)^4);
a4 = a2/12 * (-1 + 6*cosd(phi)^2 + 9*ee^2*cosd(phi)^4 + 4*ee^4*cosd(phi)^6);
a5 = a1/120 * (1 - 20*cosd(phi)^2 + (24-58*ee^2)*cosd(phi)^4 + 72*ee^2*cosd(phi)^6);
a6 = a2/360 * (1 - 60*cosd(phi)^2 + 120*cosd(phi)^4);

% cartesian coordinates
delta_lambda = deg2rad(lambda - mc);

x = B + a2*delta_lambda^2 + a4*delta_lambda^4 + a6*delta_lambda^6;
y = a1*delta_lambda + a3*delta_lambda^3 + a5*delta_lambda^5;

north = fn + k0 * x;
east = fe + k0 * y;
 
end