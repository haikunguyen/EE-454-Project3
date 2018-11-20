%This function renders a video for adaptive background subtraction
%function adaptiveBGsubtract(folder)
    folder = '/ArenaA/';
    directory = strcat('DataSets',folder,'*.jpg'); %concat strings to get file path
    files = dir(directory'); %load .jpg pictures to files (struct array)
    
    vAdBGsubtract = VideoWriter('ArenaA_adaptiveBGsubtract.avi'); %Create video writing object
    open(vAdBGsubtract); %open video object to import data to be rendered

    a = 0.5; %parameter for adaptive background equation
    
    for i = 1:length(files)
        image1 = strcat('DataSets',folder,files(1).name); %concat file path to first picture
        image1 = grayscale(image1); %convert int numbers in grayscale to double
        image0 = image1;
        
        image2 = strcat('DataSets',folder,files(i).name);
        image2 = grayscale(image2);

        new = (image1 - image2).^2;

        figure('visible', 'off');
        imshow(new);
        
        f = getframe();
        writeVideo(vAdBGsubtract, f);
        clf();
        
        image1 = ceil(a.*image2 + (1-a).*image0);
    end
    
    close(vAdBGsubtract);

%end