function Pnew = InterpolateContourPoints(Pold, nPoints)
    % 輪廓點數量
    Pn = size(Pold, 1);
    
    % 輪廓內插
    m = ceil(nPoints/Pn);
    r1 = repmat(Pold, 3, 1);
    r2(:,1) = interp(r1(:,1), m);
    r2(:,2) = interp(r1(:,2), m);
    Pinterp = r2(1:(Pn*m+1), :);
    
    % 輪廓點間距調整
    dis = [0;cumsum(vecnorm(Pinterp((2:end), :)-Pinterp((1:end-1),:), 2, 2))];
    Pnew(:,1) = interp1(dis, Pinterp(:,1), linspace(0, dis(end),nPoints+1));
    Pnew(:,2) = interp1(dis, Pinterp(:,2), linspace(0, dis(end),nPoints+1));
    Pnew = Pnew(1:end-1, :);
end