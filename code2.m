% code for another simple image for detecting cirles

% constants
sensitivity=0.75;
lower_cutoff_radius=5;
higher_cutoff_radius=25;

% take image as input
RGB = imread('/home/hgkumbhare/ivp project/images/h1_park.jpg');
figure;
imshow(RGB);

% convert rgb to grayscale image
I = rgb2gray(RGB);
figure;
imshow(I);

% perform adaptive threshold
T = adaptthresh(I, 0.4);
BW = imbinarize(I,T);
I=BW;
figure;
imshow(I);

% perform opening operation on image
se = strel('square',2);
I = imopen(I,se);
figure;
imshow(I);

% get centers and radius of circles in the image and show them
[centers, radii] = imfindcircles(I,[lower_cutoff_radius higher_cutoff_radius],'ObjectPolarity','bright','Sensitivity',sensitivity);

centers_selected=[];
radii_selected=[];

figure;
imshow(I)

% filtering circles having radius in required range
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
centers_selected;
radii_selected;
if length(centers_selected)>0
    disp(length(centers_selected) + " slots available");
else
    disp("No slots available");
end
