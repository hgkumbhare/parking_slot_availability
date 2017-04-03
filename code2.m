% variables
sensitivity=0.75;
total_slots=8;
threshold_for_binary_image=210;
lower_cutoff_radius=5;
higher_cutoff_radius=25;

% take image as input
RGB = imread('/home/hgkumbhare/ivp project/images/h1_park.jpg');
%figure;
%imshow(RGB);

% convert rgb to gray scale image
I = rgb2gray(RGB);
figure;
imshow(I)

% convert to binary image
I=I>threshold_for_binary_image;
figure;
imshow(I);

% get centers and radius of circles in the image and show them
[centers, radii] = imfindcircles(I,[lower_cutoff_radius higher_cutoff_radius],'ObjectPolarity','bright','Sensitivity',sensitivity);


centers_selected=[];
radii_selected=[];

% filtering messages

i=1;
while i<=length(radii)
    if radii(i)<10
        radii_selected=[radii_selected ; radii(i)];
        centers_selected=[centers_selected ; centers(i,1) centers(i,2)];
    end
    i=i+1;
end

h = viscircles(centers_selected,radii_selected);
% display number of empty slots
if length(centers_selected)>0
    disp(length(centers_selected) + " slots available");
else
    disp("No slots available");
end