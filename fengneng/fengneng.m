clear;
place = {'淮阴','南京','兴化','徐州','赣榆','镇江','金坛','昆山'};
file = input('请输入文件地址：\n','s');  
yer = linspace(1981,2010,30);
ms=zeros(30,1);
me=zeros(30,1);
ew=zeros(30,1);

for as = 1:length(place)
    data = loadData(file,place{as});
    for i=1:length(yer)              
       year=yer(i);
       ws = data(data(:,2) == year,4);
       ws = ws(ws>0);         
       [k,c]=pjfshbzc(ws);
       [msmw,memw,ewt]=windener(k,c);
       ms(i,1)=msmw;me(i,1)=memw;ew(i,1)=ewt;
    end
    outpla = ('output\pla风能指标.xlsx');
    outfile = strrep(outpla,'pla',place(as));
    
    xlswrite(outfile{1},ms,place{as},'A1:A30')   
    xlswrite(outfile{1},me,place{as},'B1:B30') 
    xlswrite(outfile{1},ew,place{as},'C1:C30')
end
