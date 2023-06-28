function F = getFeatureMoment(im, para)
    % 取得遮罩
    mask = getMomentMask(para.L);
    Lfeature = size(mask, 3);
    % 特徵影像
    M = zeros([size(im), size(mask, 3)]);
    for n = 1:Lfeature
        M(:,:,n) = imfilter(double(im), mask(:,:,n), "symmetric");
    end
    % 取出影像各點特徵值
    maskMean = fspecial('average', para.L*2+1);
    M = abs(tanh(para.epsilon .* M));
    for n = 1:Lfeature
        M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
    end
    F = reshape(M, para.imRow*para.imCol, size(M,3));
end

function mask = getMomentMask(L)
    [x,y] = meshgrid(-1:(1/L):1);
    
    mask = zeros([size(x), 6]);
    mask(:,:,1) = calMask(x,y,0,0);
    mask(:,:,2) = calMask(x,y,0,1);
    mask(:,:,3) = calMask(x,y,0,2);
    mask(:,:,4) = calMask(x,y,1,0);
    mask(:,:,5) = calMask(x,y,2,0);
    mask(:,:,6) = calMask(x,y,1,1);
end

function mask = calMask(x,y,a,b)
    mask = (x.^a).*(y.^b);
end