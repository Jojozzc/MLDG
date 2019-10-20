clc, clear;
img_size = [10,4];
FCM = createRandMask(img_size, 7);
m = 3;
n = 3;





%%%%%%%%%%%%%%%%%%%%%%%%%
% function：   生成公平约束掩模FCM，每个像素点只能被遮挡一次
% @ParameterS：   m      图像行
%                n      图像列
%                A      每张模板上0的比例,0< A < 1
% @Return:       公平约束掩模FCM 是一个cell，FCM{i}代表第i个模板
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = FairConstraintMasking(img_size, A)
    if A <= 0 || A > 1
        FCM = cell(0);
        return;
    end
    m = img_size(1); % 图像高
    n = img_size(2); %图像宽
    Nmax = fix(1 / A); % 模板数
    FCM = cell(Nmax, 1); % 结果是一个cell，FCM(i)代表第i个模板
    mask_num = fix (m * n * A );  % 被遮挡的像素个数
    pixel_num = m * n;              % 总像素数
    rand_index = randperm(pixel_num);    % 将1~pixel_num打乱，例如有10个像素的时候，可能打乱成：4,1,9,2,5,6,10,7,3,8
    for i = 1 : Nmax % 每次生成一个模板FCM{i}
        idx_start = (i - 1) * mask_num + 1;   % 计算应该从拿开始截取rand_index
        idx_end = idx_start + mask_num - 1;   % 计算应该截取到哪，因为每次要遮挡mask_num个像素，所以从打乱的像素中截取mask_num个
        indies = rand_index(idx_start : idx_end); % 截取下来
        temp = ones(m, n); % 先生成全为1的m x n矩阵
        for j = 1 : mask_num  % 每次遮挡1个 一共遮挡mask_num个
            x = fix((indies(j) - 1) / n) + 1;  % 根据编号计算行
            y = mod((indies(j) - 1) , n) + 1;  % 根据编号计算列
            temp(x, y) = 0; % 将(x,y)处置为0
        %    fprintf('idx=%d, x=%d, y=%d\n',indies(j), x, y);
        end
        FCM{i, 1} = temp; % 生成好了第i个模板
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% function：   生成随机模板
% @Parameters：   m     图像行
%                 n      图像列
%                 N    模板个数
% @Return:       FCM 是一个cell，FCM{i}代表第i个模板
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = createRandMask(img_size, N)
    N = max(N, 0);
    m = img_size(1); % 图像高
    n = img_size(2); %图像宽
    FCM = cell(N, 1); % 
    for i = 1 : N
        temp = randi([0, 1], m, n);
        FCM{i, 1} = temp;
    end
end
