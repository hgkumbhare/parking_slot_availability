% variables
sensitivity=0.6;
total_slots=8;
threshold_for_binary_image=100;
lower_cutoff_radius=5;
higher_cutoff_radius=25;

% take image as input
RGB = imread('/home/hgkumbhare/ivp project/images/image1.jpg');
imshow(RGB);

% convert rgb to gray scale image
I = rgb2gray(RGB);
figure
imshow(I)

% convert to binary image
I=I>threshold_for_binary_image;
figure;
imshow(I);

% get centers and radius of circles in the image and show them
[centers, radii] = imfindcircles(I,[lower_cutoff_radius higher_cutoff_radius],'ObjectPolarity','bright','Sensitivity',sensitivity);
h = viscircles(centers,radii);

% display number of empty slots
if length(centers)>0
    disp(length(centers) + " slots available");
else
    disp("No slots available");
end