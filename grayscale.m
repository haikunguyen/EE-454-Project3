function [gray_im] = grayscale(pic)
%Converts inputted image to grayscale (0-255)

RGB = imread(pic);
gray_im = rgb2gray(RGB);
end