function varargout = data_process(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_process_OpeningFcn, ...
                   'gui_OutputFcn',  @data_process_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function data_process_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = data_process_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function zoom_in_Callback(~, ~, ~)
toolsmenufcn ZoomIn

function load_dir_Callback(hObject, ~, handles)
strPath = uigetdir('D:\研二科研\MATLAB GUI学习\GUI\GUI\图片浏览器\待切割图片', '选择需要切割的图片目录');
if ~ischar(strPath)
    return
end
setappdata(hObject, 'strPath', strPath);  %当前图片目录
str_jpg = dir([strPath '\*.jpg']);
str_bmp = dir([strPath '\*.bmp']);
str_gif = dir([strPath '\*.gif']);
str_png = dir([strPath '\*.png']);
str_ppm = dir([strPath '\*.ppm']);
str1 = [str_jpg; str_bmp; str_gif ;str_png ;str_ppm];
strAllPath = struct2cell(str1);
setappdata(hObject, 'strAllPath', strAllPath);  %当前所有图片的信息
if ~isempty(str1)
    n = find(cell2mat(strAllPath(4, :)) == 1);
    if ~isempty(n)
        strAllPath(:, n) = [];
    end
end
if ~isempty(strAllPath)
    index = 1;
    set(hObject, 'UserData', index);  %当前图片的索引值
    set(handles.pic_name, 'string', strAllPath{1, 1})
    M = imread(fullfile(strPath, strAllPath{1, index}));
    [size_m,size_n,k]=size(M);
    set(handles.text9,'string',num2str(size_m));
    set(handles.text10,'string',num2str(size_n));
    axes(handles.axes1);
    imshow(M);
    h = findall(handles.pic_menu, 'type', 'uimenu');
    delete(h);
    clear h;
    for i = 1 : size(strAllPath, 2)
        uimenu(handles.pic_menu, 'label', strAllPath{1,i}, 'position', i,...
            'callback', {@menu_callback, handles});
    end
    set(findobj('Type', 'uimenu', 'Position', index), 'Checked', 'on');
    
    set(findobj(gcf, 'Type', 'uicontrol', 'Enable', 'inactive'), 'Enable', 'on');
    set(findobj(gcf, 'Type', 'uimenu', 'Enable', 'off'), 'Enable', 'on');
end

function menu_callback(obj, ~, handles)
indexPre = get(handles.load_dir, 'userData');
set(findobj('Type', 'uimenu', 'Position', indexPre), 'Checked', 'off');
index = get(obj, 'position');
set(handles.load_dir, 'userData', index);
set(obj, 'Checked', 'on');
strAllPath = getappdata(handles.load_dir, 'strAllPath');
strPath = getappdata(handles.load_dir, 'strPath');
cla;
M = imread(fullfile(strPath, strAllPath{1, index}));
[size_m,size_n,k]=size(M);
    set(handles.text9,'string',num2str(size_m));
    set(handles.text10,'string',num2str(size_n));
axes(handles.axes1);    
imshow(M);

function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
if (~get(handles.zoom_in, 'Value')) && (~get(handles.pic_crop, 'Value'))
    pos=get(handles.axes1,'currentpoint');
    xLim=get(handles.axes1,'xlim');
    yLim=get(handles.axes1,'ylim');
    if (pos(1,1)>=xLim(1)&&pos(1,1)<=xLim(2))&&(pos(1,2)>=yLim(1)&&pos(1,2)<=yLim(2))
        set(gcf,'Pointer','hand')
    else
        set(gcf,'Pointer','arrow')
    end
end

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
if strcmp(get(gcf,'Pointer'),'hand') && strcmp(get(handles.picNext, 'Enable'), 'on')
    if strcmp(get(gcf,'SelectionType'), 'alt')
        pos = get(gcf, 'currentpoint');
        set(handles.pic_menu, 'position',[pos(1,1) pos(1,2)], 'visible', 'on')
    elseif strcmp(get(gcf,'SelectionType'), 'normal')
            
        picNext_Callback(hObject, eventdata, handles);
    end
end

function picPre_Callback(~, ~, handles)
strAllPath = getappdata(handles.load_dir, 'strAllPath');
strPath = getappdata(handles.load_dir, 'strPath');
indexPre = get(handles.load_dir, 'userData');
if indexPre > 1
    index = indexPre - 1;
else
    index = size(strAllPath, 2);
end
set(handles.load_dir, 'userData', index);
set(findobj(gcf, 'Type', 'uimenu', 'Position', indexPre), 'Checked', 'off');
set(findobj(gcf, 'Type', 'uimenu', 'Position', index), 'Checked', 'on');
cla;
M = imread(fullfile(strPath, strAllPath{1, index}));
imshow(M);
set(handles.pic_name, 'string', strAllPath{1, index});

function picNext_Callback(~, ~, handles)
strAllPath = getappdata(handles.load_dir, 'strAllPath');
strPath = getappdata(handles.load_dir, 'strPath');
indexPre = get(handles.load_dir, 'userData');
if indexPre < size(strAllPath, 2)
    index = indexPre + 1;
else
    index = 1;
end
set(handles.load_dir, 'userData', index);
set(findobj(gcf, 'Type', 'uimenu', 'Position', indexPre), 'Checked', 'off');
set(findobj(gcf, 'Type', 'uimenu', 'Position', index), 'Checked', 'on');
cla;
M = imread(fullfile(strPath, strAllPath{1, index}));
[size_m,size_n,k]=size(M);
    set(handles.text9,'string',num2str(size_m));
    set(handles.text10,'string',num2str(size_n));
axes(handles.axes1);
imshow(M);
set(handles.pic_name, 'string', strAllPath{1, index});

function pic_menu_Callback(hObject, eventdata, handles)

function pic_crop_Callback(hObject, ~, handles)
% disp ‘1’;
if get(hObject, 'value')
    hRect = imrect;
    pos = wait(hRect);
    delete(hRect);
    
    strAllPath = getappdata(handles.load_dir, 'strAllPath');
    strPath = getappdata(handles.load_dir, 'strPath');
    index = get(handles.load_dir, 'userData');
    
     M = imread(fullfile(strPath, strAllPath{1, index}));
    newM = imcrop(M, pos);
    [Mm,Nn,k]=size(newM);
    p1=num2str(pos(1));
      p2=num2str(pos(2));
        p3=num2str(Mm);
           p4=num2str(Nn);
    s=[strAllPath{1, index} ' ' p1 ' ' p2 ' ' p3 ' ' p4 ' ' '.jpg'];
    set(handles.text13,'string',num2str(pos(1,1)));
    set(handles.text14,'string',num2str(pos(1,2)));
    set(handles.text15,'string',num2str(Mm));
    set(handles.text19,'string',num2str(Nn));
    axes(handles.axes4);    
    imshow(newM);
    axes(handles.axes1); 
%     [fName, pName, index] = uiputfile({'*.jpg'; '*.bmp';'*.png'}, '图片另存为', datestr(now, 30));
    [fName, pName, index] = uiputfile({'*.jpg'; '*.bmp';'*.png'},'图片另存为',s);
    if index
        strName = [pName fName];
        h = figure('visible', 'off');
%         axes(handles.axes1); 
        imshow(newM);
        if strcmp(fName(end-3 : end), '.jpg')
            print(h, '-djpeg', strName);
        elseif strcmp(fName(end-3 : end), '.bmp')
            print(h, '-dbmp', strName);
        end
        delete(h);
    end
    set(hObject, 'value', 0);
end

function tool_menu_Callback(hObject, eventdata, handles)


function load_dir_menu_Callback(hObject, eventdata, handles)
load_dir_Callback(handles.load_dir, eventdata, handles);

function prePre_menu_Callback(hObject, eventdata, handles)
picPre_Callback(handles.picPre, eventdata, handles);

function picNext_menu_Callback(hObject, eventdata, handles)
picNext_Callback(handles.picNext, eventdata, handles);

function pic_crop_menu_Callback(hObject, eventdata, handles)
val = get(handles.pic_crop, 'Value');
set(handles.pic_crop, 'Value', ~val);
pic_crop_Callback(handles.pic_crop, eventdata, handles);

function zoom_in_menu_Callback(hObject, eventdata, handles)
val = get(handles.zoom_in, 'Value');
set(handles.zoom_in, 'Value', ~val);
zoom_in_Callback(hObject, eventdata, handles);

function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
switch eventdata.Key
    case {'pageup', 'leftarrow', 'uparrow'}
        picPre_Callback(handles.picPre, eventdata, handles);
    case {'pagedown', 'rightarrow', 'downarrow'}
        picNext_Callback(handles.picNext, eventdata, handles);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --------------------------------------------------------------------
function save_Sign_Callback(hObject, eventdata, handles)
% hObject    handle to save_Sign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pic_crop and none of its controls.
function pic_crop_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pic_crop (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
