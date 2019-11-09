%%%%%%%%%%%%%%%%%%%%%%%%%
% function��   ���ɹ�ƽԼ����ģFCM��ÿ�����ص�ֻ�ܱ��ڵ�һ��
% @ParameterS��   m      ͼ����
%                n      ͼ����
%                A      ÿ��ģ����0�ı���,0< A < 1
% @Return:       ��ƽԼ����ģFCM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = FairConstraintMasking(img_size, A)
    if A <= 0 || A > 1
        FCM = cell(0);
        return;
    end
    m = img_size(1);
    n = img_size(2);
    Nmax = round(1 / A);     % ģ����Ŀ���ֵNmax = 1/A��round����ȡ��
    FCM = cell(Nmax, 1);
    mask_num = round (m * n * A );  % ģ������
    pixel_num = m * n;            % ������
    rand_index = randperm(pixel_num);    
    for i = 1 : Nmax
        indies = rand_index(i : i + mask_num - 1);
        temp = ones(m, n);
        for j = 1 : mask_num
            x = round(indies(j) / n) + 1;
            y = mod(m,indies(j) ) + 1;
            temp(x, y) = 0;
        end
        FCM{i, 1} = temp;
    end
end
