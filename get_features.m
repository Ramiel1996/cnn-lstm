clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datadir = '.\move_dataset' ;
framenum = 100 ;  %单个视频的截图帧数
cnn_net = load('.\imagenet-vgg-verydeep-16.mat') ;
cnn_layer = 34 ; %特征选取
layersize = 4096 ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 自动获取类别

videodata = dir(datadir) ;
videoclass = {} ;
for i = 3:length(videodata)
    if videodata(i).isdir&&isempty(strfind(videodata(i).name, '_frames'))
       videoclass{end+1} = videodata(i).name ;
    end
end

%% 获取特征，标签，索引

featset = ([]) ;
run vl_setupnn.m ;
cnn_net = vl_simplenn_tidy(cnn_net) ;
vl_simplenn_display(cnn_net);
cnn_net = vl_simplenn_move(cnn_net, 'gpu');

%videonum = length(dir([datadir  '\**\*.avi'])) ;
                
for j = 1:length(videoclass)

    framesdir = dir(sprintf('%s/%s_frames', datadir, videoclass{j})) ;
    videonum = length(framesdir)-2 ;
    featset_=struct('feat', zeros(layersize, framenum), ...
                    'label', num2cell(zeros(videonum,1)), ...
                    'index', num2cell(zeros(videonum,1))) ; %开内存
    
    for k = 1:videonum
        tic
        fra = dir(sprintf('%s/%s', framesdir(k+2).folder, framesdir(k+2).name )) ;
        %feat
        for n = 1:framenum
            imdir = sprintf('%s/%s', fra(n+2).folder, fra(n+2).name) ;
            featVec = featExract(imdir, cnn_net, cnn_layer) ;
            featVec = gather(featVec) ;
            featset_(k).feat(:, n) = featVec ;
            
        end
        %index
        if strncmp(framesdir(k+2).name, 'person22', 8)||...
           strncmp(framesdir(k+2).name, 'person02', 8)||...
           strncmp(framesdir(k+2).name, 'person03', 8)||...
           strncmp(framesdir(k+2).name, 'person05', 8)||...
           strncmp(framesdir(k+2).name, 'person10', 8)
%            strncmp(framesdir(k+2).name, 'person06', 8)||...
%            strncmp(framesdir(k+2).name, 'person07', 8)||...
%            strncmp(framesdir(k+2).name, 'person08', 8)||...
%            strncmp(framesdir(k+2).name, 'person09', 8)||...
           
       
           featset_(k).index= 1 ; %index值为1为test，0为train
        end
        %label
        featset_(k).label= j ;
        disp(['class', num2str(j), 'group', num2str(k), 'spend', num2str(toc)]) ;
    end
    featset = [featset; featset_] ;
end

save('.\featset.mat', 'featset') ;
disp('get_features done')