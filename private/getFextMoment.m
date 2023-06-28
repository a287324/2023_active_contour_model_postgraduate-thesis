function Fext = getFextMoment(P, Eext, para)
    % 取出輪廓點的Eext
    Cext = getFeatureImgPoint(Eext, P, para);
    % 計算輪廓的法線方向
    N = getContourNormal(P);
    % 計算Fext
    Fext = para.delta.*Cext.*N;
end
