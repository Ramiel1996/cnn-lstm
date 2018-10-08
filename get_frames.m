clc ;
clear  ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datadir = '.\move_dataset' ;  %������Ƶ���ݼ�·��
framenum = 100 ;  %���õ�����Ƶ�Ľ�ͼ֡��

%% �Զ���ȡ��ǩ����

videodata = dir(datadir) ;
videoclass = {} ;
for i = 3:length(videodata)
    if videodata(i).isdir&&isempty(strfind(videodata(i).name, '_frames'))
       videoclass{end+1} = videodata(i).name ;
    end
end

%% ��ͼ

video2frames(datadir, framenum, videoclass) ;

disp('get_frames done');