function F = getFeatureMyself(im, para)
    % 參數及遮罩
    maskL = para.L*2+1;
    mask_mean = fspecial('average', maskL);
    mask_LPF = fspecial('average', 7);
    % extract feature
    M = zeros([size(im), 4]);
    M(:,:,1) = imfilter(im, mask_mean, "symmetric");     % mean
    M(:,:,2) = M(:,:,1);    % 重複取DC值
    M(:,:,3) = imfilter(stdfilt(im, true(maskL)), mask_LPF, "symmetric");    % std
    M(:,:,4) = imfilter(entropyfilt(im, true(maskL)), mask_LPF, "symmetric");    % entropy
    % 取出影像各點特徵值
    F = reshape(M, para.imRow*para.imCol, size(M,3));
end

%% MyCombination
%% 1_DC_std_directly
%     % 參數及遮罩
%     maskL = para.L*2+1;
%     mask_mean = fspecial('average', maskL);
%     % extract feature
%     M = zeros([size(im), 2]);
%     M(:,:,1) = conv2(im, mask_mean, 'same');     % mean
%     M(:,:,2) = stdfilt(im, true(maskL));    % std
%% 2_DC_std_entropy_directly
%     % 參數及遮罩
%     maskL = para.L*2+1;
%     mask_mean = fspecial('average', maskL);
%     % extract feature
%     M = zeros([size(im), 3]);
%     M(:,:,1) = conv2(im, mask_mean, 'same');     % mean
%     M(:,:,2) = stdfilt(im, true(maskL));    % std
%     M(:,:,3) = entropyfilt(im, true(maskL));    % entropy
%% 2_DC2_std_entropy_directly
%     % 參數及遮罩
%     maskL = para.L*2+1;
%     mask_mean = fspecial('average', maskL);
%     % extract feature
%     M = zeros([size(im), 4]);
%     M(:,:,1) = conv2(im, mask_mean, 'same');     % mean
%     M(:,:,2) = M(:,:,1);    % 重複取DC值
%     M(:,:,3) = stdfilt(im, true(maskL));    % std
%     M(:,:,4) = entropyfilt(im, true(maskL));    % entropy
%% 2_DC2_std_entropy_LPF3
% 參數及遮罩
% maskL = para.L*2+1;
% mask_mean = fspecial('average', maskL);
% mask_LPF = fspecial('average', 3);
% % extract feature
% M = zeros([size(im), 4]);
% M(:,:,1) = imfilter(im, mask_mean, "symmetric");     % mean
% M(:,:,2) = M(:,:,1);    % 重複取DC值
% M(:,:,3) = imfilter(stdfilt(im, true(maskL)), mask_LPF, "symmetric");;    % std
% M(:,:,4) = imfilter(entropyfilt(im, true(maskL)), mask_LPF, "symmetric");    % entropy
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 2_DC2_std_entropy_LPF5
% 參數及遮罩
% maskL = para.L*2+1;
% mask_mean = fspecial('average', maskL);
% mask_LPF = fspecial('average', 5);
% % extract feature
% M = zeros([size(im), 4]);
% M(:,:,1) = imfilter(im, mask_mean, "symmetric");     % mean
% M(:,:,2) = M(:,:,1);    % 重複取DC值
% M(:,:,3) = imfilter(stdfilt(im, true(maskL)), mask_LPF, "symmetric");;    % std
% M(:,:,4) = imfilter(entropyfilt(im, true(maskL)), mask_LPF, "symmetric");    % entropy
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 2_DC2_std_entropy_LPF7
% % 參數及遮罩
% maskL = para.L*2+1;
% mask_mean = fspecial('average', maskL);
% mask_LPF = fspecial('average', 7);
% % extract feature
% M = zeros([size(im), 4]);
% M(:,:,1) = imfilter(im, mask_mean, "symmetric");     % mean
% M(:,:,2) = M(:,:,1);    % 重複取DC值
% M(:,:,3) = imfilter(stdfilt(im, true(maskL)), mask_LPF, "symmetric");    % std
% M(:,:,4) = imfilter(entropyfilt(im, true(maskL)), mask_LPF, "symmetric");    % entropy
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 3_DC_std_momentHighFreq_2_directly
%     % 參數
%     maskL = para.L*2+1;
%     % 遮罩設定
%     [x,y] = meshgrid(-1:(1/para.L):1);
%     mask_moment = zeros([size(x), 2]);
%     mask_moment(:,:,1) = calMask(x,y,0,1);
%     mask_moment(:,:,2) = calMask(x,y,1,0);
%     mask_mean = fspecial('average', maskL);
%     % moment
%     Mreg = zeros([size(im), size(mask_moment, 3)]);
%     for n = 1:size(mask_moment, 3)
%         Mreg(:,:,n) = conv2(im, mask_moment(:,:,n), 'same');
%     end
%     % extract feature
%     M = zeros([size(im), 3]);
%     M(:,:,1) = conv2(im, mask_mean, 'same');     % mean
%     M(:,:,2) = stdfilt(im, true(maskL));    % std
%     M(:,:,3) = vecnorm(Mreg, 2, 3);
    %% 3_DC_std_momentHighFreq_3_directly
