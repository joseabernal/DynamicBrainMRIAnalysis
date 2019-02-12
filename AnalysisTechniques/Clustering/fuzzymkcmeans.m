function [ids, J] = fuzzymkcmeans(signals, k, itmax, replicates, isfuzzy)
    [no_subjects, ~, ~] = size(signals); %NxTimexText

    Js = zeros(1, replicates);
    idss = zeros(no_subjects, replicates);
    for rep=1:replicates
        [idss(:, rep), Js(rep)] = runfuzzymvcmeansonce(signals, k, itmax, isfuzzy);
    end
    
    [~, id] = min(Js);
    
    J = Js(id);
    ids = idss(:, id);
end

function [ids, J] = runfuzzymvcmeansonce(signals, k, itmax, isfuzzy)
    fuzzyness = 1.75-1;

    [no_subjects, ~, ~] = size(signals); %NxTimexText
    
    init_cluster_idxs = initialize_kmeansplusplus(signals, k);
    
    clusters = signals(init_cluster_idxs, :, :);
    
    it = 0;
    U = Inf(no_subjects, k);
    while 1
        if it >= itmax
            break
        end
        
        distances = zeros(no_subjects, k);
        for cluster_id = 1:k
            distances(:, cluster_id) = compute_dtw_mv_normalised(...
                clusters(cluster_id, :, :), signals);
        end
        
        U_new = zeros(no_subjects, k);
        
        if isfuzzy
            for cluster_id = 1:k
                denom = 0;
                for cluster_id2 = 1:k
                    denom = denom + (distances(:, cluster_id) ./ distances(:, cluster_id2)).^(2.0/fuzzyness);
                end
                U_new(:, cluster_id) = 1./denom;
            end
        else
            [~, ids] = min(distances, [], 2);
            for i=1:no_subjects
                U_new(i, ids(i)) = 1;
            end
        end

        U_new(isnan(U_new)) = 0;

        if norm(U-U_new) < 0.01
            break
        end
        
        U = U_new;
        
        for cluster_id = 1:k
            u_col = U(:, cluster_id);
            weighted_signals = signals .* repmat(u_col, [1, size(signals, 2), size(signals, 3)]);
            clusters(cluster_id, :, :) = sum(weighted_signals) / sum(u_col);
        end
                
        it = it + 1;
    end
    [~, ids] = max(U, [], 2);
    J = sum(min(distances, [], 2));
end

function ids = initialize_kmeansplusplus(signals, K)
    [no_subjects, ~, ~] = size(signals); %NxTimexText

    ids = [];
    ids = [ids, randi([1 no_subjects], 1, 1)];
    for k = 1:K-1
        dissimilarity = Inf(no_subjects, 1);
        for ci = 1:length(ids)
            dissimilarity = min(dissimilarity, compute_dtw_mv_normalised(...
                signals(ids(ci), :, :), signals));
        end
        probs = dissimilarity.^2 ./ sum(dissimilarity.^2);
        cumprobs = cumsum(probs);
        
        r = rand(1, 1);
        
        selected_idx = length(cumprobs);
        for idx = 1:length(cumprobs)
            p = cumprobs(idx);
            if r < p
                selected_idx = idx;
                break
            end
        end

        ids = [ids, selected_idx];
    end
end
