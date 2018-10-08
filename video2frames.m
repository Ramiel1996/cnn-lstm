function  video2frames(datadir, framenum, videoclass)
%%%%%%%%%%%%%%%%%%%%获取视频帧%%%%%%%%%%%%%%%%%%%%%%

% 当输入路径为文件夹时，循环读取子文件夹下视频，截图，并新建文件夹保存
% 当输入路径为视频时，截图，并新建文件夹保存

if (nargin == 3)

    h = waitbar(0,'请等待...');
    for i = 1:length(videoclass)
        mkdir(sprintf('%s/%s_frames', datadir, videoclass{i})) ;
        video = dir(sprintf('%s/%s/%s', datadir, videoclass{i}, '*.avi')) ;
        for n = 1:length(video)
            mkdir(sprintf('%s/%s_frames/%s', datadir, videoclass{i}, video(n).name(1:end-4))) ;
            frames = VideoReader(sprintf('%s/%s', video(n).folder, video(n).name)) ;
            for m = 1:framenum    %:frames.Duration*frames.FrameRate
                frame = read(frames, m) ;
                imwrite(frame, sprintf('%s/%s_frames/%s/%s_%i.%s', ... 
                        datadir, videoclass{i}, video(n).name(1:end-4), video(n).name(1:end-4), m, 'png'), ...
                        'png') ;  %截图格式
                
            end 
        waitbar(n / length(video), h, ['正在处理第', num2str(i), '类视频']) ;
        end    
    end 
    close(h) ;




elseif (nargin == 2)
    video = dir(datadir) ;
    mkdir(sprintf('./%s_frames', video.name(1: end-4))) ;
    frames = VideoReader(sprintf('%s', datadir)) ;
    for m = 1:framenum    %:frames.Duration*frames.FrameRate
        frame = read(frames, m) ;
        imwrite(frame, sprintf('%s_frames/%s_%i.%s', ... 
        datadir(1: end-4), video.name, m, 'png'), ...
        'png') ;
    end
end

end

