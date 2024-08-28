filenames = {
	% "/Users/leepaperny/Desktop/Final Project/Results/Archive/nsp/nspBigLeaf1.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/sp/spBigLeaf2.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/sp/spBigLeaf3.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/sp/spBigLeaf4.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/sp/spBigLeaf5.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/nsp/nspBigLeaf1.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/nsp/nspBigLeaf2.mat",
	% "./nsp/nspBigLeaf3.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/nsp/nspBigLeaf4.mat",
	"/Users/leepaperny/Desktop/Final Project/Results/Archive/nsp/nspBigLeaf5.mat",
	};

for iter = 1:length(filenames)
	file_data = load(filenames{iter});

	field_names = fieldnames(file_data);
	data_matrix = file_data.(field_names{1});

	frequency = data_matrix(:, 1);
	phase = -data_matrix(:, 2);
	gain = data_matrix(:, 4);

	measurements{iter}.frequency = frequency;
	measurements{iter}.phase = phase;
	measurements{iter}.gain = gain;

	measurements{iter}.impedance = gain .* exp(j .* deg2rad(phase));

	measurements{iter}.filename = filenames{iter};

    if contains(filenames{iter}, 'nsp')
        measurements{iter}.colour = colours(1,:);
		measurements{iter}.label_for_legend = 'NSP';
    elseif contains(filenames{iter}, 'sp')
        measurements{iter}.colour = colours(2,:);
		measurements{iter}.label_for_legend = 'SP';
    else
        measurements{iter}.colour = colours(3,:);
    end
end
