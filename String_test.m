function output = location(gps_data)
    persistent Latitude_left_base;
    persistent Longitude_left_base;
    persistent Height_left_base;
    persistent Latitude_right_base;
    persistent Longitude_right_base;
    persistent Height_right_base;
    persistent wgs84;
    
    split_result = strsplit(gps_data);
    Latitude_left = str2num(split_result(1));
    Longitude_left = str2num(split_result(2));
    Height_left = str2num(split_result(3));
    Latitude_right = str2num(split_result(4));
    Longitude_right = str2num(split_result(5));
    Height_right = str2num(split_result(6));
    
    if (isempty(Latitude_right_base))
        Latitude_left_base = Latitude_left;
        Longitude_left_base = Longitude_left;
        Height_left_base = Height_left;
        Latitude_right_base = Latitude_right;
        Longitude_right_base = Longitude_right;
        Height_right_base = Height_right;
        wgs84 = wgs84Ellipsoid;
        output = [0, 0, 0];
        return
    end
    
end

function 