clc
clear

%% 数据处理

load('.\featset.mat') ;

featset_train = featset([featset.index]==0) ;
featset_test = featset([featset.index]==1) ;

dataTrain = {featset_train.feat}' ;
labelTrain = categorical([featset_train.label]') ;
dataTest = {featset_test.feat}' ;
labelTest = categorical([featset_test.label]') ;

%% 定义lstm层，设置参数

rng('default') ;
rng(0) ;

inputsize = 4096 ;     %cnn全连接层特征数
outputsize = 100 ;     %输出层特征维度，与其他参数无必然关系，复杂任务大点，简单任务小些
numClasses = 6 ;       %length(videoclass)
OutputMode = 'last' ;  %多输入一输出任务，最后一个rnn单元输出

layers = [ ... 
    sequenceInputLayer(inputsize)
    lstmLayer(outputsize, 'OutputMode', OutputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

maxEpochs = 80 ; %迭代次数
miniBatchSize = 32 ;

options = trainingOptions('sgdm', ...   %'sgdm' 'rmsprop' ' '
    'ExecutionEnvironment', 'auto', ... %cpu&gpu
    'MaxEpochs', maxEpochs, ...         %迭代次数
    'MiniBatchSize', miniBatchSize, ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule','piecewise',...    
    'LearnRateDropFactor',0.5,...       %每30代学习率*0.5
    'LearnRateDropPeriod',30,...
    'Verbose', 1, ...                   %命令行显示迭代信息
    'Plots', 'training-progress', ...   %可视化
    'Shuffle','once') ;                 %是否数据洗牌

%% 训练

net = trainNetwork(dataTrain, labelTrain, layers, options) ;
 
%% 测试

labelPred = classify(net, dataTest, ...
    'MiniBatchSize', miniBatchSize);

acc = sum(labelPred == labelTest)./numel(labelTest)

save('./lstmNet.mat', 'net') ;
