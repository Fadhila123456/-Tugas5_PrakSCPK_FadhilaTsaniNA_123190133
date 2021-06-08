namaPelayan = {' Doni' ' Ranto' ' Lisa' ' Jennie' ' Anji'};
data = [5 6 5
        6 7 6
        8 9 9
        7 8 4
        4 5 9];
 
maksKecepatan = 10;
maksSikap = 10;
maksKualitas = 10;

data(:,1) = data(:,1) / maksKecepatan;
data(:,2) = data(:,2) / maksSikap;
data(:,3) = data(:,3) / maksKualitas;

relasiAntarKriteria = [ 1 2 4
                        0 1 2
                        0 0 1];
                    
TFN = {[-100/3 0 100/3]    [3/100 0 -3/100]
       [0 100/3 200/3]     [3/200 3/100 0 ]
       [100/3 200/3 300/3] [3/300 3/200 3/100]
       [200/3 300/3 400/3] [3/400 3/300 3/200]};
    
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);
    
if RasioKonsistensi < 0.10
% Metode Fuzzy AHP
  [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP_123190133(relasiAntarKriteria, TFN);
% Hitung nilai skor akhir
ahp = data * bobotAntarKriteria';
disp('=================================================')
disp('|    Hasil Perhitungan dengan metode Fuzzy AHP  |')
disp('=================================================')
disp('|Nama Pelayan   Skor Akhir   Kesimpulan         |')
end
    
for i = 1:size(ahp, 1)
    if ahp(i) < 0.5
        status = 'Kurang';
    elseif ahp(i) < 0.65
        status = 'Cukup';
    elseif ahp(i) < 0.8
        status = 'Baik';
    else
        status = 'Sangat Baik';
    end
    
    disp([char(namaPelayan(i)), blanks(13 - cellfun('length',namaPelayan(i))), '   ', ...
        num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), '   ', ...
        char(status)])
end