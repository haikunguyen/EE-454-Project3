%This function renders a video for adaptive background subtraction
%function adaptiveBGsubtract(folder)
    folder = '/ArenaA/';
    directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
    files = dir(directory'); %load .jpg pictures to files (struct array)
    
    vAdBGsubtract = VideoWriter('ArenaA_adaptiveBGsubtract.avi'); %Create video writing object
    open(vAdBGsubtract); %open video object to import data to be rendered

    threshold = 30; %parameter for thresholding images
    a = 0.10; %parameter for adaptive background equation
    
    image0 = strcat('DataSets',folder,files(1).name); %concat file path to first picture
    image0 = grayscale(image0); %get grayscale of image0
    
    image1 = image0; %Initial: assign background to image1;
                     %After mutiple iterations, will be reassigned based on
                     %adaptive background subtraction forumla (see later)
    
    for i = 1:length(files)
        
        image2 = strcat('DataSets',folder,files(i).name); %concat file path to current picture
        image2 = grayscale(image2); %get grayscale of current picture

        diff = abs(image1 - image2); %get absolute difference between pictures
        
        diff = thresholding(diff, threshold); %Image thresholding

        figure('visible', 'off'); %generate figure but don't display
        imshow(diff); %import thresholded picture to figure
        
        f = getframe(); %get frame for video
        writeVideo(vAdBGsubtract, f); %write video
        clf(); %clear current figure
        
        %image1 is now a blend of the current picture and previous picture
        image1 = floor(a.*image2 + (1-a).*image1);
        %If a = 1, => simple frame differencing
        %If a = 0, => simple background subtraction
    end
    
    close(vAdBGsubtract); %close video object to finish

%end