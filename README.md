# 基于cnn和lstm的动作视频序列识别
-------------------------------
## 依赖项
matlab2017b, matconvnet
## 算法流程
cnn用于提取每帧视频的特征，将每帧提取为4096维向量，选取每个视频的前一百帧，输入lstm进行训练
## 数据集
[Recognition of human actions][1]
## 运行
get_frames,
get_feature,
train_LSTM

[1]:http://www.nada.kth.se/cvap/actions/
