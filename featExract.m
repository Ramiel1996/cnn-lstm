function [featVec] = featExract(imdir, cnn_net, cnn_layer)



im = imread(imdir) ;
im_ = imresize(im, cnn_net.meta.normalization.imageSize(1:2)) ;
% im_ = im_ - cnn_net.meta.normalization.averageImage ;
im_ = gpuArray(im_) ;
im_ = single(im_) ;

res = vl_simplenn(cnn_net, im_) ;
featVec = res(cnn_layer).x ;
featVec = featVec(:) ;


end





















% x为显示的进度，必须在0到1之间h为所建立的waitbar的句柄，updated message为实时显示的信息，此语句经常地用于for循环中，如下所示：
% steps=100;
% hwait=waitbar(0,'请等待>>>>>>>>');
% for k=1:steps
%     if steps-k<=5
%         waitbar(k/steps,hwait,'即将完成');
%         pause(0.05);
%     else
%         str=['正在运行中',num2str(k),'%'];
%         waitbar(k/steps,hwait,str);
%         pause(0.05);
%     end
% end
% close(hwait); % 注意必须添加close函数
% 
% steps=150;
% hwait=waitbar(0,'请等待>>>>>>>>');
% step=steps/100;
% for k=1:steps
%     if steps-k<=5
%         waitbar(k/steps,hwait,'即将完成');
%         pause(0.05);
%     else
%         PerStr=fix(k/step);
%         str=['正在运行中',num2str(PerStr),'%'];
%         waitbar(k/steps,hwait,str);
%         pause(0.05);
%     end
% end
% close(hwait);