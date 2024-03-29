function dF = gfilter(F)



a0 = 0;
a1 = .5;
a2 = 0;
a3 = 0;
a4 = 0;
a0 = 3565 / 10368;
a1 = 3091 / 12960;
a2 = 1997 / 25920;
a3 = 149 / 12960;
a4 = 107 / 103680;

n = max(size(F));


    I = [5:n-4];
    Ip = I + 1;
    Im = I -1;
    Ipp = Ip +1;
    Imm = Im -1;
    Ippp = Ipp + 1;
    Immm = Imm - 1;
    Ipppp = Ippp + 1;
    Immmm = Immm - 1;
    
    rhs(I,:) = a0*F(I,:) + a1*( F(Ip,:) + F(Im,:) ) + a2* (F(Ipp,:) + F(Imm,:)  ) +...
         a3* (F(Ippp,:) + F(Immm,:)  ) + a4* (F(Ipppp,:) + F(Immmm,:) );
    
    rhs(1,:) = (F(1,:)+F(2,:))/2;
    rhs(2,:) = .5*F(2,:) + .25*(F(1,:)+F(3,:));
    rhs(3,:) = .8125*F(3,:) + .125*(F(2,:)+F(4,:)) + -.03125*(F(1,:)+F(5,:));
    rhs(4,:) = .8125*F(4,:) + .125*(F(3,:)+F(5,:)) + -.03125*(F(2,:)+F(6,:));
    
    rhs(n-3,:) = .8125*F(n-3,:) + .125*(F(n-2,:)+F(n-4,:)) + -.03125*(F(n-1,:)+F(n-3,:));
    rhs(n-2,:) = .8125*F(n-2,:) + .125*(F(n-1,:)+F(n-3,:)) + -.03125*(F(n,:)+F(n-4,:));
    rhs(n-1,:) = .5*F(n-1,:) + .25*(F(n,:)+F(n-2,:)); 
    rhs(n,:) = (F(n,:)+F(n-1,:))/2;

dF = rhs;

% a0 = 3565 / 10368;
% a1 = 3091 / 12960;
% a2 = 1997 / 25920;
% a3 = 149 / 12960;
% a4 = 107 / 103680;
% 
% n = max(size(F));
% 
% 
% 
%     I = [5:n-4];
%     Ip = I + 1;
%     Im = I -1;
%     Ipp = Ip +1;
%     Imm = Im -1;
%     Ippp = Ipp + 1;
%     Immm = Imm - 1;
%     Ipppp = Ippp + 1;
%     Immmm = Immm - 1;
%     
%     rhs(I,:) = a0*F(I,:) + a1*( F(Ip,:) + F(Im,:) ) + a2* (F(Ipp,:) + F(Imm,:)  ) +...
%          a3* (F(Ippp,:) + F(Immm,:)  ) + a4* (F(Ipppp,:) + F(Immmm,:) );
%     
%     rhs(1,:) = F(1,:);
%     rhs(2,:) = .5*F(2,:) + .25*(F(1,:)+F(3,:));
%     rhs(3,:) = .8125*F(3,:) + .125*(F(2,:)+F(4,:)) + -.03125*(F(1,:)+F(5,:));
%     rhs(4,:) = .8125*F(4,:) + .125*(F(3,:)+F(5,:)) + -.03125*(F(2,:)+F(6,:));
%     
%     rhs(n-3,:) = .8125*F(n-3,:) + .125*(F(n-2,:)+F(n-4,:)) + -.03125*(F(n-1,:)+F(n-3,:));
%     rhs(n-2,:) = .8125*F(n-2,:) + .125*(F(n-1,:)+F(n-3,:)) + -.03125*(F(n,:)+F(n-4,:));
%     rhs(n-1,:) = .5*F(n-1,:) + .25*(F(n,:)+F(n-2,:)); 
%     rhs(n,:) = F(n,:);
% 
% dF = rhs;

end