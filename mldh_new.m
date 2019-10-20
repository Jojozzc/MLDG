clc, clear;
img_size = [10,4];
FCM = createRandMask(img_size, 7);
m = 3;
n = 3;





%%%%%%%%%%%%%%%%%%%%%%%%%
% function��   ���ɹ�ƽԼ����ģFCM��ÿ�����ص�ֻ�ܱ��ڵ�һ��
% @ParameterS��   m      ͼ����
%                n      ͼ����
%                A      ÿ��ģ����0�ı���,0< A < 1
% @Return:       ��ƽԼ����ģFCM ��һ��cell��FCM{i}�����i��ģ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = FairConstraintMasking(img_size, A)
    if A <= 0 || A > 1
        FCM = cell(0);
        return;
    end
    m = img_size(1); % ͼ���
    n = img_size(2); %ͼ���
    Nmax = fix(1 / A); % ģ����
    FCM = cell(Nmax, 1); % �����һ��cell��FCM(i)�����i��ģ��
    mask_num = fix (m * n * A );  % ���ڵ������ظ���
    pixel_num = m * n;              % ��������
    rand_index = randperm(pixel_num);    % ��1~pixel_num���ң�������10�����ص�ʱ�򣬿��ܴ��ҳɣ�4,1,9,2,5,6,10,7,3,8
    for i = 1 : Nmax % ÿ������һ��ģ��FCM{i}
        idx_start = (i - 1) * mask_num + 1;   % ����Ӧ�ô��ÿ�ʼ��ȡrand_index
        idx_end = idx_start + mask_num - 1;   % ����Ӧ�ý�ȡ���ģ���Ϊÿ��Ҫ�ڵ�mask_num�����أ����ԴӴ��ҵ������н�ȡmask_num��
        indies = rand_index(idx_start : idx_end); % ��ȡ����
        temp = ones(m, n); % ������ȫΪ1��m x n����
        for j = 1 : mask_num  % ÿ���ڵ�1�� һ���ڵ�mask_num��
            x = fix((indies(j) - 1) / n) + 1;  % ���ݱ�ż�����
            y = mod((indies(j) - 1) , n) + 1;  % ���ݱ�ż�����
            temp(x, y) = 0; % ��(x,y)����Ϊ0
        %    fprintf('idx=%d, x=%d, y=%d\n',indies(j), x, y);
        end
        FCM{i, 1} = temp; % ���ɺ��˵�i��ģ��
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% function��   �������ģ��
% @Parameters��   m     ͼ����
%                 n      ͼ����
%                 N    ģ�����
% @Return:       FCM ��һ��cell��FCM{i}�����i��ģ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = createRandMask(img_size, N)
    N = max(N, 0);
    m = img_size(1); % ͼ���
    n = img_size(2); %ͼ���
    FCM = cell(N, 1); % 
    for i = 1 : N
        temp = randi([0, 1], m, n);
        FCM{i, 1} = temp;
    end
end
