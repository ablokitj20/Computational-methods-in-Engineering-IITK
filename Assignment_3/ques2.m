filename=input('ENTER THE FILE NAME :\n','s');
filedata=textread(filename,"%f");
n=filedata(1);
x = zeros(1,n);
y = zeros(1,n);
A = filedata(2:end);
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
p = polyfit(x,y,1);
q = polyfit(x,y,2);
r = polyfit(x,y,3);
s = polyfit(x,y,4);

xp = x(1):0.001:max(x);
yp = polyval(p,xp);
yq = polyval(q,xp);
yr = polyval(r,xp);
ys = polyval(s,xp);
plot(x,y,'o')
hold on
plot(xp,yp,'r')
plot(xp,yq,'g')
plot(xp,yr,'b')
plot(xp,ys,'c')
grid on
hold off
p = flip(p);
q = flip(q);
r = flip(r);
s = flip(s);
fid = fopen('Ans2.txt','wt');
fprintf(fid,'Ablokit Joshi Answers\n\n');
fprintf(fid,'Linear Coeff: ');
fprintf(fid,'%.4f\t',p);
fprintf(fid,'\n');
fprintf(fid,'Quadratic Coeff: ');
fprintf(fid,'%.4f\t',q);
fprintf(fid,'\n');
fprintf(fid,'Cubic Coeff: ');
fprintf(fid,'%.4f\t',r);
fprintf(fid,'\n');
fprintf(fid,'Byquadratic Coeff: ');
fprintf(fid,'%.4f\t',s);