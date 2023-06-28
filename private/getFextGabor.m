function Fext = getFextGabor(P, Ebal, Fimg, para)
    % 取出輪廓點的Fimg
    FimgContour = zeros(size(P));
    FimgContour(:,1) = interp2(Fimg.x, P(:,1), P(:,2));
    FimgContour(:,2) = interp2(Fimg.y, P(:,1), P(:,2));
    
    % 取出輪廓點的Fbal
    EbalContour = getFeatureImgPoint(Ebal, P, para);
    N = getContourNormal(P);    % 計算輪廓的法線方向
    Fbal = EbalContour .* N;
    
    % 計算Fext
    Fext = para.delta*FimgContour + para.epsilon.*Fbal;
end