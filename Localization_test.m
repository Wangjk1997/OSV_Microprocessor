wgs84 = wgs84Ellipsoid;
lat0 = 33.77788543701171875000;
lon0 = -84.40833282470703125000;
h0 = 322.02999877929687500000;

% lat = 44.544;
% lon = -72.814;
% h = 1340;

lat = 33.77788925170898437500;
lon = -84.40834045410156250000;
h = 319.10000610351562500000;

[x,y,z] = geodetic2ned(lat,lon,h,lat0,lon0,h0,wgs84)

% [lat,lon,h] = ned2geodetic(xNorth,yEast,zDown,lat0,lon0,h0,wgs84);