%     % 參數
%     maskL = para.L*2+1;
%     % 遮罩設定
%     [x,y] = meshgrid(-1:(1/para.L):1);
%     mask_moment = zeros([size(x), 3]);
%     mask_moment(:,:,1) = calMask(x,y,0,1);
%     mask_moment(:,:,2) = calMask(x,y,1,0);
%     mask_moment(:,:,3) = calMask(x,y,1,1);
%     mask_mean = fspecial('average', maskL);
%     % moment
%     Mreg = zeros([size(im), size(mask_moment, 3)]);
%     for n = 1:size(mask_moment, 3)
%         Mreg(:,:,n) = conv2(im, mask_moment(:,:,n), 'same');
%     end
%     % extract feature
%     M = zeros([size(im), 3]);
%     M(:,:,1) = conv2(im, mask_mean, 'same');     % mean
%     M(:,:,2) = stdfilt(im, true(maskL));    % std
%     M(:,:,3) = vecnorm(Mreg, 2, 3);
%% Myself
%% 1_DC_directly
% % 取得遮罩
% maskL = para.L*2+1;
% mask_mean = fspecial('average', maskL);
% % 特徵影像
% M = conv2(im, mask_mean, 'same');     % mean
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 2_std_directly
% 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% M = stdfilt(im, true(maskL));    % std
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 3_skewness_directly
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% M = mean((imReg-Mmu).^3, 3);
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 3_skewness_abs
% 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% M = abs(mean((imReg-Mmu).^3, 3));
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 3_skewness_abs_LPF
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% M = abs(mean((imReg-Mmu).^3, 3));
% % LPF
% maskMean = fspecial('average', para.L*2+1);
% for n = 1:size(M,3)
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 4_kurtosis_directly
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% M = mean((imReg-Mmu).^4, 3);
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 5_skewness_coefficient_directly
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% Mskew = mean((imReg-Mmu).^3, 3);
% Mstd = stdfilt(im, true(maskL));    % std
% M = Mskew./(Mstd.^3 + eps);
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 5_skewness_coefficient_abs
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% Mskew = mean((imReg-Mmu).^3, 3);
% Mstd = stdfilt(im, true(maskL));    % std
% M = abs(Mskew./(Mstd.^3 + eps));
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 5_skewness_coefficient_abs_LPF
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% Mskew = mean((imReg-Mmu).^3, 3);
% Mstd = stdfilt(im, true(maskL));    % std
% M = abs(Mskew./(Mstd.^3 + eps));
% % LPF
% maskMean = fspecial('average', para.L*2+1);
% M = imfilter(M, maskMean, "symmetric");
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 6_kurtosis_coefficient_directly
% % 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% imReg = zeros([size(im),  maskL.^2]);
% z = 1;
% for x = -para.L:para.L
% 	for y = -para.L:para.L
% 		imReg(:, :, z) = circshift(circshift(im, x, 1), y, 2);
% 		z = z + 1;
% 	end
% end
% Mmu = mean(imReg, 3);
% Mkurosis = mean((imReg-Mmu).^4, 3);
% Mstd = stdfilt(im, true(maskL));    % std
% M = Mkurosis./(Mstd.^4 + eps);
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 7_entropy_directly
% 取得遮罩
% maskL = para.L*2+1;
% % 特徵影像
% M = entropyfilt(im, true(maskL));    % std
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_00_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_01_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_02_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,2);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
	% M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
	% M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_10_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_11_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_20_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,2,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_Highfreq_Cat_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_Highfreq_Norm1_2_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% M = vecnorm(M, 1, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_Highfreq_Norm1_3_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% M = vecnorm(M, 1, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_Highfreq_Norm2_2_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% M = vecnorm(M, 2, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 8_2D_moment_Highfreq_Norm2_3_tanh_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% % 取出影像各點特徵值
% maskMean = fspecial('average', para.L*2+1);
% M = abs(tanh(para.epsilon .* M));
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% M = vecnorm(M, 2, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_01_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_10_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_11_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_Highfreq_2_Cat
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_Highfreq_3_Cat
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_Highfreq_Norm1_2_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 1, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_Highfreq_Norm1_3_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 1, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_Highfreq_Norm2_2_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 2, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 9_2D_moment_Highfreq_Norm2_3_directly
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 2, 3);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 10_2D_moment_01_abs
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = abs(M);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 10_2D_moment_10_abs
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = abs(M);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 10_2D_moment_11_abs
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = abs(M);
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 11_2D_moment_01_tanh_abs
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = abs(tanh(para.epsilon .* M));
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 11_2D_moment_10_tanh_abs
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = abs(tanh(para.epsilon .* M));
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 11_2D_moment_11_tanh_abs
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = abs(tanh(para.epsilon .* M));
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_01_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,0,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% maskMean = fspecial('average', para.L*2+1);
% M = abs(M);
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_10_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,0);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% maskMean = fspecial('average', para.L*2+1);
% M = abs(M);
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_11_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% % mask = zeros([size(x), 6]);
% mask = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% maskMean = fspecial('average', para.L*2+1);
% M = abs(M);
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_Highfreq_2_Cat_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = abs(conv2(im, mask(:,:,n), 'same'));
% end
% % 特徵後處理
% maskMean = fspecial('average', para.L*2+1);
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_Highfreq_3_Cat_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = abs(conv2(im, mask(:,:,n), 'same'));
% end
% % 特徵後處理
% maskMean = fspecial('average', para.L*2+1);
% for n = 1:Lfeature
% 	M(:,:, n) = imfilter(M(:,:,n), maskMean, "symmetric");
% end
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_Highfreq_Norm1_2_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 1, 3);
% % 特徵後處理
% maskMean = fspecial('average', para.L*2+1);
% M = imfilter(M, maskMean, "symmetric");
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_Highfreq_Norm1_3_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 1, 3);
% % 特徵後處理
% maskMean = fspecial('average', para.L*2+1);
% M = imfilter(M, maskMean, "symmetric");
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_Highfreq_Norm2_2_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 2]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% % mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 2, 3);
% % 特徵後處理
% maskMean = fspecial('average', para.L*2+1);
% M = imfilter(M, maskMean, "symmetric");
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 12_2D_moment_Highfreq_Norm2_3_abs_LPF
% % 取得遮罩
% % mask = getMomentMask(para.L);
% [x,y] = meshgrid(-1:(1/para.L):1);
% mask = zeros([size(x), 3]);
% mask(:,:,1) = calMask(x,y,0,1);
% mask(:,:,2) = calMask(x,y,1,0);
% mask(:,:,3) = calMask(x,y,1,1);
% Lfeature = size(mask, 3);
% % 特徵影像
% M = zeros([size(im), size(mask, 3)]);
% for n = 1:Lfeature
% 	M(:,:,n) = conv2(im, mask(:,:,n), 'same');
% end
% M = vecnorm(M, 2, 3);
% % 特徵後處理
% maskMean = fspecial('average', para.L*2+1);
% M = imfilter(M, maskMean, "symmetric");
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 13_rangefilt_directly
% 取得遮罩
% maskL = para.L*2+1;
% M = rangefilt(double(im), true(maskL));
% % 取出影像各點特徵值
% F = reshape(M, para.imRow*para.imCol, size(M,3));
%% 13_rangefilt_LPF
% % 取得遮罩
% maskL = para.L*2+1;
% M = rangefilt(double(im), true(maskL));
% % LPF
% maskMean = fspecial('average', maskL);
% M = imfilter(M, maskMean, "symmetric");
% F = reshape(M, para.imRow*para.imCol, size(M,3));