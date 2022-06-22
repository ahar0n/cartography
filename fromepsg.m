function [obj] = fromepsg(code)
% FROMEPSG Parametros del elipsoide.
%
%   [O] = FROMEPSG(code) retorna objeto (struct) asociado al código EPSG,
%   desde la base de datos de EPSG. El objeto es obtenido desde el 
%   webservice RESTFul del EPSG.org (https://epsg.org/info-api.html).
%
%
%   author: ahar0n
%     date: 2022.06.10

url = strcat('https://apps.epsg.org/api/v1/Ellipsoid/',num2str(code),'/');
obj = webread(url);

end