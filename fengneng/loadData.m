function [ dataSet ] = loadData( file,place )
%读取指定文件
dataSet = xlsread(file,place); 
end

