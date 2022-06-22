function [B, A0] = meridionalarc(phi, ee, c)
% MERIDIONALARC longitud del arco de meridiano hasta e'10, en el ecuador 
%   para la latitud (PHI).
%
%   [B] = MERIDIONALARC(PHI, E, C) calcula el arco de meridiano (B) para
%   la latitud (PHI) sobre el elipsoide de parametros, 2da exentricidad (E) 
%   y radio polar (C).
%
%   [A0] = MERIDIONALARC(PHI, E, C) retorna la constante A0 de la serie 
%   (A0, A1,..., An) involucrada en el calculo de B, cuando phi = NaN.
%
%   Arc Meridional Algorithm (Conventional formulas).
%   Blachut, T. J., Chrzanowski, A., & Saastamoinen, J. H. (1979). 
%   Urban Surveying and Mapping. New York, NY: Springer New York. pp. 18-20
%
%
%   author: ahar0n
%     date: 2016.10.23
%
% See also EARTHRADUIS ELLIPSOID

% Longitud del arco de meridiano (aproximacion de la integral)
A0 = 1 - 3/4 * ee^2 * (1 - 15/16*ee^2 * (1 - 35/36*ee^2 * (1 - 63/64*ee^2 * (1 - 99/100*ee^2))));
A1 = 3/4 * ee^2 * (1 - 25/16*ee^2 * (1 - 77/60*ee^2 * (1 - 837/704*ee^2 * (1 - 2123/1860*ee^2))));
A2 = 5/8 * ee^2 * (1 - 139/144*ee^2 * (1 - 1087/1112*ee^2 * (1 - 513427/521760*ee^2)));
A4 = 35/72 * ee^4 * (1 - 125/64*ee^2 * (1 - 221069/150000*ee^2));
A6 = 105/256 * ee^6 * (1 - 1179/400*ee^2);
A8 = 231/640*ee^8;

if ~isnan(phi)
    B = A0*c*deg2rad(phi) - A1*c*sind(phi)*cosd(phi) * ... 
        (1 + A2*sind(phi)^2 + A4*sind(phi)^4 + A6*sind(phi)^6 +... 
        A8*sind(phi)^8);
else
    B = A0;
end