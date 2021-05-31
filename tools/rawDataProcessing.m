function [gps_data, IMU_data] = rawDataProcessing(raw_data)
% INPUT:　raw_data --string raw data from Arduino including GPS and IMU
% OUTPUT: gps_data --1 by 6 vector representing the location of two rovers in LLA
%         IMU_data --1 by 9 vector representing the data from IMU

    split_result = strsplit(raw_data,";");
    gps_left = strsplit(split_result(1),",");
    gps_right = strsplit(split_result(2),",");
    IMU = strsplit(split_result(3),",");
    
    gps_data = zeros(1,6);
    gps_data(1) = str2double(gps_left(1)); %Latitude_left
    gps_data(2) = str2double(gps_left(2)); %Longitude_left
    gps_data(3) = str2double(gps_left(3)); %Height_left
    gps_data(4) = str2double(gps_right(1)); %Latitude_right
    gps_data(5) = str2double(gps_right(2)); %Longitude_right
    gps_data(6) = str2double(gps_right(3)); %Height_right
    
    IMU_data = zeros(1,9); %ENU coordinate system
    IMU_data(1) = str2double(IMU(1)); %acceleration_x
    IMU_data(2) = str2double(IMU(2)); %acceleration_y
    IMU_data(3) = str2double(IMU(3)); %acceleration_z
    IMU_data(4) = str2double(IMU(4)); %angular_velocity_x
    IMU_data(5) = str2double(IMU(5)); %angular_velocity_y
    IMU_data(6) = str2double(IMU(6)); %angular_velocity_z
    IMU_data(7) = str2double(IMU(7)); %mag_x
    IMU_data(8) = str2double(IMU(8)); %mag_y
    IMU_data(9) = str2double(IMU(9)); %mag_z
end