function position = location(gps_data)
% INPUT: gps_data -- 1 by 3 vector representing the location of the GPS in LLA
% OUTPUT: position --1 by 3 vector representing the location of the in local NED coordinates
%         with respect to the initial position
%         x: North
%         y: East
%         z: Down

    persistent Latitude_base;
    persistent Longitude_base;
    persistent Height_base;
    persistent wgs84;
    
    Latitude = gps_data(1);
    Longitude = gps_data(2);
    Height = gps_data(3);
    
    if (isempty(Latitude_base))
        Latitude_base = Latitude;
        Longitude_base = Longitude;
        Height_base = Height;
        wgs84 = wgs84Ellipsoid;
        position = [0, 0, 0];
        return
    end
    [x, y, z] = geodetic2ned(Latitude,Longitude,Height,Latitude_base,Longitude_base,Height_base,wgs84);
    position = [x, y, z];
end

