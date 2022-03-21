%**************************************************************************
%   Name: Main.m v20200110a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20200110a
%   Description: read_EarthImageUrfFile.m���I�s�d��
%**************************************************************************
clear;clc
%==========================================================================
% ���o�ɦW��UI
%
[filename, pathname] =...
    uigetfile(...
                {...  
                    '*.urf','urf (*.urf)';...%��1�ӿz�ﶵ��
                    '*.*','All Files (*.*)'...%��2�ӿz�ﶵ��
                },...
                'Pick a file',...%UI���D
                'MultiSelect', 'off'...%�O�_���\�h��
            );
%==========================================================================
%==========================================================================
% �ɦW�ର�ӭM�x�}
%--
if (iscell(filename) == 0)
    inputname{1}=filename;
elseif (iscell(filename) == 1)
    inputname=filename;    
end
%--
% �i�ܲĤ@���ɦW
%disp([pathname,inputname{1}])
%==========================================================================
%--
Input_EarthImagerUrfFileName=[pathname,inputname{1}];
EarthImagerUrfFile=read_EarthImagerUrfFile(Input_EarthImagerUrfFileName);
%--