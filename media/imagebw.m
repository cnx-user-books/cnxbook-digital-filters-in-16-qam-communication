
% this function transmits and reconstructs an image by transforming it into
% black and white and then provides an output

function p = imagebw(image)

vect = imread(image);
abw = im2bw(vect);
newimage = zeros(512,512);

for h = 1:512
    for j = 1:128  
        s = constructnew(abw(h,4*j-3),abw(h,4*j-2),abw(h,4*j-1),abw(h,4*j));
        b = demodcn(s);
        newimage(h,4*j-3) = b(1);
        newimage(h,4*j-2) = b(2);
        newimage(h,4*j-1) = b(3);
        newimage(h,4*j) = b(4);
    end
end

p = imshow(newimage);