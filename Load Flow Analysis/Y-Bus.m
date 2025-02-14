clc
clear all;
nbranch=input("enter the number of branchers in system");
for n=1:1:nbranch
    fb=input("enter from bus =");
    tb=input("enter to bus =");
    r=input("enter the resistance");
    x=input("enter the reactance ");
    B=input("enter the value of line charging addmittance(b/2)" );
    z=r+i*x;
    y=1/z;
    ldata(n,:)=[fb tb r x B y];
end
fb=ldata(:,1);
tb=ldata(:,2);
r=ldata(:,3);
x=ldata(:,4);
b=ldata(:,5);
y=ldata(:,6);
b=b*i;
nbus=max(max(fb),max(tb));
Y=zeros(nbus,nbus);
for k=1:nbranch
    Y(fb(k),tb(k))=Y(fb(k),tb(k))-y(k);
    Y(tb(k),fb(k))=Y(fb(k),tb(k));
end
for m=1:nbus
    for n=1:nbranch
        if(fb(n))==m
            Y(m,m)=Y(m,m)+y(n)+b(n);
        elseif(tb(n))==m
            Y(m,m)=Y(m,m)+y(n)+b(n);
        end
    end
end
for k=1:nbus
    Y(k,k)=Y(k,k)
end
yb=Y
