
function varargout = pjimage(varargin)
% PJIMAGE MATLAB code for pjimage.fig
%      PJIMAGE, by itself, creates a new PJIMAGE or raises the existing
%      singleton*.
%
%      H = PJIMAGE returns the handle to a new PJIMAGE or the handle to
%      the existing singleton*.
%
%      PJIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PJIMAGE.M with the given input arguments.
%
%      PJIMAGE('Property','Value',...) creates a new PJIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pjimage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pjimage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pjimage

% Last Modified by GUIDE v2.5 17-Mar-2020 13:02:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pjimage_OpeningFcn, ...
                   'gui_OutputFcn',  @pjimage_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before pjimage is made visible.
function pjimage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pjimage (see VARARGIN)

% Choose default command line output for pjimage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pjimage wait for user response (see UIRESUME)
% uiwait(handles.figure_pjimage);
setappdata(handles.figure_pjimage,'img_src',0);
setappdata(handles.figure_pjimage,'model',0);
setappdata(handles.figure_pjimage,'predict_label',0);


% --- Outputs from this function are returned to the command line.
function varargout = pjimage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure_pjimage);


% --- Executes on button press in rec_button.
function rec_button_Callback(hObject, eventdata, handles)
% hObject    handle to rec_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
predict_label = getappdata(handles.figure_pjimage,'predict_label');
set(handles.result_screen,'String',predict_label);


function result_screen_Callback(hObject, eventdata, handles)
% hObject    handle to result_screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of result_screen as text
%        str2double(get(hObject,'String')) returns contents of result_screen as a double


% --- Executes during object creation, after setting all properties.
function result_screen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result_screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in begin_train.
function begin_train_Callback(hObject, eventdata, handles)
% hObject    handle to begin_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
for i=1:700
    str  = strcat('D:\software\MATLAB2020a\bin\QQQ\train1\',num2str(i));
    name = strcat(str,'.bmp');
    name = char(name);
    current_img = imread(name);   %将当前图片赋值给一个变量
    current_img = imbinarize(current_img,5/255);
    current_img = reshape(current_img,1,[]); %将矩阵变形
    current_img = double(current_img);
    train_image(i,:) = current_img;
end
load    train-lablee.txt  
time0 = toc;
str = sprintf('ReadImageTime is %f s',time0);
h = msgbox(str);
waitfor(h);
tic;
model = svmtrain(train_lablee, train_image);
time1 = toc;
setappdata(handles.figure_pjimage,'model',model);
%toc;
%save('shouxie_model','model');
%path = input('Training has done.Please input the path of the picture：','s');
str = sprintf('Training has done!\nTraingtime is %f s',time1);
h = msgbox(str);
waitfor(h);


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.bmp','Pick an image');
if isequal(filename,0) || isequal(pathname,0)
    return;
end
axes(handles.axes_src);
fpath = [pathname filename];
img_src = imread(fpath);
imshow(img_src);
current_img=img_src;
current_img = imbinarize(current_img,5/255);
current_img = reshape(current_img,1,[]); %将矩阵变形
test_img = double(current_img);
model = getappdata(handles.figure_pjimage,'model');
[predict_label, accuracy, dec_values] =svmpredict([1], test_img, model);
predict_label
setappdata(handles.figure_pjimage,'predict_label',predict_label);


% --- Executes on button press in three_test.
function three_test_Callback(hObject, eventdata, handles)
% hObject    handle to three_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
model = getappdata(handles.figure_pjimage,'model');
tic;
for i=1:300
    str  = strcat('D:\software\MATLAB2020a\bin\QQQ\test1\',num2str(i));
    name = strcat(str,'.bmp');
    name = char(name);
    current_img = imread(name);    %将当前图片赋值给一个变量
    current_img = imbinarize(current_img,5/255);
    current_img = reshape(current_img,1,[]); %将矩阵变形
    current_img = double(current_img);
    test_image(i,:) = current_img;
end
load    test-lablee.txt  
[predict_label, accuracy, dec_values] =svmpredict(test_lablee, test_image, model);
time2 = toc;
accuracy(1)
str = sprintf('Testing has done!\nTestingTime is %f s.\nAccuracy is %f %',time2,accuracy(1));
h = msgbox(str);
waitfor(h);
