function dist = compute_dtw_mv_normalised(data_i, data)
    n = size(data, 1);
    tps = size(data, 2);
    textures = size(data, 3);
    dist = zeros(n, 1);
    for j=1:n
        dist(j) = norm(reshape(data_i(1, :, :) - data(j, :, :), tps, textures), 'Inf');
    end
    dist = dist / sum(dist);
end