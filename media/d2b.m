function b = d2b(r,c)
b=zeros(1,c);
while r > 0
    b(c-floor(log2(r)))=1;
    r = r-2^(floor(log2(r)));
end
return