function imColor = colormapAmpImg(im)
    % 讀取colorBar
    load('ColorBar_jet.mat');
    % 強度轉換(因為我介意的是正負值,而不是數值的大小,因此使用sigmoid function來調整數值,讓0值附近的數值變化更明顯,並讓離0值愈遠的數值越不明顯)
    im_scale = tanh(im);
    % 數值調變,將數值的正負值分離後調整到[-0.5, 0.5],如果調整前不分離正負值,可能會導致 正值變成負值 或 負值變成正值
    imNormal = colormapNormalize(im_scale);
    % 數值調變到colorBar的index
    imQ = floor(rescale(imNormal, 1, 256));
    % 偽色
    imColor = reshape(colorBar(imQ, 1, :), size(imNormal,1), size(imNormal, 2), 3);
    % figure();   imshow(imColor);
end