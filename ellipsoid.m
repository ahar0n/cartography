function [e] = ellipsoid(code)
% ELLIPSOID(CODE) parámetros del elipsoide geodesico.
%
%   [E] = ELLIPSOID(CODE) retorna el elipsoide geodésico asociado al 
%   código EPSG (code).
%
%       Códigos asociados de elipsoides comunes:
%       (https://spatialreference.org)
%
%       7019: GRS 1980
%       7022: International 1924
%       7030: WGS 1984
%
%
%   author: ahar0n
%     date: 2016.10.23
%
% See also MERIDIONALARC EARTHRADIUS

epsg_obj = fromepsg(code);

e.SemiMajorAxis = epsg_obj.SemiMajorAxis;           % a
e.InverseFlattening = epsg_obj.InverseFlattening;   % 1/f
e.Name = epsg_obj.Name;
e.Description = epsg_obj.Remark;

e.SemiMinorAxis = e.SemiMajorAxis * (1 - 1/e.InverseFlattening);    % b
e.PolarRadiusCurvature = e.SemiMajorAxis^2 / e.SemiMinorAxis;       % c
e.FirstExcentricity = sqrt((e.SemiMajorAxis^2 - e.SemiMinorAxis^2) / e.SemiMajorAxis^2);    % e
e.SecondExcentricity = sqrt((e.SemiMajorAxis^2 - e.SemiMinorAxis^2) / e.SemiMinorAxis^2);   % e'
e.AngularExcentricity = acos(e.SemiMinorAxis / e.SemiMajorAxis);
e.LinealExcentricity = e.SemiMajorAxis * sqrt(e.FirstExcentricity);
e.m = (e.SemiMajorAxis^2 - e.SemiMinorAxis^2) / (e.SemiMajorAxis^2 + e.SemiMinorAxis^2);
e.n = (e.SemiMajorAxis - e.SemiMinorAxis) / (e.SemiMajorAxis + e.SemiMinorAxis);

end