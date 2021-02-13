wgs84 = wgs84Ellipsoid;
lat0 = 44.532;
lon0 = -72.782;
h0 = 1699;

lat = 44.544;
lon = -72.814;
h = 1340;

[xNorth,yEast,zDown] = geodetic2ned(lat,lon,h,lat0,lon0,h0,wgs84)

[lat,lon,h] = ned2geodetic(xNorth,yEast,zDown,lat0,lon0,h0,wgs84)