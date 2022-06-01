%16 QAM demodulator, takes output of the modulator with noise

function h = demodcn(s)

t = [1:48]./48;
ircvd = s.*cos(2*pi*6.*t);
qrcvd = s.*sin(2*pi*6.*t);

irecover = fft(ircvd);
irecover1 = [irecover(1:8) zeros(1,8) irecover(17:33) zeros(1,8) irecover(42:48)];
i1 = (ifft(irecover1));
[maxi,indi] = max(abs(i1));
if i1(indi) < 0
    maxi = -maxi;
end
itest = (2*maxi);
if itest <= -2
    i = -3;
elseif (itest >-2) && (itest <0)
    i = -1;
elseif (itest >=0) && (itest < 2)
    i = 1;
elseif itest >= 2
    i = 3;
end


qrecover = fft(qrcvd);
qrecover1 = [qrecover(1:8) zeros(1,8) qrecover(17:33) zeros(1,8) qrecover(42:48)];
q1 = (ifft(qrecover1));
[maxq, indq] = max(abs(q1));
if q1(indq) < 0
    maxq = -maxq;
end
qtest = 2*maxq;
if qtest <= -2
    q = -3;
elseif (qtest >-2) && (qtest <0)
    q = -1;
elseif (qtest >=0) && (qtest < 2)
    q = 1;
elseif qtest >= 2
    q = 3;
end

switch i
    case 1
        switch q
            case 1
                h=[0 0 0 0];
            case 3
                h=[0 0 1 0];
            case -1
                h=[0 1 0 0];
            case -3
                h=[0 1 0 1];
        end
    case 3
        switch q
            case 1
                h=[0 0 0 1];
            case 3
                h=[0 0 1 1];
            case -1
                h=[0 1 1 0];
            case -3
                h=[0 1 1 1];
        end
    case -1
        switch q
            case 1
                h=[1 0 0 0];
            case 3
                h=[1 0 0 1];
            case -1
                h=[1 1 0 0];
            case -3
                h=[1 1 1 0];
        end
    case -3
        switch q
            case 1
                h=[1 0 1 0];
            case 3
                h=[1 0 1 1];
            case -1
                h=[1 1 0 1];
            case -3
                h=[1 1 1 1];
        end
end

