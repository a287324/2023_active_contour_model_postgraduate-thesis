function F = getFeatureGabor(im, para)
    % 設置gabor filter
    gaborFilter = gabor(para.gaborRadius, para.gaborAngle);
    Lfeature = length(gaborFilter);
    % 特徵影像
    M = imgaborfilt(im, gaborFilter);
    % 取出影像各點特徵值
    Np = para.imRow*para.imCol;
    maskMean = fspecial('average', para.L*2+1);
    M = abs(M);
    for n = 1:Lfeature
        M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
    end
    F = reshape(M, Np, size(M,3));
end