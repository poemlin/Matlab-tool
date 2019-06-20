
folder = 'd:\dataset\wjj\test';
files = dir([folder '\*.jpg']);
for i = 1 : numel(files)
    oldname = files(i).name;
    I = imread(oldname);
    %[pathstr, name, ext] = fileparts(oldname) ;
    %if i<10
    newname = strcat('wjj.',num2str(i)-1,'.jpg');
    imwrite(I,newname,'jpg');
    %elseif i>=10
        %newname = strcat('00',num2str(i),'.jpg');
        %imwrite(I,newname,'jpg');
    %end
end