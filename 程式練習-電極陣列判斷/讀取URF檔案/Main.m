%**************************************************************************
%   Name: Main.m v20200110a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20200110a
%   Description: read_EarthImageUrfFile.m的呼叫範例
%**************************************************************************
clear;clc
%==========================================================================
% 取得檔名的UI
%
[filename, pathname] =...
    uigetfile(...
                {...  
                    '*.urf','urf (*.urf)';...%第1個篩選項目
                    '*.*','All Files (*.*)'...%第2個篩選項目
                },...
                'Pick a file',...%UI標題
                'MultiSelect', 'off'...%是否允許多選
            );
%==========================================================================
%==========================================================================
% 檔名轉為細胞矩陣
%--
if (iscell(filename) == 0)
    inputname{1}=filename;
elseif (iscell(filename) == 1)
    inputname=filename;    
end
%--
% 展示第一個檔名
%disp([pathname,inputname{1}])
%==========================================================================
%--
Input_EarthImagerUrfFileName=[pathname,inputname{1}];
EarthImagerUrfFile=read_EarthImagerUrfFile(Input_EarthImagerUrfFileName);
%--