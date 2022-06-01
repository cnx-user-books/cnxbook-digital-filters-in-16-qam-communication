

% this function takes an image as an input, runs it through QAM modulation
% and demodulates it and reconstructs it without using a Butterworth filter during
% modulation

function q = imagegrayb(image)

vect = imread(image);
gray = rgb2gray(vect);
grayint = zeros(512,512);

for k = 1:512 %log2 function in d2b wont accept uint8, must be doubles
    for l = 1:512
        grayint(k,l) = double(gray(k,l));
    end
end

newimage = zeros(512,4096); %will be the output

%binary mapping:
binarymatr = zeros(512,4096); %each element will be a string of 8 bits representing grayscale from 0-255

for k = 1:512 %column
    for l = 1:512 %row
        bits8 = d2b(grayint(k,l),8);
        for m = 1:8
            binarymatr(k,8*l+m-8) = bits8(m); %8 --> 8bits
        end
    end
end

g = butter(40,.75)./max(butter(40,.75));

for h = 1:512
    for j = 1:1024
        s = constructnewb(binarymatr(h,4*j-3),binarymatr(h,4*j-2),binarymatr(h,4*j-1),binarymatr(h,4*j),g);
        b = demodcn(s);
        newimage(h,4*j-3) = b(1);
        newimage(h,4*j-2) = b(2);
        newimage(h,4*j-1) = b(3);
        newimage(h,4*j) = b(4);
    end
end

p = zeros(512,512);

for h = 1:512
    for j = 1:512
        p(h,j) = b2d(newimage(h,8*j-7:8*j),8);
    end
end

q = imshow(p,[0,255]) %2nd arg is the "display range"