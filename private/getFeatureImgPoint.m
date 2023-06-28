function Pfeature = getFeatureImgPoint(F, P, para)
    P = round(P);
    ind = sub2ind([para.imRow, para.imCol], P(:,2), P(:,1));
    Pfeature = F(ind, :);
end