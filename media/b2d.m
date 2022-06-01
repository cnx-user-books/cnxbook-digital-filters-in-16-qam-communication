function d = b2d(b,c)
d=0;
for i=1:c
    if b(i)==1
        d=d+2^(c-i);
    end
end
return
