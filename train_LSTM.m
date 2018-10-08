clc
clear

%% ���ݴ���

load('.\featset.mat') ;

featset_train = featset([featset.index]==0) ;
featset_test = featset([featset.index]==1) ;

dataTrain = {featset_train.feat}' ;
labelTrain = categorical([featset_train.label]') ;
dataTest = {featset_test.feat}' ;
labelTest = categorical([featset_test.label]') ;

%% ����lstm�㣬���ò���

rng('default') ;
rng(0) ;

inputsize = 4096 ;     %cnnȫ���Ӳ�������
outputsize = 100 ;     %���������ά�ȣ������������ޱ�Ȼ��ϵ�����������㣬������СЩ
numClasses = 6 ;       %length(videoclass)
OutputMode = 'last' ;  %������һ����������һ��rnn��Ԫ���

layers = [ ... 
    sequenceInputLayer(inputsize)
    lstmLayer(outputsize, 'OutputMode', OutputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

maxEpochs = 80 ; %��������
miniBatchSize = 32 ;

options = trainingOptions('sgdm', ...   %'sgdm' 'rmsprop' ' '
    'ExecutionEnvironment', 'auto', ... %cpu&gpu
    'MaxEpochs', maxEpochs, ...         %��������
    'MiniBatchSize', miniBatchSize, ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule','piecewise',...    
    'LearnRateDropFactor',0.5,...       %ÿ30��ѧϰ��*0.5
    'LearnRateDropPeriod',30,...
    'Verbose', 1, ...                   %��������ʾ������Ϣ
    'Plots', 'training-progress', ...   %���ӻ�
    'Shuffle','once') ;                 %�Ƿ�����ϴ��

%% ѵ��

net = trainNetwork(dataTrain, labelTrain, layers, options) ;
 
%% ����

labelPred = classify(net, dataTest, ...
    'MiniBatchSize', miniBatchSize);

acc = sum(labelPred == labelTest)./numel(labelTest)

save('./lstmNet.mat', 'net') ;
