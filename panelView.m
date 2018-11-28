%load pictures from folder
parentFolder = 'DataSets';
folderName = 'ArenaA'; %name of folder for video object
folder = strcat('/', folderName, '/'); %name of folder to load pictures from
directory = strcat(parentFolder,folder,'*.jpg'); %concat strings to get folder path to pictures
files = dir(directory); %load .jpg pictures to files (struct array)

%make new directory for images after processing
newFolderName = strcat('new', folderName); %name of folder for new images
mkdir(pwd, newFolderName); %make new folder for new images

%struct for label properties
label = struct; %declare a struct
label.color = 'r'; %label property
label.fontSize = 10; %label property

%paramters for motion detection algorithms
threshold = 30; %parameter for thesholding in all motion detection algorithms
alpha = 0.10; %parameter for adaptive background subtraction
gamma = 40; %parameter for persistent frame differencing

%background set up for each algorithm   
imageB1 = strcat(parentFolder,folder,files(1).name); %concat file path for 1st picture (Simple Background Subtraction)
imageB1 = grayscale(imageB1); %get grayscale of 1st picture

imageB2 = imageB1; %Simple Frame Differencing (reusing background because it's the same for initial image)

imageB3 = imageB1; %Adaptive Background Subtraction

imageB4 = imageB1; %Persistent Frame Differencing
imageH = 0; %intermediate closed-loop image for persistent frame differencing

%get position coordinates for labels
[ycoords,xcoords] = getDim(strcat(parentFolder,folder,files(1).name));

%motion detection algorithms (4)
for i = 1:length(files)
    %1. Simple Background Subtraction Algorithm
    imageI1 = strcat(parentFolder,folder,files(i).name); %concat file path to current picture
    imageI1 = grayscale(imageI1); %get grayscale of current picture
    diff1 = abs(imageB1 - imageI1); %get absolute difference between background and current pictures
    diff1 = thresholding(diff1, threshold); %image thresholding
    im1 = diff1; %assignment for display formatting later
    
    %2. Simple Frame Differencing
    imageI2 = imageI1; %(reusing current picture because it's the same)
    diff2 = abs(imageB2 - imageI2); %get absolute difference between previous and current pictures
    diff2 = thresholding(diff2, threshold);
    im2 = diff2; %assignment for display formatting later
    imageB2 = imageI2; %replace background picture with current picture for next iteration
    
    %3. Adaptive Background Subtraction
    imageI3 = imageI1; %(reusing current picture because it's the same)
    diff3 = abs(imageB3 - imageI3); %get absolute difference between blended and current pictures
    diff3 = thresholding(diff3, threshold);
    im3 = diff3; %assignment for display formatting later
    imageB3 = floor(alpha.*imageI3 + (1-alpha).*imageB3); %blend current and previous picture
                                                          %If alpha = 1, => simple frame differencing
                                                          %If alpha = 0, => simple background subtraction
    
    %4. Persistent Frame Differencing
    imageI4 = imageI1; %(reusing current picture because it's the same)
    diff4 = abs(imageB4 - imageI4); %get absolute difference between previous and current pictures
    diff4 = thresholding(diff4, threshold);
    tmp = max(imageH - gamma, 0); %temporary image; persistent frame differencing distinction starts here
                                  %if gamma increases, => the motion history, or "ghost," trail decays faster
    imageH = max(255.*diff4, tmp);
    im4 = imageH; %assignment for display formatting later
    imageB4 = imageI4; %replace previous image with current image for next iteration
    
    %add images to array
    imArray = [im1 im2; im3 im4];
    
    %generate figure
    figure('visible', 'off'); %don't display figure
    imshow(imArray); %import panel of images onto figure
    
    %add labels to images
    hold on
    text(0, 25, 'Simple BG Subtraction', 'Color', label.color, 'FontSize', label.fontSize);
    text(xcoords, 25, 'Simple Frame Differencing', 'Color', label.color, 'FontSize', label.fontSize);
    text(0, ycoords + 25, 'Adaptive BG Subtraction', 'Color', label.color, 'FontSize', label.fontSize);
    text(xcoords, ycoords + 25, 'Persistent Frame Differencing', 'Color', label.color, 'FontSize', label.fontSize);
    hold off
    
    saveas(gcf, strcat(newFolderName, '/', sprintf('%04d', i), '.png'));
    clf(); %clear current figure
end

%generate video
makeVideo(newFolderName, folderName);