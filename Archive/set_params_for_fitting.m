start_points = [
	1e5, ... % R_ct (ohm)
	1e-12 * 1e6, ... % C_dl (uF)
	1e2, ... % R_s (ohm)
	1e6, ... % A_W (ohm s^0.5)
	0.7, ... % leaky exponent
	];

lower_bounds = [
	1e3, ... % R_ct (ohm)
	1e-13 * 1e6, ... % C_dl (uF)
	1e1, ... % R_s (ohm)
	1e4 ... % A_W (ohm s^0.5)
	0.7 ... % leaky exponent
	];

upper_bounds = [
	1e6, ... % R_ct (ohm)
	1e-5 * 1e6, ... % C_dl (uF)
	1e3, ... % R_s (ohm)
	1e9 ... % A_W (ohm s^0.5)
	1, ... % leaky exponent
	];
