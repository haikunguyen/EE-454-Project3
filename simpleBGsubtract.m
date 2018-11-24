%This script renders a video for simple background subtraction

folder = '/ArenaA/';
directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
files = dir(directory); %load .jpg pictures to files (struct array)

vBGsubtract = VideoWriter('ArenaA_simpleBGsubtract.avi'); %Create video writing object
open(vBGsubtract); %open video object to import data to be rendered

threshold = 30; %parameter for thresholding images

image1 = strcat('DataSets',folder,files(1).name); %concat file path to first picture
image1 = grayscale(image1); %get grayscale of background picture

for i = 1:length(files)
    image2 = strcat('DataSets',folder,files(i).name); %concat file path to current picture
    image2 = grayscale(image2); %get grayscale of current picture

    diff = abs(image1 - image2); %get difference

    %Image Thresholding
    diff = thresholding(diff, threshold); %filter image through threshold

    figure('visible', 'off'); %generate figure but don't display
    imshow(diff); %import differentiated picture to figure

    f = getframe(); %get frame for video
    writeVideo(vBGsubtract, f); %write video
    clf(); %clear current figure
end

close(vBGsubtract); %close video object to finish