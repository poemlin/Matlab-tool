
clear all;
clc;
str='D:\myCode\matlab\guiyi\';
n = 002696;
for p=1:n  %nΪͼ���е�ͼƬ��
    ai=imread([str,num2str(p),'.jpg']);
    ci=imresize(ai,[256 256]);        
    figure;
    imshow(ci);
    imwrite(ci,strcat('D:\myCode\matlab\guiyi\',num2str(p),'.bmp'));
end

