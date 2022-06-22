% parameters

wgs84 = 7030;
lat = -27.48952286;	
lon = -70.38577473;

fn = 10000000;
fe = 500000;
k = 0.9996;
mc_h19 = -69;

% geo2tm
[north, east] = geo2tm(lat, lon, wgs84, mc_h19, k, fn, fe);

% tm2geo
n = 6958579.443;
e = 363102.736;
[lati, long] = tm2geo(n, e, wgs84, mc_h19, k, fn, fe);

% ecef2geo
[lat, lon, h] = ecef2geo(1537120.728, -4829700.314, -3859219.438, wgs84);

% geo2ecef
[x, y, z] = geo2ecef(-37.472260638, -72.34558946, -72.346, wgs84);