function position = location(gps_data, distance)
% INPUT: gps_data -- 1 by 6 vector representing the location of two rovers in LLA
%        distance --measured distance between two rovers in North-South direction
% OUTPUT: position --1 by 6 vector representing the location of two rovers in local NED coordinates
%         with respect to rover_left_base
%         x: North
%         y: East
%         z: Down

    persistent Latitude_left_base;
    persistent Longitude_left_base;
    persistent Height_left_base;
    persistent Latitude_right_base;
    persistent Longitude_right_base;
    persistent Height_right_base;
    persistent wgs84;
    
    Latitude_left = gps_data(1);
    Longitude_left = gps_data(2);
    Height_left = gps_data(3);
    Latitude_right = gps_data(4);
    Longitude_right = gps_data(5);
    Height_right = gps_data(6);
    
    if (isempty(Latitude_left_base))
        Latitude_left_base = Latitude_left;
        Longitude_left_base = Longitude_left;
        Height_left_base = Height_left;
        Latitude_right_base = Latitude_right;
        Longitude_right_base = Longitude_right;
        Height_right_base = Height_right;
        wgs84 = wgs84Ellipsoid;
        position = [0, 0, 0, distance, 0, 0];
        return
    end
    [x_left, y_left, z_left] = geodetic2ned(Latitude_left,Longitude_left,Height_left,Latitude_left_base,Longitude_left_base,Height_left_base,wgs84);
    [x_right_r, y_right_r, z_right_r] = geodetic2ned(Latitude_right,Longitude_right,Height_right,Latitude_right_base,Longitude_right_base,Height_right_base,wgs84);
    x_right = x_right_r + distance;
    y_right = y_right_r;
    z_right = z_right_r;
    position = [x_left, y_left, z_left, x_right, y_right, z_right];
end

