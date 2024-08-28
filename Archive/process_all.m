setup_environment;

load_data;
define_helper_functions;
set_params_for_fitting;

fig = figure('units','centimeters','outerposition',[0, 0, 0.8 * 21.0, 0.5 * 29.7]);

gain_plots = [];
phase_plots = [];

for iter = 1:length(measurements)
	subplot(2, 1, 1);

	gain_plot = loglog(...
		measurements{iter}.frequency, ...
		measurements{iter}.gain, ...
		'LineWidth', 1, ...
		'Color', measurements{iter}.colour, ...
		'DisplayName', measurements{iter}.label_for_legend ...
	);

	hold on;
	grid on;

	subplot(2, 1, 2);

	phase_plot = semilogx(...
		measurements{iter}.frequency, ...
		measurements{iter}.phase, ...
		'LineWidth', 1, ...
		'Color', measurements{iter}.colour, ...
		'DisplayName', measurements{iter}.label_for_legend ...
	);

	hold on;
	grid on;

	if (length(gain_plots) == 0) | (~any(strcmp(gain_plots.get('DisplayName'), measurements{iter}.label_for_legend)))
		gain_plots = [gain_plots, gain_plot];
	end

	if (length(phase_plots) == 0) | (~any(strcmp(phase_plots.get('DisplayName'), measurements{iter}.label_for_legend)))
		phase_plots = [phase_plots, phase_plot];
	end

	[gain_formula, phase_formula, complex_impedance_formula, fit_params, fit_output] = curve_fit(...
		measurements{iter}.frequency, ...
		measurements{iter}.impedance, ...
		start_points, ...
		lower_bounds, ...
		upper_bounds ...
	);

	measurements{iter}.fitting_formula = complex_impedance_formula;
	measurements{iter}.fit_params = fit_params;
	measurements{iter}.fitting_mre = mean_relative_error(measurements{iter}.impedance, complex_impedance_formula);

	subplot(2, 1, 1);

	loglog(...
		measurements{iter}.frequency, ...
		gain_formula, ...
		'--', ...
		'LineWidth', 2, ...
		'Color', measurements{iter}.colour ...
	);

	hold on;
	grid on;

	subplot(2, 1, 2);

	semilogx(...
		measurements{iter}.frequency, ...
		phase_formula, ...
		'--', ...
		'LineWidth', 2, ...
		'Color', measurements{iter}.colour ...
	);

	hold on;
	grid on;
end

subplot(2, 1, 1);

xlabel('$f$ (Hz)');
ylabel('$|Z|$ ($\Omega$)');

legend(gain_plots);

subplot(2, 1, 2);

xlabel('$f$ (Hz)');
ylabel('$\angle Z$ (deg)');

legend(phase_plots);

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);

print(fig, 'bode_plots_with_fitting', '-dpdf','-r600');
print(fig, 'bode_plots_with_fitting','-dpng','-r600');
savefig(fig, 'bode_plots_with_fitting');

compute_stats;
