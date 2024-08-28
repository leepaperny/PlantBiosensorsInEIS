function [gain_formula, phase_formula, fitting_formula, fit_params, fit_output] = curve_fit(frequency, impedance, start_points, lower_bounds, upper_bounds)
	define_helper_functions;

	omega = 2 * pi * frequency;

	objective_function = @(params, freq) [real(randles_model_with_leaky_cap_impedance(params, omega)), imag(randles_model_with_leaky_cap_impedance(params, omega))];

	impedance_real_imag = [real(impedance), imag(impedance)];

	lsq_options = optimset('Display', 'off', 'MaxFunEvals', 1000);
	[fit_params, resnorm, residual, exitflag, fit_output] = lsqcurvefit(objective_function, start_points, frequency, impedance_real_imag, lower_bounds, upper_bounds, lsq_options);

	fitting_formula_real_imag = objective_function(fit_params, omega);
	fitting_formula = fitting_formula_real_imag(:, 1) + j * fitting_formula_real_imag(:, 2);

	gain_formula = abs(fitting_formula);
	phase_formula = rad2deg(angle(fitting_formula));

	% sprintf('R_ct: %g ohm\nC_dl: %g uF\nR_s: %g ohm\nA_W: %g ohm s^0.5\nleaky exponent: %g', fit_params(1), fit_params(2), fit_params(3), fit_params(4), fit_params(5))
end
