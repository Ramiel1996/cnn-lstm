clc ;
clear  ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datadir = '.\move_dataset' ;  %设置视频数据集路径
framenum = 100 ;  %设置单个视频的截图帧数

%% 自动获取标签名称

videodata = dir(datadir) ;
videoclass = {} ;
for i = 3:length(videodata)
    if videodata(i).isdir&&isempty(strfind(videodata(i).name, '_frames'))
       videoclass{end+1} = videodata(i).name ;
    end
end

%% 截图

video2frames(datadir, framenum, videoclass) ;

disp('get_frames done');