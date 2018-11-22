%This function renders a video for simple frame differencing
%function simpleFrameDiff(folder)    
    folder = '/getout/';
    directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
    files = dir(directory'); %load .jpg pictures to files (struct array)

    vFrameDiff = VideoWriter('getout_simpleFrameDiff.avi'); %Create video writing object
    open(vFrameDiff); %open video object to import data to be rendered

    threshold = 30; %parameter for thresholding images
    
    image1 = strcat('DataSets',folder,files(1).name); %concat file path to previous picture

    for i = 1:length(files)
        image2 = strcat('DataSets',folder,files(i).name); %concat file path to current picture

        new = abs(grayscale(image1) - grayscale(image2)); %get grayscale difference
        
        new = thresholding(new, threshold); %Image Thresholding
        
        figure('visible', 'off'); %generate figure but don't display
        imshow(new); %import differentiated picture to figure

        f = getframe(); %get frame for video
        writeVideo(vFrameDiff, f); %write video
        clf(); %clear current figure
        
        image1 = image2; %replace previous image with current image for next iteration
    end

    close(vFrameDiff); %close video object to finish

%end