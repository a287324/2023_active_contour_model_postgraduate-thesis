function [MDAD, Escb, Ecbs] = calPrecisionMetric(C, para)
    % 讀取理想邊緣
    load(para.idealEdge);
    % 輪廓點數量
    Nc = size(C, 1);    % 輪廓點的數量
    Nideal = size(desiredEdge, 3); % 理想輪廓點的數量
    % 每個輪廓點與每個理想輪廓點的距離
    dis = vecnorm((C-desiredEdge), 2, 2);
    % MDAD(每個輪廓點與最近的理想輪廓點的距離中的最大值)
    MDAD = max(min(dis, [], 3));
    % Escb(每個輪廓點與最近的理想輪廓點，小於最小距離的比率，簡單講即輪廓在理想輪廓上的占比)
    reg = min(dis, [], 3);
    Escb = sum(reg<7)/Nc;
    % Ecbs(理想輪廓點與最近的輪廓點小於最小距離的比率，簡單講即理想輪廓上有多少輪廓的占比) 
    % ps: 這個是我自己想的，因為Escb這個標準我覺得很不客觀，因為之前有發生所有輪廓點都擠到一個點上，結果Escb很高，但從視覺上就很明顯可以看到根本是無效分割
    reg = min(dis, [], 1);
    Ecbs = sum(reg<7)/Nideal;
end