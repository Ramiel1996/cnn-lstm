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





















% xΪ��ʾ�Ľ��ȣ�������0��1֮��hΪ��������waitbar�ľ����updated messageΪʵʱ��ʾ����Ϣ������侭��������forѭ���У�������ʾ��
% steps=100;
% hwait=waitbar(0,'��ȴ�>>>>>>>>');
% for k=1:steps
%     if steps-k<=5
%         waitbar(k/steps,hwait,'�������');
%         pause(0.05);
%     else
%         str=['����������',num2str(k),'%'];
%         waitbar(k/steps,hwait,str);
%         pause(0.05);
%     end
% end
% close(hwait); % ע��������close����
% 
% steps=150;
% hwait=waitbar(0,'��ȴ�>>>>>>>>');
% step=steps/100;
% for k=1:steps
%     if steps-k<=5
%         waitbar(k/steps,hwait,'�������');
%         pause(0.05);
%     else
%         PerStr=fix(k/step);
%         str=['����������',num2str(PerStr),'%'];
%         waitbar(k/steps,hwait,str);
%         pause(0.05);
%     end
% end
% close(hwait);