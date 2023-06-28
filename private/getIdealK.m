% idealK: 2個常態分布的最佳分割的標準差
% flag_3: 2個常態分布的最佳特徵出現「未在分布中間」、「出現nan/inf」
function [idealK, flag_3] = getIdealK(Bmean, Bsigma, Omean, Osigma)
	% 計算一元二次公式解的係數
	a = Bsigma.^2-Osigma.^2;
    b = -2.*((Bsigma.^2).*Omean - (Osigma.^2).*Bmean);
    c = (Bsigma.^2).*(Omean.^2) - (Osigma.^2).*(Bmean.^2) - 2.*(Osigma.^2).*(Bsigma.^2).*log(Bsigma./Osigma);
	a(abs(a)<eps) = 0;
    b(abs(b)<eps) = 0;
    c(abs(c)<eps) = 0;
	% 一元二次公式解
    d = (b.^2)-4.*a.*c;
    d(abs(d)<eps) = 0;  % 因為曾經出現過小於eps的數值在之後開根號後，出現異常情況，至於是什麼異常情況，我忘記了，當時修正後，沒註解解釋原因
    rhovec_1 = (-b+sqrt(d))./(2.*a + eps);
    rhovec_2 = (-b-sqrt(d))./(2.*a + eps);
    rhovec_3 = (Bmean+Omean)/2;
    if sum(~isreal(d)) > 0
        error("getIdealK：出現complex");
    end
	if sum(isnan(rhovec_1)) > 0	% 只用warning，而不用error是因為後續的flag的判斷就會過濾掉
		warning("getIdealK: rhovec_1出現nan");
	end
	if sum(isinf(rhovec_1)) > 0
		warning("getIdealK: rhovec_1出現inf");
	end
	if sum(isnan(rhovec_2)) > 0
		warning("getIdealK: rhovec_2出現nan");
	end
	if sum(isinf(rhovec_2)) > 0
		warning("getIdealK: rhovec_2出現inf");
	end
	
% 	fprintf("最佳邊界點\n");
    flag_1 = ((rhovec_1-Omean).*(rhovec_1-Bmean))<0;
    flag_2 = ((rhovec_2-Omean).*(rhovec_2-Bmean))<0;
    flag_3 = (~(flag_1 | flag_2)) | (flag_1 & flag_2);	% 檢查 無解 和 重根解
    if sum(flag_1 & flag_2) > 0
        error("getIdealK：k值最佳解出現複數解");
    end
    rhovec = rhovec_1;
    rhovec(flag_2) = rhovec_2(flag_2);
    rhovec(flag_3) = rhovec_3(flag_3);
%     idealK = vecnorm(vecnorm((rhovec-Omean)./(Osigma+eps), 2, 2), 2, 1);
    idealK = vecnorm((rhovec-Omean)./(Osigma+eps), 2, 2);
end