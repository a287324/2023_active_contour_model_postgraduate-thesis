function im = colormapNormalize(im)
    % 分離出正負值
    indP = (im >= 0);
    indN = ~indP;
    P = im(indP);
    N = im(indN);
    % 數值調整前的數值意外情況提醒
%     fprintf("P的長度: %d\n", length(P));
%     fprintf("N的長度: %d\n", length(N));
    if length(P) <= 1
        warning("colormapNormalize: 輸入影像的正值數量為1個以下");
    end
    if length(N) <= 1
        warning("colormapNormalize: 輸入影像的負值數量為1個以下");
    end
    % 正負值個別調整數值(設定-0.5~0.5是為了color bar在顯示數值時,直覺上比較有效能看出正負值,如果寫0~1可能會有誤解的空間)
    P = rescale(P, 0, 0.5);
    N = rescale(N, -0.5, 0);
    % 將調整後的數值存回
    im(indP) = P;
    im(indN) = N;
end