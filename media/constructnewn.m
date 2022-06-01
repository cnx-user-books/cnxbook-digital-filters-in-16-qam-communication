

function s = constructnewn(x,y,z,w)

v=[x y z w];

a=[0 0 0 0];
b=[0 0 0 1];
c=[0 0 1 0];
d=[0 0 1 1];
e=[0 1 0 0];
f=[0 1 0 1];
g=[0 1 1 0];
h=[0 1 1 1];
i=[1 0 0 0];
j=[1 0 0 1];
k=[1 0 1 0];
l=[1 0 1 1];
m=[1 1 0 0];
n=[1 1 0 1];
o=[1 1 1 0];
p=[1 1 1 1];

a1=isequal(v,a);
b1=isequal(v,b);
c1=isequal(v,c);
d1=isequal(v,d);
e1=isequal(v,e);
f1=isequal(v,f);
g1=isequal(v,g);
h1=isequal(v,h);
i1=isequal(v,i);
j1=isequal(v,j);
k1=isequal(v,k);
l1=isequal(v,l);
m1=isequal(v,m);
n1=isequal(v,n);
o1=isequal(v,o);
p1=isequal(v,p);

if (a1==1)
    i=1;
    q=1;
end

if (b1==1)
    i=3;
    q=1;
end

if (c1==1)
    i=1;
    q=3;
end

if (d1==1)
    i=3;
    q=3;
end

if (e1==1)
    i=1;
    q=-1;
end

if (f1==1)
    i=1;
    q=-3;
end

if (g1==1)
    i=3;
    q=-1;
end

if (h1==1)
    i=3;
    q=-3;
end

if (i1==1)
    i=-1;
    q=1;
end

if (j1==1)
    i=-1;
    q=3;
end

if (k1==1)
    i=-3;
    q=1;
end

if (l1==1)
    i=-3;
    q=3;
end

if (m1==1)
    i=-1;
    q=-1;
end

if (n1==1)
    i=-3;
    q=-1;
end

if (o1==1)
    i=-1;
    q=-3;
end

if (p1==1)
    i=-3;
    q=-3;
end

upi1 = upsample(i,48);
upq1 = upsample(q,48);

upi=upi1';
upq=upq1';

t = [1:48]./48;
ireal = upi.*cos(2*pi*6.*t);
qimg = upq.*sin(2*pi*6.*t);

s1 = ireal + qimg;   % actual signal to be transmitted without noise
s = channela(s1,5); % noise added to the signal
