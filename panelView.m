
images = 'corn.jpg'; %label for image to be processed

label = struct; %struct for label properties
label.color = 'r'; %label property
label.fontSize = 20; %label property

[ycoords,xcoords] = getDim(images); %get position coordinates for labels

im1 = grayscale(images); %turn image into grayscale
im2 = grayscale(images);
im3 = grayscale(images);
im4 = grayscale(images);

imArray = [im1 im2;im3 im4]; %add images to array
imshow(imArray) %show panel of images

%add labels to images
hold on
text(0,25,'Simple BG Subtraction','HorizontalAlignment','left', 'Color', label.color, 'FontSize', label.fontSize);
text(xcoords,25,'Simple Frame Differencing', 'Color', label.color, 'FontSize', label.fontSize);
text(0,ycoords+25,'Adaptive BG Subtraction', 'Color', label.color, 'FontSize', label.fontSize);
text(xcoords,ycoords+25,'Persistent Frame Differencing', 'Color', label.color, 'FontSize', label.fontSize);
hold off