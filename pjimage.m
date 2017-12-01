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

% Last Modified by GUIDE v2.5 28-May-2017 17:55:37

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
set(hObject,'toolbar','figure') 
% Update handles structure
guidata(hObject, handles);
setappdata(handles.figure_pjimage,'img_src',0);
% UIWAIT makes pjimage wait for user response (see UIRESUME)
% uiwait(handles.figure_pjimage);


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
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global vanishing_points;
global vanishing_points_index;
global point1_index;
global point2_index;
global point3_index;
global point1;
global point2;
global point3;
global I;
global pathname;
global filename;
global general_vanishing_points;


[filename,pathname]=uigetfile(...
   {'*.bmp;*.jpg;*.png;*.jpeg','ImageFiles(*.bmp,*.jpg,*.png,*.jpeg)';...
    '*.*','ALL Files(*.*)'},...
    'Pick an image');
if isequal(filename,0) || isequal(pathname,0)
    return;
end



fpath=[pathname filename];
img_src=imread(fpath);
setappdata(handles.figure_pjimage,'img_src',img_src);
%imshow(img_src)

figure(1);
%axis([-10,10,0,5]);
I=imread(fpath);
imshow(I);
hold on;
vanishing_points=zeros(3,2);
general_vanishing_points=zeros(3,2);
vanishing_points_index=1;
point1_index=0;
point2_index=0;
point3_index=0;
point1=[];point2=[];point3=[];
set(gcf,'WindowButtonDownFcn',@ButttonDownFcn);


% --------------------------------------------------------------------
function m_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile({'*.bmp','BMP files','*.jpg','JPG files'},'Pick an Image');
if isequal(filename,0) || isequal(pathname,0)
    return;
else
    fpath=fullfile(pathname,filename);
end
img_src=getappdata(handles.figure_pjimage,'img_src');
imwrite(img_src,fpath);
    


% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure_pjimage);


% --------------------------------------------------------------------
function m_image_Callback(hObject, eventdata, handles)
% hObject    handle to m_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_image_2bw_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_2bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_src=getappdata(handles.figure_pjimage,'img_src');
figure(2)
imshow(img_src);
%h=im2bw_args;


function ButttonDownFcn(src,event)
    global vanishing_points;
    global vanishing_points_index;
    global point1_index;
    global point2_index;
    global point3_index;
    global point1;
    global point2;
    global point3;
    global pathname;
    global filename;
    global general_vanishing_points;
    key_value=get(gcf,'Currentcharacter');
    
    if(key_value=='s')%start to 
        
        pt = get(gca,'CurrentPoint');
        point1_index=point1_index+1;
        point1(point1_index,1) = pt(1,1);
        point1(point1_index,2) = pt(1,2);
        figure(1);
        plot(100,10);
        plot(point1(point1_index,1),point1(point1_index,2),'r.','Markersize',20);
        fprintf('x_cordinate=%f,y_cordinate=%f\n',point1(point1_index,1),point1(point1_index,2));
        if(mod(point1_index,2)==0)
            plot([point1(point1_index,1),point1(point1_index-1,1)],[point1(point1_index,2),point1(point1_index-1,2)],'r','Linewidth',2)
        end
    end
    if(key_value=='e')
        pt = get(gca,'CurrentPoint');
        point2_index=point2_index+1;
        point2(point2_index,1) = pt(1,1);
        point2(point2_index,2) = pt(1,2);
        figure(1)
        plot(100,10,'Markersize',20)
        plot(point2(point2_index,1),point2(point2_index,2),'g.','Markersize',20);
        fprintf('x_cordinate=%f,y_cordinate=%f\n',point2(point2_index,1),point2(point2_index,2));
        if(mod(point2_index,2)==0)
            plot([point2(point2_index,1),point2(point2_index-1,1)],[point2(point2_index,2),point2(point2_index-1,2)],'g','Linewidth',2)
        end
    end
