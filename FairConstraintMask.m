%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function��     ���ɹ�ƽԼ����ģFCM��ÿ�����ص�ֻ�ܱ��ڵ�һ��,M1+M2+����Mn = (N-1)O
% @Parameters��  img_size    ͼ���С ��[255, 255]
%                A           ÿ��ģ����0�ı���,0 < A < 1��д�ɷ���������1/5
% @Return:       ��ƽԼ����ģFCM ��һ��cell��FCM{i}�����i��ģ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = FairConstraintMask(img_size, A)
    if A <= 0 || A > 1
        FCM = cell(0);
        return;
    end
    m = img_size(1);   % ͼ���
    n = img_size(2);    %ͼ���
    Nmax = fix(1 / A);     % ģ�������Ŀ
    FCM = cell(Nmax, 1);     % �����һ��cell��FCM(i)�����i��ģ��
    pixel_num = m * n;              % ��������
    dark_num = fix (m * n * A );      % ÿ��ģ���ϱ��ڵ������ظ�������0�ĸ���
%     fprintf('ÿ����0�ĸ���Ϊ��%d\n',dark_num);
    rand_index = randperm(pixel_num);    % ��1~pixel_num������ң�������10�����ص�ʱ�򣬿��ܴ��ҳɣ�4,1,9,2,5,6,10,7,3,8
    
    for i = 1 : Nmax     % ÿ������һ��ģ��FCM{i}
        temp = ones(m, n); % ����ȫΪ1��m x n����
        
        idx_start = (i - 1) * dark_num + 1;   % ����Ӧ�ô��Ŀ�ʼ��ȡrand_index
        idx_end = idx_start + dark_num - 1;   % ����Ӧ�ý�ȡ���ģ���Ϊÿ��Ҫ�ڵ�dark_num�����أ����ԴӴ��ҵ������н�ȡdark_num��
        indies = rand_index(idx_start : idx_end); % ��ȡ����
        
        for j = 1 : dark_num  % ÿ���ڵ�1�� һ���ڵ�adrk_num��
            x = fix((indies(j) - 1) / n) + 1;  % ���ݱ�ż�����
            y = mod((indies(j) - 1) , n) + 1;  % ���ݱ�ż�����
            temp(x, y) = 0; % ��(x,y)����Ϊ0
        end
        FCM{i, 1} = temp; % ���ɺ��˵�i��ģ��
    end
end
