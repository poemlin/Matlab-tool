function [  ] = drawmap(data)
map1=shaperead('./vector/js_polygont.shp');
mapshow(map1);
hold on;
plot(119.12,34.83,'.','MarkerEdgeColor','k','MarkerSize',16);%赣榆
text(119.12,34.83,num2str(data(1)));
plot(119.02,33.63,'.','MarkerEdgeColor','k','MarkerSize',16);%淮阴
text(119.02,33.63,num2str(data(2)));
plot(118.8,32,'.','MarkerEdgeColor','k','MarkerSize',16);%南京
text(118.8,32,num2str(data(3)));
plot(119.833,32.933,'.','MarkerEdgeColor','k','MarkerSize',16);%兴化
text(119.833,32.933,num2str(data(4)));
plot(119.55,31.75,'.','MarkerEdgeColor','k','MarkerSize',16);%金坛
text(119.55,31.75,num2str(data(5)));
plot(117.15,34.2833,'.','MarkerEdgeColor','k','MarkerSize',16);%徐州
text(117.15,34.2833,num2str(data(6)));
plot(119.4667,32.25,'.','MarkerEdgeColor','k','MarkerSize',16);%镇江
text(119.4667,32.25,num2str(data(7)));
plot(120.95,31.417,'.','MarkerEdgeColor','k','MarkerSize',16);%昆山
text(120.95,31.417,num2str(data(8)));
end