%     if(key_value=='d')
%         pt = get(gca,'CurrentPoint');
%         point3_index=point3_index+1;
%         point3(point3_index,1) = pt(1,1);
%         point3(point3_index,2) = pt(1,2);
%         figure(1)
%         plot(point3(point3_index,1),point3(point3_index,2),'b.','Markersize',20);
%         fprintf('x_cordinate=%f,y_cordinate=%f\n',point3(point3_index,1),point3(point3_index,2));
%         if(mod(point3_index,2)==0)
%             plot([point3(point3_index,1),point3(point3_index-1,1)],[point3(point3_index,2),point3(point3_index-1,2)],'b','Linewidth',2)
%         end
%     end
    
    %find the vanishing point and the third vanishing point and the focus
    %length
    if(key_value=='f')
            if(mod(size(point1,1),2)~=0||mod(size(point2,1),2)~=0||mod(size(point3,1),2)~=0)
                display('the input point number is not even,please input again\n');
                return;
            end
            hold off;
            figure(2);
            %axis([-1000 1000 -1000 1000]);
            global I;
            imshow(I);
            hold on;
            coefficient1=zeros(size(point1,1)/2,2);
            b=[-1;-1];
            for i=1:2:size(point1,1)
                temp_data1=point1(i:i+1,:);
                temp_coefficient1=temp_data1\b;
                coefficient1((i+1)/2,:)=temp_coefficient1;
            end
            b1=zeros(size(point1,1)/2,1);
            b1(:,1)=-1;
            intersection1=coefficient1\b1;
            figure(2)
            plot(intersection1(1),intersection1(2),'r.','MarkerSize',30);
            fprintf('coordinate of one vanishing point is x=%f,y=%f\n',intersection1(1),intersection1(2));
            vanishing_points(1,:)=intersection1;
            
            %find the second vanishing point
            coefficient2=zeros(size(point2,1)/2,2);
            b=[-1;-1];
            for i=1:2:size(point2,1)
                temp_data2=point2(i:i+1,:);
                temp_coefficient2=temp_data2\b;
                coefficient2((i+1)/2,:)=temp_coefficient2;
            end
            b2=zeros(size(point2,1)/2,1);
            b2(:,1)=-1;
            intersection2=coefficient2\b2;
            figure(2)
            plot(intersection2(1),intersection2(2),'g.','MarkerSize',30);
            fprintf('coordinate of another vanishing point is x=%f,y=%f\n',intersection2(1),intersection2(2));
            vanishing_points(2,:)=intersection2;
            
            %find the third vanishing point and fcous
            %find fcous length
            cordinate_translation_from_image_to_general=[-size(I,2)/2,size(I,1)/2];
            cordinate_scale_from_image_to_general=[1,-1];
            general_vanishing_points(1:2,:)=repmat(cordinate_scale_from_image_to_general,2,1).*vanishing_points(1:2,:)+repmat(cordinate_translation_from_image_to_general,2,1);
            focal_length=sqrt(-general_vanishing_points(1,1)*general_vanishing_points(2,1)-general_vanishing_points(1,2)*general_vanishing_points(2,2));
            fprintf('the calculated focus length of the camera is %f\n',focal_length);
            fprintf('the standed focus length of the camera is %f\n',size(I,1)/2);
            general_vanishing_points(3,:)=(general_vanishing_points(1:2,:)\[-focal_length^2;-focal_length^2])';
            intersection3=general_vanishing_points(3,:).*[1,-1]+[size(I,2)/2,size(I,1)/2];
            vanishing_points(3,:)=intersection3;
%             coefficient3=zeros(size(point3,1)/2,2);
%             b=[-1;-1];
%             for i=1:2:size(point3,1)
%                 temp_data3=point3(i:i+1,:);
%                 temp_coefficient3=temp_data3\b;
%                 coefficient3((i+1)/2,:)=temp_coefficient3;
%             end
%             b3=zeros(size(point3,1)/2,1);
%             b3(:,1)=-1;
%             intersection3=coefficient3\b3;
            figure(2)
            plot(intersection3(1),intersection3(2),'b.','MarkerSize',40);
            title(num2str(focal_length));
            fprintf('coordinate of the last vanishing point is x=%f,y=%f\n',intersection3(1),intersection3(2));
            
            %global filename;
            %global filepath;
            %save ([pathname,filename,'.mat'],'vanishing_points')
            %save([pathname,filename,'.mat'],'general_vanishing_points')
            %save('test2.mat',vanishing_points)
            [geometry_file_id,geometry_message]=fopen([pathname,'geometry_information.txt'],'w+t');%open the file and write on the first line
            fprintf(geometry_file_id,'%s ',filename);%output the file's name
            %according to the file name,extract the information
            split_index=find(ismember(filename,'_'));
            dot_index=find(ismember(filename,'.'));
            pitch=filename(split_index(1)+1:split_index(2)-1);
            yaw=filename(split_index(3)+1:split_index(4)-1);
            lat=filename(split_index(5)+1:split_index(6)-1);
            lng=filename(split_index(7)+1:dot_index(end)-1);
            fov=0;
            fprintf(geometry_file_id,'%s ',lat);
            fprintf(geometry_file_id,'%s ',lng);
            fprintf(geometry_file_id,'%s ',pitch);
            fprintf(geometry_file_id,'%s ',yaw);
            fprintf(geometry_file_id,'%f ',fov);
            
            fprintf(geometry_file_id,'%f %f ',general_vanishing_points(1,:));%1th vanishing point
            fprintf(geometry_file_id,'%f %f ',general_vanishing_points(2,:));%2th vanishing point 
            fprintf(geometry_file_id,'%f %f ',general_vanishing_points(3,:));%3th vanishing point
         
            
            fprintf('%f %f ',general_vanishing_points(1,:));
            fprintf('%f %f ',general_vanishing_points(2,:));
            fprintf('%f %f ',general_vanishing_points(3,:));
%             
%             figure(4)
%             axis([-size(I,2)/2 size(I,2)/2 -size(I,1)/2 size(I,1)/2]);
%             plot(general_vanishing_points(:,1),general_vanishing_points(:,2)); 
%             
            fprintf(geometry_file_id,'%f ',focal_length);
            fclose(geometry_file_id);
            %plot(0,size(I,1),'k.','MarkerSize',40);
            translate_cordinate=vanishing_points-repmat([size(I,2)/2,size(I,1)/2],3,1);
            temp_norm=max(norm(translate_cordinate(1,:)),norm(translate_cordinate(2,:)));
            max_distance=max(norm(translate_cordinate(3,:)),temp_norm);
            axis([-(max_distance-size(I,2)/2) max_distance+size(I,2)/2 -(max_distance-size(I,2)/2) max_distance+size(I,2)/2]);
            hold off
    end
