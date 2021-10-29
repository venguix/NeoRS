function varargout = neors(varargin)
% NEORS MATLAB code for neors.fig
%      NEORS, by itself, creates a new NEORS or raises the existing
%      singleton*.
%
%      H = NEORS returns the handle to a new NEORS or the handle to
%      the existing singleton*.
%
%      NEORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEORS.M with the given input arguments.
%
%      NEORS('Property','Value',...) creates a new NEORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before neors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to neors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help neors

% Last Modified by GUIDE v2.5 28-Oct-2021 19:26:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @neors_OpeningFcn, ...
                   'gui_OutputFcn',  @neors_OutputFcn, ...
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


% --- Executes just before neors is made visible.
function neors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to neors (see VARARGIN)

% Choose default command line output for neors
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes neors wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = neors_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

% INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Path where NeoRS folder is located
[atlas1mm,atlas3mm, ROI ] = setup_neors();

%workingDir=('/Users/vicenteenguix/Desktop/data_test/');
workingDir=get(hObject,'UserData');

options.TR=0.8;%Repetition time of the RS sequence in seconds
options.motion=24;
options.slicetimingcorrection=1;
options.slice_order=5; %1: bottom up, 2: top down, 3: interleaved+bottom up, 4: interleaved+top down, 5:automatically read json file
options.sct=1;
options.resliceRS=0;
options.radius=35;
options.fmap = 1;
options.best_volumes = 0;
FD_max=0.25;
mFD_all=[];
FWHM=6; %for functional gaussian smoothing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd (workingDir)
[data ] = read_data( );


%options.n_core=1;
%parpool(options.n_core);
% RUN 
for i=1:length(data)
   
    subject=data(i).name;
    RS=dir([subject '/func/*bold.nii*']);
    RS(strncmp({RS.name}, '.', 1)) = [];
    nRS=length(RS);

    T2=dir([subject '/anat/*T2w.nii*']);
    T2(strncmp({T2.name}, '.', 1)) = [];
    T2=T2.name(1:end-4);

    % MANTIS preparation
    gunzip_T2(subject)

    % Data reorientation to standard
    reorient(subject,options,RS,nRS,T2)
    % Image Registration - Anatomical to Atlas
    [alignedT2] = anat2std( subject,atlas1mm,atlas3mm);
    % T2 skull stripping
    [scT2] = skull_stripping( subject )
    % Mantis segmentation
    try
        segmentation_mantis2(workingDir,subject) %Mantis segmentation (error in mac but still ok)
    end

    % align masks and binarize
    masks_alignment( subject )

    for n=1:nRS
        %Slice Timing Correction
        [slcRS]=slice_timing2(subject, options, RS,n );
    end

    for n=1:nRS
        %Cross realignment
        [FD,output,ts,rms,position,mFD_all] = cross_realign2( subject,workingDir,options,RS,n, FD_max, mFD_all);%  Frame displacement
    end

    % REMOVE RUNS WITH mean FD > 0.25 mm
    rowsToDelete = mFD_all > 0.25
    RS(rowsToDelete) = []
    nRS=length(RS);

    if nRS > 0

        % UNWARPING
        % -inindex: 1 for AP, 2 for PA
        fmap2(subject,RS,nRS,options) %remember to put the "datain.txt" if there is no json file
        % BOLD to template
        epi2std(subject,nRS,options)

        %Best volumes selection
        if options.best_volumes == 1
            [minmoysection,indice,section]=best_volumes_selection(FD,subject,nRS)
        else
            display('Skipping best volumes selection')
        end

        % DENOISING
        for n=1:nRS
            %Create brain mask
            [ bold_mask ] = mask_functional( subject,n );
            % Whole brain mode value of 1000 - Normalization
            %[BOLD1000] = intensity_normalization( subject,c,motion_censored_bold );
            % Motion censoring
            [motion_censored_bold]=motion_censoring(subject,n);
            %confound regression
            confounds_regression( subject, workingDir,n,options,motion_censored_bold)
            % Spatial smoothing
            smoothing(subject,n,FWHM);
            % Mask final bold
            [final_bold] = mask_final( subject,n );
        end


        % MERGE ALL RUNS in a single file
        merge_bold_runs(subject,nRS)

        % Seed Based Correlation
        SBC(subject,ROI);

        %Correlation matrix
        corr_matrix( subject )

        % MERGE SEEDS
        merge_seeds( subject )
 
    else
        display('Subject data is not enough to be processed')
    end

end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
workingDir = uigetdir()
workingDir = [workingDir '/'];
set(handles.pushbutton1,'UserData',workingDir);
guidata(hObject,handles);

% --- Executes on key press with focus on pushbutton2 and none of its controls.
function pushbutton2_KeyPressFcn(hObject, eventdata, handles)



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
