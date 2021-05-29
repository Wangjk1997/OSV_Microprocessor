function [gps_data, IMU_data] = rawDataProcessing(raw_data)
% INPUT:　raw_data --string raw data from Arduino including GPS and IMU
% OUTPUT: gps_data --1 by 6 vector representing the location of two rovers in LLA
%         IMU_data --1 by 9 vector representing the data from IMU

    split_result = strsplit(raw_data);
    
    gps_data = zeros(1,6);
    gps_data(1) = str2double(split_result(3)); %Latitude_left
    gps_data(2) = str2double(split_result(4)); %Longitude_left
    gps_data(3) = str2double(split_result(5)); %Height_left
    gps_data(4) = str2double(split_result(18)); %Latitude_right
    gps_data(5) = str2double(split_result(19)); %Longitude_right
    gps_data(6) = str2double(split_result(20)); %Height_right
    
    IMU_data = zeros(1,9); %ENU coordinate system
    IMU_data(1) = str2double(31); %acceleration_x
    IMU_data(2) = str2double(32); %acceleration_y
    IMU_data(3) = str2double(33); %acceleration_z
    IMU_data(4) = str2double(34); %angular_velocity_x
    IMU_data(5) = str2double(35); %angular_velocity_y
    IMU_data(6) = str2double(36); %angular_velocity_z
    IMU_data(7) = str2double(37); %mag_x
    IMU_data(8) = str2double(38); %mag_y
    IMU_data(9) = str2double(39); %mag_z
end