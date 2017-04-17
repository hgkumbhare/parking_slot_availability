%code for a very simple image for detecting circles

% constants
sensitivity=0.6;
threshold_for_binary_image=100;
lower_cutoff_radius=5;
higher_cutoff_radius=25;

% take image as input
RGB = imread('/home/hgkumbhare/ivp project/images/image1.jpg');
imshow(RGB);

% convert rgb to grayscale image
I = rgb2gray(RGB);
figure
imshow(I)

% convert grayscale to binary image
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
