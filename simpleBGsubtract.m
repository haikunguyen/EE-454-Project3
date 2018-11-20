%This function renders a video for simple background subtraction
function simpleBGsubtract(folder)

    directory = strcat('DataSets/',folder,'/*.jpg'); %concat strings to get file path
    files = dir(directory'); %load .jpg pictures to files (struct array)

    vBGsubtract = VideoWriter('ArenaA_simpleBGsubtract.avi'); %Create video writing object
    open(vBGsubtract); %open video object to import data to be rendered

    for i = 2:length(files)
        image1 = strcat('DataSets',folder,files(i-1).name); %concat file path to previous picture
        image2 = strcat('DataSets',folder,files(i).name); %concat file path to current picture

        new = (grayscale(image2) - grayscale(image1)).^2; %get grayscale difference

        figure('visible', 'off'); %generate figure but don't display
        imshow(new); %import differentiated picture to figure

        f = getframe(); %get frame for video
        writeVideo(vBGsubtract, f); %write video
        clf(); %clear current figure
    end

    close(vBGsubtract); %close video object to finish

end