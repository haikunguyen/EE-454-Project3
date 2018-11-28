%This function generates a video.

function makeVideo(newFolderName, folderName)
    %open folder of new images
    files = dir(strcat(newFolderName, '/', '*.png'));

    %setting up video object to start writing
    video = VideoWriter(strcat(folderName,'.avi')); %create video writing object; saves to <folderName>.avi
    open(video); %open video writing object; generates empty array to place frames of video

    for i = 1:length(files)
        %load image
        I = imread(strcat(newFolderName, '/', files(i).name));

        %generate figure of image
        figure('visible', 'off'); %don't display figure
        imshow(I); %import image to figure

        %generate video frame
        f = getframe(); %get frame for video
        writeVideo(video, f); %write video
    end

    close(video); %close video object to finish
end