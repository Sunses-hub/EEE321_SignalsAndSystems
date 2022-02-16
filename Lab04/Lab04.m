
%-----------------------------------PART3----------------------------------


% 
% x=[8 1 6; 3 5 7; 4 9 2];
% h=[1 3; 4 2];
% y=DSLSI2D(h,x)

%----------------------------------Part4-----------------------------------

% x=ReadMyImage('Part4.bmp');
% imshow(x,[]);
% title("Original Image");
% figure;
% 
% D17=rem(21703190,17);
% Mh=20+D17;
% Nh=Mh;
% 
% h1=FINDH(0.8,Mh,Nh);
% filtered_im1 = DSLSI2D(h1,x);
% h2=FINDH(0.5,Mh,Nh);
% filtered_im2 = DSLSI2D(h2,x);
% h3=FINDH(0.2,Mh,Nh);
% filtered_im3 = DSLSI2D(h3,x);
% subplot(3,1,1),imshow(filtered_im1,[]);
% title("Filtered Image with B=0.8");
% subplot(3,1,2),imshow(filtered_im2,[]);
% title("Filtered Image with B=0.5");
% subplot(3,1,3),imshow(filtered_im3,[]);
% title("Filtered Image with B=0.2");

%-----------------------------------Part5----------------------------------


% x=ReadMyImage('Part5.bmp');
% imshow(x,[])
% title("Original Image");
% figure;
% h1=[1 -1;0 0];
% y1=DSLSI2D(h1,x);
% s1=y1.*y1;
% imshow(s1,[]);
% title("Output with h1");
% figure;
% %DisplayMyImage(s1)
% h2=[1 0;-1 0];
% y2=DSLSI2D(h2,x);
% s2=y2.*y2;
% imshow(s2,[]);
% title("Output with h2");
% figure;
% h3 = 0.5*h1+0.5*h2;
% y3=DSLSI2D(h3,x);
% s3 = y3.*y3;
% imshow(s3,[]);
% title("Output with h3");
%---------------------------------Part6------------------------------------
% x=ReadMyImage('Part6x.bmp');
% DisplayMyImage(x);
% h=ReadMyImage("Part6h.bmp");
% DisplayMyImage(h);
% 
% y=DSLSI2D(h,x);
% imshow(abs(y),[]);
% title("|y[m,n]|");
% figure;
% imshow(abs(y).^3,[]);
% title("|y[m,n]|^3");
% figure;
% imshow(abs(y).^5,[]);
% title("|y[m,n]|^5");


%--------------------------------------------------------------------------
function [y] = DSLSI2D(h,x)
    [Mh,Nh]=size(h);
    [Mx,Nx]=size(x);
    
    My = Mh+Mx-1;
    Ny = Nh+Nx-1;
    
    y = zeros(My,Ny);
    
    for k=0:Mh-1
        for l=0:Nh-1
            y(k+1:k+Mx,l+1:l+Nx) = y(k+1:k+Mx,l+1:l+Nx)+h(k+1,l+1)*x;
        end
    end
end

function [h]= FINDH(B,Mh,Nh)
    h=zeros(Mh,Nh);
    for m=0:Mh-1
        for n=0:Nh-1
            x1=sym(B*(m+1/2-Mh/2));
            s1=sinc(x1);
            x2=sym(B*(n+1/2-Nh/2));
            s2=sinc(x2);
            h(m+1,n+1)=s1*s2;
        end
    end
end
