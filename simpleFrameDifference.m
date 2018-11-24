%This script renders a video for simple frame differencing
 
folder = '/ArenaA/';
directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
files = dir(directory); %load .jpg pictures to files (struct array)

vFrameDiff = VideoWriter('ArenaA_simpleFrameDiff.avi'); %Create video writing object
open(vFrameDiff); %open video object to import data to be rendered

threshold = 30; %parameter for thresholding images

image1 = strcat('DataSets',folder,files(1).name); %concat file path to first picture
image1 = grayscale(image1); %get grayscale of first picture

for i = 1:length(files)
    image2 = strcat('DataSets',folder,files(i).name); %concat file path to current picture
    image2 = grayscale(image2); %get grayscale of current picture

    diff = abs(image1 - image2); %get grayscale difference

    diff = thresholding(diff, threshold); %Image Thresholding

    figure('visible', 'off'); %generate figure but don't display
    imshow(diff); %import thresholded picture to figure

    f = getframe(); %get frame for video
    writeVideo(vFrameDiff, f); %write video
    clf(); %clear current figure

    image1 = image2; %replace previous image with current image for next iteration
end

close(vFrameDiff); %close video object to finish