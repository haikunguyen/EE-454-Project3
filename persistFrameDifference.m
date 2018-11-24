%This script renders a video for persistent frame differencing

folder = '/ArenaA/';
directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
files = dir(directory); %load .jpg pictures to files (struct array)

vPstFrameDiff = VideoWriter('ArenaA_persistFrameDifferencing.avi'); %Create video writing object
open(vPstFrameDiff); %open video object to import data to be rendered

image1 = strcat('DataSets',folder,files(1).name); %concat file path to first picture (t=0)
image1 = grayscale(image1); %get grayscale of image0

threshold = 30; %parameter for thresholding images

imageH = 0; %H(t) at t=0

gamma = 40; %parameter for persistent frame differencing (30)
            %if gamma increases, the trail decays faster

for i = 1:length(files)
    image2 = strcat('DataSets',folder,files(i).name); %concat file path for current picture
    image2 = grayscale(image2); %get grayscale of current picture

    diff = abs(image1 - image2); %get absolute difference between pictures

    diff = thresholding(diff, threshold); %image thresholding

    tmp = max(imageH - gamma, 0); %temporary picture
    imageH = max(255.*diff, tmp); %

    figure('visible', 'off'); %generate figure but don't display
    imshow(imageH); %import thresholded picture to figure

    f = getframe(); %get frame for video
    writeVideo(vPstFrameDiff, f); %write video
    clf(); %clear current figure

    image1 = image2; %replace previous image with current image for next iteration
end

close(vPstFrameDiff); %close video object to finish