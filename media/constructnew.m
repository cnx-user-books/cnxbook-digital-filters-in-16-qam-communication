% This function simulates 16QAM Modulation with noise, input 4 bits

function s = constructnew(x,y,z,w)

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


L=41; %Filter Length
R=1E6; %Data Rate = 1Mbps
Fs=8*R; %Oversampling by 8
T=1/R;
Ts=1/Fs;

upi = upsample(i,Fs/R);
upq = upsample(q,Fs/R);

alpha =0.5; % Design Factor for Raised Cosing Filter

%----------------------------------------------------------
%Raised Cosing Filter Design
%----------------------------------------------------------
if mod(L,2)==0
    M=L/2 ; % for even value of L
else
    M=(L-1)/2; % for odd value of L    
end

g=zeros(1,L); %Place holder for RC filter's transfer function

for n=-M:M
    num=sin(pi*n*Ts/T)*cos(alpha*pi*n*Ts/T);
    den=(pi*n*Ts/T)*(1-(2*alpha*n*Ts/T)^2);
    
    g(n+M+1)=num/den;        
        
    if (1-(2*alpha*n*Ts/T)^2)==0
         g(n+M+1)=pi/4*sin(pi*n*Ts/T)/(pi*n*Ts/T);
    end
    if  n==0
         g(n+M+1)=cos(alpha*pi*n*Ts/T)/(1-(2*alpha*n*Ts/T)^2);
    end
end

rci=conv(g,upi); %Convolving the data signal with the Raised Cosine Filter
%y=filter(g,1,output); %you can use either Conv function or filter function to obtain the output
rcq=conv(g,upq);

t = [1:48]./48;
ireal = rci.*cos(2*pi*6.*t);
qimg = rcq.*sin(2*pi*6.*t);

s1 = ireal + qimg;   % actual signal to be transmitted without noise
s = channela(s1,5); % noise added to the signal



