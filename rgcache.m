function [Cout1, Cout2] = rgcache(Cin, L, e)
	vareps = 0.001;
	para.lambda = .15;	% trade-off coefficient (LIME parameter)
	para.sigma = 2;		% sigma for strategy 3 (LIME parameter)
	para.gamma = 1;		% gamma correction on illumination (LIME parameter)
	para.solver = 1;	% 1: sped-up solver; 2: exact solver (LIME parameter)
	para.strategy = 3;	% identifier of strategy (LIME parameter)

	Ain = max(Cin, [], 3);
	[~, ~, I] = LIME(Cin, para);
	R = log10(max(Ain, vareps) ./ max(I, vareps));
	B = cache(Ain, R, L);
	Aout = B + e * R;
	Cout1 = Cin ./ max(Ain, vareps) .* B;
	Cout2 = Cin ./ max(Ain, vareps) .* Aout;
end

function B = cache(Ain, R, L)
	K = 256;
	Phi = GetGradient(R, L);
	p = ContrastAccumulatedHistogram(Ain, Phi, K)';
	p = p / sum(p);
	T = cumsum(p);
	A = uint8(Ain * (K - 1));
	B = reshape(T(A(:) + 1), size(A));
end

function Phi = GetGradient(img, L)
	[H, W] = size(img);
	Phi = DiffRecursive(img, L, H, W);
	Phi = Phi .^ (1 / L);
end

function Phi = DiffRecursive(img, L, H, W)
	fx = diff(img, 1, 2);
	fx0 = padarray(fx, [0 1], 'post');
	fx1 = padarray(fx, [0 1], 'pre');
	fy = diff(img, 1, 1);
	fy0 = padarray(fy, [1 0], 'post');
	fy1 = padarray(fy, [1 0], 'pre');

	Phi = abs(fx0) + abs(fx1) + abs(fy0) + abs(fy1);
	Phi = imresize(Phi, [H W]);
	Phi = max(Phi, 0);

	if L > 1
		img = imresize(img, 0.5);
		G = DiffRecursive(img, L - 1, H, W);
		Phi = Phi .* G;
	end
end
