%This function renders a video for adaptive background subtraction
%function adaptiveBGsubtract(folder)
    folder = '/getout/';
    directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
    files = dir(directory'); %load .jpg pictures to files (struct array)
    
    vAdBGsubtract = VideoWriter('getout_adaptiveBGsubtract.avi'); %Create video writing object
    open(vAdBGsubtract); %open video object to import data to be rendered

    threshold = 30; %parameter for thresholding images
    a = 0.25; %parameter for adaptive background equation
    
    image0 = strcat('DataSets',folder,files(1).name); %concat file path to first picture
    image0 = grayscale(image0);
    
    image1 = image0;
    
    for i = 1:length(files)
        
        %image1 = ceil(a.*image1 + (1-a).*image0);
        
        image2 = strcat('DataSets',folder,files(i).name); %concat file path to current picture
        image2 = grayscale(image2);

        new = abs(image1 - image2);
        
        new = thresholding(new, threshold);

        figure('visible', 'off');
        imshow(new);
        
        f = getframe();
        writeVideo(vAdBGsubtract, f);
        clf();
        
        image1 = floor(a.*image2 + (1-a).*image1);
    end
    
    close(vAdBGsubtract);

%end