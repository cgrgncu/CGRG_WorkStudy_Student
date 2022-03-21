%**************************************************************************
%   Name: read_EarthImagerUrfFile.m v20200117a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20200117a
%   Description: Ū��EarthImager2D�f����J���u*.urf�v�ɮפ�r���e��Matlab���c�餤�C
%                ���c��Ӹ`�Ш��{���X�C
%**************************************************************************
function EarthImagerUrfFile=read_EarthImagerUrfFile(Input_EarthImagerUrfFileName)
    %--------------------------------------------------------------------------
    % �ϥδ���
    if ~exist('Input_EarthImagerUrfFileName','var')
        disp('Usage:')
        disp('result=read_EarthImagerUrfFile(''xxxx.urf'')')        
        return
    end
    %--------------------------------------------------------------------------
    EarthImagerUrfFile.UrfFileName=Input_EarthImagerUrfFileName;
    EarthImagerUrfFile.Error.String=[];
    %==========================================================================
    % �N�ɮפ��e�������J��O���餤 �}�l
    %disp(['Ū���ɮ�: ',EarthImagerUrfFile.UrfFileName])
    %--------------------------------------------------------------------------
    % �}���ɮ�
    f1=fopen(EarthImagerUrfFile.UrfFileName,'rt');
    if (f1<0)
        %disp('�}���ɮץ���!return!')
        EarthImagerUrfFile.Error.String='�}���ɮץ���!return!';
        return
    end
    %--
    % ��fread�������J�r��ӥ[�ָ��J�ɮ׳t�סA��m�}�C�ϸ�Ʀ����@��C�A�Y�}�C�j�p<1xN>
    temp_char_data=fread(f1,'*char')';
    %--------------------------------------------------------------------------
    % �����ɮ�
    fclose(f1);
    %--------------------------------------------------------------------------
    %disp(['�����ɮ�: ',EarthImagerUrfFile.UrfFileName])
    % �N�ɮפ��e�������J��O���餤 ����
    %==========================================================================
    
    %==========================================================================
    % �ѪR�һݸ�� �}�l
    %disp('�ѪR�һݸ�� �}�l... ')   
    %--------------------------------------------------------------------------
    % �Ѽ�#1�A�d������r�uTx�v
    % �o�g�T���ݹq��������
    temp_key_str=['Tx',char(10)];
    % ��}�l���ޭ�
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % �ˬd
    if (isempty(temp_start_index))    
        %disp('ĵ�i!�S�����uTx�v!���L���Ѽ�!')
        EarthImagerUrfFile.Tx=[];
    else
        %disp('���uTx�v!')
        %--
        % ��U������r�uRx�v
        temp_end_index=strfind(temp_char_data,['Rx',char(10)]);
        % ���X�r��
        EarthImagerUrfFile.Tx.String=temp_char_data(temp_start_index(1)+3:temp_end_index(1)-2);
        %--
        % ���R        
        temp_char_data2=EarthImagerUrfFile.Tx.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Tx.DataHeader �O���uTx�v��誺��ư}�C���D
        EarthImagerUrfFile.Tx.DataHeader={'Tx_index'};
        % EarthImagerUrfFile.Tx.Data �O���uTx�v��誺��ư}�C���e
        EarthImagerUrfFile.Tx.Data=reshape(sscanf(temp_char_data2, '%f'),1,[])';
    end
    %--------------------------------------------------------------------------
    % �Ѽ�#2�A�d������r�uRx�v
    % �q���ݹq��������
    temp_key_str=['Rx',char(10)];
    % ��}�l���ޭ�
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % �ˬd
    if (isempty(temp_start_index))    
        %disp('ĵ�i!�S�����uRx�v!���L���Ѽ�!')
        EarthImagerUrfFile.Rx=[];
    else
        %disp('���uRx�v!')
        %--
        % ��U������r�uRxP2�v
        temp_end_index=strfind(temp_char_data,['RxP2',char(10)]);
        % ���X�r��
        EarthImagerUrfFile.Rx.String=temp_char_data(temp_start_index(1)+3:temp_end_index(1)-2);
        %--
        % ���R        
        temp_char_data2=EarthImagerUrfFile.Rx.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Rx.DataHeader �O���uRx�v��誺��ư}�C���D
        EarthImagerUrfFile.Rx.DataHeader={'Rx_index'};
        % EarthImagerUrfFile.Rx.Data �O���uRx�v��誺��ư}�C���e
        EarthImagerUrfFile.Rx.Data=reshape(sscanf(temp_char_data2, '%f'),1,[])';
    end
    %--------------------------------------------------------------------------
    % �Ѽ�#3�A�d������r�uRxP2�v
    % �����ݦ@�a�q����m
    temp_key_str=['RxP2',char(10)];
    % ��}�l���ޭ�
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % �ˬd
    if (isempty(temp_start_index))    
        %disp('ĵ�i!�S�����uRxP2�v!���L���Ѽ�!')
        EarthImagerUrfFile.RxP2=[];
    else
        %disp('���uRxP2�v!')
        %--
        % ��U������r�u:Geometry�v
        temp_end_index=strfind(temp_char_data,[':Geometry',char(10)]);
        % ���X�r��
        EarthImagerUrfFile.RxP2.String=temp_char_data(temp_start_index(1)+5:temp_end_index(1)-3);
        %--
        % ���R
        temp_char_data2=EarthImagerUrfFile.RxP2.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.RxP2.DataHeader �O���uRxP2�v��誺��ư}�C���D
        EarthImagerUrfFile.RxP2.DataHeader={'RxP2_index'};
        % EarthImagerUrfFile.RxP2.Data �O���uRxP2�v��誺��ư}�C���e
        EarthImagerUrfFile.RxP2.Data=reshape(sscanf(temp_char_data2, '%f'),1,[])';
    end
    %--------------------------------------------------------------------------
    % �Ѽ�#4�A�d������r�u:Geometry�v
    % �����ݦ@�a�q����m
    temp_key_str=[':Geometry',char(10)];
    % ��}�l���ޭ�
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % �ˬd
    if (isempty(temp_start_index))    
        %disp('ĵ�i!�S�����u:Geometry�v!���L���Ѽ�!')
        EarthImagerUrfFile.Geometry=[];
    else
        %disp('���u:Geometry�v!')
        %--
        % ��U������r�u:Measurements�v
        temp_end_index=strfind(temp_char_data,[':Measurements',char(10)]);
        % ���X�r��
        EarthImagerUrfFile.Geometry.String=temp_char_data(temp_start_index(1)+10:temp_end_index(1)-3);
        %--
        % ���R
        temp_char_data2=EarthImagerUrfFile.Geometry.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Geometry.DataHeader �O���uGeometry�v��誺��ư}�C���D
        EarthImagerUrfFile.Geometry.DataHeader={'Electrode_index','X[m](Potision, X axis: Positive Right-hand-side)','Y[m](Potision, Y axis: unknown)','Z[m](Potision, Z axis: unknown)'};
        % EarthImagerUrfFile.Geometry.Data �O���uGeometry�v��誺��ư}�C���e
        EarthImagerUrfFile.Geometry.Data=reshape(sscanf(temp_char_data2, '%f'),4,[])';
    end
    %--------------------------------------------------------------------------
    % �Ѽ�#5�A�d������r�u:Measurements�v
    % �����ݦ@�a�q����m
    temp_key_str=[':Measurements',char(10)];
    % ��}�l���ޭ�
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % �ˬd
    if (isempty(temp_start_index))    
        %disp('ĵ�i!�S�����u:Measurements�v!���L���Ѽ�!')
        EarthImagerUrfFile.Measurements=[];
    else
        %disp('���u:Measurements�v!')
        %--
        % ���X�r��
        EarthImagerUrfFile.Measurements.String=temp_char_data(temp_start_index(1)+14:end-1);
        %--
        % ���R
        temp_char_data2=EarthImagerUrfFile.Measurements.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Measurements.DataHeader �O���uMeasurements�v��誺��ư}�C���D
        % �榡�����аѦ�Instruction Manual for EarthImager 2D Version 2.4.0 Resistivity and IP Inversion Software�v���uPage 23 of 139�v
        EarthImagerUrfFile.Measurements.DataHeader={'A_index','B_index','M_index','N_index','V/I[ohm]','I[mA]','Error[%]'};
        % EarthImagerUrfFile.Measurements.Data �O���uMeasurements�v��誺��ư}�C���e
        EarthImagerUrfFile.Measurements.Data=reshape(sscanf(temp_char_data2, '%f'),7,[])';
    end
    %--------------------------------------------------------------------------
    %disp('�ѪR�һݸ�� ����... ')
    % �ѪR�һݸ�� ����
    %==========================================================================
end
