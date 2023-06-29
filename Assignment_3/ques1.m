filename=input('ENTER THE FILE NAME :\n','s');
filedata=textread(filename,"%f");
n=filedata(1);
x = zeros(1,n);
y = zeros(1,n);
A = filedata(2:2*n+1);
m = filedata(2*n+2);
D = filedata(2*n+3:end);
i = 1;
j = 1;
while i<=n
    x(i) = A(j);
    j = j+2;
    i = i+1;
end
i = 1;
j = 2;
while i<=n
    y(i) = A(j);
    j = j+2;
    i = i+1;
end
n = n-1; %number of sub intervals
h = (x(n+1)-x(1))/n;
Trid = diag(4*ones(1,n-1)) + diag(ones(1,n-2),1) + diag(ones(1,n-2),-1);
B = zeros(1,n-1);
for i = 1:n-1
    B(i) = 6/h^2*(y(i+2) + y(i)-2*y(i+1));
end
sigma = [0;inv(Trid)*B';0];

for i=1:n
    a(i) = (sigma(i+1) - sigma(i))/(6*h);
    b(i) = sigma(i)/2;
    c(i) = (y(i+1)-y(i))/h - h/6*(sigma(i+1) + 2*sigma(i));
    d(i) = y(i);
end

r = 10;
h1 = h/r;
x1 = x(1):h1:x(n+1);

for i=1:n
    for j = r*i-r+1 : r*i
        f = x1(j) - x(i);
        s(j) = a(i)*f^3 + b(i)*f^2 + c(i)*f + d(i);
        for k = 1:m
            if x1(j) == D(k)
                G(k) = s(j);
            end
        end
    end
end
s(r*n+1) = y(n+1);
C = [x1' s'];
plot(x,y,'o')
grid on
hold on 
plot(x1,s,'-x')
hold off


%% langrange
n = n+1;
L = zeros(n);
for i=1:n
    f=1;
    for j=1:n
        if i~=j
            f = conv(f,poly(x(j)))/(x(i)-x(j));
        end
    end
    L(i,:) = f*y(i);
end
P = sum(L);
X = linspace(x(1),x(n),100);
Y = polyval(P,X);
plot(x,y,'o');
hold on
plot (X,Y,'r');
plot (x1,s,'g');
grid on;
fid = fopen('Ans1.txt','wt');
fprintf(fid,'Ablokit Joshi Answers\n\n');
fprintf(fid,'Using Spline\n\n');
for i=1:n1
    fprintf(fid,'%f\t%f\n',x1(i),s(i));
end
fprintf(fid,'\n\nUsing Langrange Polynomials\n\n');
for i=1:m
    fprintf(fid,'%.4f\t%.4f\n',D(i),polyval(P,D(i)));
end
