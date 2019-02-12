function meansequence = multivariate_dba(sequences)
    n = size(sequences, 1);
    tps = size(sequences, 2);
    textures = size(sequences, 3);

    meansequence = reshape(sequences(medoidIndex(sequences), :, :), tps, textures);
    for j = 1:n
        Y = reshape(sequences(j, :, :), tps, textures);
        [~, ~, iy] = dtw(meansequence', Y');
        meansequence = meansequence + Y(iy, :);
    end
    meansequence = meansequence ./ n;
end

function index = medoidIndex(sequences)
    tps = size(sequences, 2);
    textures = size(sequences, 3);

	index = -1;
    lowestInertia = Inf;
	for i=1:size(sequences, 1)
        tmpInertia = sumOfSquares(reshape(sequences(i, :, :), tps, textures), sequences);
        if (tmpInertia < lowestInertia)
            index = i;
            lowestInertia = tmpInertia;
        end
    end
end

function sos = sumOfSquares(s,sequences)
    tps = size(sequences, 2);
    textures = size(sequences, 3);

    sos = 0.0;
    for i=1:size(sequences, 1)
        dist = dtw(s', reshape(sequences(i, :, :), tps, textures)');
        sos = sos + dist * dist;
    end
end