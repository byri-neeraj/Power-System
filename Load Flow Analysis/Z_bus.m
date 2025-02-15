clc;
clear all;
close all;
limdata = [1 1 0 0 1.0
    2 1 2 0 0.25
    3 2 0 0 1.25
    2 2 3 0 0.05];
j = sqrt(-1);
i = sqrt(-1);
q = limdata(:,1);
n1 = limdata(:,2);
nr = limdata(:,3);
R = limdata(:,4);
X = limdata(:,5);
nbr = length(limdata(:,1));
nbus = max(max(n1),max(nr));
Z=R+j*X;
for m = 1:nbr
    fprintf('Step:%g\n', m)
    n = q(m);
    switch n
        case 1
            disp('Case 1: reference bus to new Bus')
            for ii=1:1
                Zbus1(ii,ii)=Z(m);
            end
            Zbus1
        case 2
            disp('Case 2: Existing Bus to new Bus')
            k=max(length(Zbus1));
            for ii=1:k
                Zbus1(k+1,k+1)=Zbus1(k,k)+Z(m);
                Zbus1(k+1,ii) = Zbus1(k,ii);
                Zbus1(ii,k+1) = Zbus1(k+1,ii);
            end
            Zbus1
        case 3
            disp('case 3: Existing Bus to Reference Bus')
            k=max(length(Zbus1));
            for ii = 1:k
                Zbus1(k+1,k+1)=Zbus1(k,k)+Z(m);
                Zbus1(k+1,ii) = Zbus1(k,ii);
                Zbus1(ii, k+1)=Zbus1(k+1,ii);
            end
            Zbus1
            disp('Reduced Matrix Size')
            k=max(length(Zbus1));
            for ii = 1:k-1
                for jj = 1:k-1
                    Zbus1(ii,jj) = Zbus1(ii,jj)-(Zbus1(ii,k)*Zbus1(k,jj))/Zbus1(k,k);
                end
            end
        Zbus1(:,k)=[];
        Zbus1(k,:)=[];
        Zbus1
        otherwise
    end
end
