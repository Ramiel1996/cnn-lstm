clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%未完成
filename = '.\move_dataset\handwaving\person02_handwaving_d1_uncomp.avi' ;
framenum = 100 ;
datadir = filename ;

videoFReader = vision.VideoFileReader(filename);
videoPlayer = vision.VideoPlayer;
while ~isDone(videoFReader)
   frame = step(videoFReader);
   step(videoPlayer,frame);
end

video2frames(datadir) ;



cnn_net = load('.\imagenet-vgg-verydeep-16.mat') ;
cnn_layer = 34 ; %特征选取



for n = 1:framenum
    imdir = sprintf('%s/%s', fra(n+2).folder, fra(n+2).name) ;
    featVec = featExract(imdir, cnn_net, cnn_layer) ;
    featVec = gather(featVec) ;
    feat(:, n) = featVec ;
    
    
    
    
    
end


load('./lstmNet.mat') ;
labelPred = classify(net, dataTest) ;