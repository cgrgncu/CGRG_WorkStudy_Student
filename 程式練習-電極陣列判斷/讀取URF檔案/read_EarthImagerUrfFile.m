%**************************************************************************
%   Name: read_EarthImagerUrfFile.m v20200117a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20200117a
%   Description: 讀取EarthImager2D逆推輸入的「*.urf」檔案文字內容至Matlab結構體中。
%                結構體細節請見程式碼。
%**************************************************************************
function EarthImagerUrfFile=read_EarthImagerUrfFile(Input_EarthImagerUrfFileName)
    %--------------------------------------------------------------------------
    % 使用提醒
    if ~exist('Input_EarthImagerUrfFileName','var')
        disp('Usage:')
        disp('result=read_EarthImagerUrfFile(''xxxx.urf'')')        
        return
    end
    %--------------------------------------------------------------------------
    EarthImagerUrfFile.UrfFileName=Input_EarthImagerUrfFileName;
    EarthImagerUrfFile.Error.String=[];
    %==========================================================================
    % 將檔案內容全部載入到記憶體中 開始
    %disp(['讀取檔案: ',EarthImagerUrfFile.UrfFileName])
    %--------------------------------------------------------------------------
    % 開啟檔案
    f1=fopen(EarthImagerUrfFile.UrfFileName,'rt');
    if (f1<0)
        %disp('開啟檔案失敗!return!')
        EarthImagerUrfFile.Error.String='開啟檔案失敗!return!';
        return
    end
    %--
    % 用fread全部載入字串來加快載入檔案速度，轉置陣列使資料成為一橫列，即陣列大小<1xN>
    temp_char_data=fread(f1,'*char')';
    %--------------------------------------------------------------------------
    % 關閉檔案
    fclose(f1);
    %--------------------------------------------------------------------------
    %disp(['關閉檔案: ',EarthImagerUrfFile.UrfFileName])
    % 將檔案內容全部載入到記憶體中 結束
    %==========================================================================
    
    %==========================================================================
    % 解析所需資料 開始
    %disp('解析所需資料 開始... ')   
    %--------------------------------------------------------------------------
    % 參數#1，查找關鍵字「Tx」
    % 發射訊號端電極的索引
    temp_key_str=['Tx',char(10)];
    % 找開始索引們
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % 檢查
    if (isempty(temp_start_index))    
        %disp('警告!沒有找到「Tx」!略過此參數!')
        EarthImagerUrfFile.Tx=[];
    else
        %disp('找到「Tx」!')
        %--
        % 找下個關鍵字「Rx」
        temp_end_index=strfind(temp_char_data,['Rx',char(10)]);
        % 取出字串
        EarthImagerUrfFile.Tx.String=temp_char_data(temp_start_index(1)+3:temp_end_index(1)-2);
        %--
        % 分析        
        temp_char_data2=EarthImagerUrfFile.Tx.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Tx.DataHeader 是指「Tx」後方的資料陣列標題
        EarthImagerUrfFile.Tx.DataHeader={'Tx_index'};
        % EarthImagerUrfFile.Tx.Data 是指「Tx」後方的資料陣列內容
        EarthImagerUrfFile.Tx.Data=reshape(sscanf(temp_char_data2, '%f'),1,[])';
    end
    %--------------------------------------------------------------------------
    % 參數#2，查找關鍵字「Rx」
    % 量測端電極的索引
    temp_key_str=['Rx',char(10)];
    % 找開始索引們
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % 檢查
    if (isempty(temp_start_index))    
        %disp('警告!沒有找到「Rx」!略過此參數!')
        EarthImagerUrfFile.Rx=[];
    else
        %disp('找到「Rx」!')
        %--
        % 找下個關鍵字「RxP2」
        temp_end_index=strfind(temp_char_data,['RxP2',char(10)]);
        % 取出字串
        EarthImagerUrfFile.Rx.String=temp_char_data(temp_start_index(1)+3:temp_end_index(1)-2);
        %--
        % 分析        
        temp_char_data2=EarthImagerUrfFile.Rx.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Rx.DataHeader 是指「Rx」後方的資料陣列標題
        EarthImagerUrfFile.Rx.DataHeader={'Rx_index'};
        % EarthImagerUrfFile.Rx.Data 是指「Rx」後方的資料陣列內容
        EarthImagerUrfFile.Rx.Data=reshape(sscanf(temp_char_data2, '%f'),1,[])';
    end
    %--------------------------------------------------------------------------
    % 參數#3，查找關鍵字「RxP2」
    % 接收端共地電極位置
    temp_key_str=['RxP2',char(10)];
    % 找開始索引們
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % 檢查
    if (isempty(temp_start_index))    
        %disp('警告!沒有找到「RxP2」!略過此參數!')
        EarthImagerUrfFile.RxP2=[];
    else
        %disp('找到「RxP2」!')
        %--
        % 找下個關鍵字「:Geometry」
        temp_end_index=strfind(temp_char_data,[':Geometry',char(10)]);
        % 取出字串
        EarthImagerUrfFile.RxP2.String=temp_char_data(temp_start_index(1)+5:temp_end_index(1)-3);
        %--
        % 分析
        temp_char_data2=EarthImagerUrfFile.RxP2.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.RxP2.DataHeader 是指「RxP2」後方的資料陣列標題
        EarthImagerUrfFile.RxP2.DataHeader={'RxP2_index'};
        % EarthImagerUrfFile.RxP2.Data 是指「RxP2」後方的資料陣列內容
        EarthImagerUrfFile.RxP2.Data=reshape(sscanf(temp_char_data2, '%f'),1,[])';
    end
    %--------------------------------------------------------------------------
    % 參數#4，查找關鍵字「:Geometry」
    % 接收端共地電極位置
    temp_key_str=[':Geometry',char(10)];
    % 找開始索引們
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % 檢查
    if (isempty(temp_start_index))    
        %disp('警告!沒有找到「:Geometry」!略過此參數!')
        EarthImagerUrfFile.Geometry=[];
    else
        %disp('找到「:Geometry」!')
        %--
        % 找下個關鍵字「:Measurements」
        temp_end_index=strfind(temp_char_data,[':Measurements',char(10)]);
        % 取出字串
        EarthImagerUrfFile.Geometry.String=temp_char_data(temp_start_index(1)+10:temp_end_index(1)-3);
        %--
        % 分析
        temp_char_data2=EarthImagerUrfFile.Geometry.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Geometry.DataHeader 是指「Geometry」後方的資料陣列標題
        EarthImagerUrfFile.Geometry.DataHeader={'Electrode_index','X[m](Potision, X axis: Positive Right-hand-side)','Y[m](Potision, Y axis: unknown)','Z[m](Potision, Z axis: unknown)'};
        % EarthImagerUrfFile.Geometry.Data 是指「Geometry」後方的資料陣列內容
        EarthImagerUrfFile.Geometry.Data=reshape(sscanf(temp_char_data2, '%f'),4,[])';
    end
    %--------------------------------------------------------------------------
    % 參數#5，查找關鍵字「:Measurements」
    % 接收端共地電極位置
    temp_key_str=[':Measurements',char(10)];
    % 找開始索引們
    temp_start_index=strfind(temp_char_data,temp_key_str);
    % 檢查
    if (isempty(temp_start_index))    
        %disp('警告!沒有找到「:Measurements」!略過此參數!')
        EarthImagerUrfFile.Measurements=[];
    else
        %disp('找到「:Measurements」!')
        %--
        % 取出字串
        EarthImagerUrfFile.Measurements.String=temp_char_data(temp_start_index(1)+14:end-1);
        %--
        % 分析
        temp_char_data2=EarthImagerUrfFile.Measurements.String;
        temp_char_data2=strrep(temp_char_data2, ',', ' ');
        % EarthImagerUrfFile.Measurements.DataHeader 是指「Measurements」後方的資料陣列標題
        % 格式解釋請參考Instruction Manual for EarthImager 2D Version 2.4.0 Resistivity and IP Inversion Software」的「Page 23 of 139」
        EarthImagerUrfFile.Measurements.DataHeader={'A_index','B_index','M_index','N_index','V/I[ohm]','I[mA]','Error[%]'};
        % EarthImagerUrfFile.Measurements.Data 是指「Measurements」後方的資料陣列內容
        EarthImagerUrfFile.Measurements.Data=reshape(sscanf(temp_char_data2, '%f'),7,[])';
    end
    %--------------------------------------------------------------------------
    %disp('解析所需資料 結束... ')
    % 解析所需資料 結束
    %==========================================================================
end
