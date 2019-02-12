function [ids, J] = mvkmeans(signals, k, itmax, replicates)
    [no_subjects, ~, ~] = size(signals); %NxTimexText

    Js = zeros(1, replicates);
    idss = zeros(no_subjects, replicates);
    disss = zeros(no_subjects, replicates);
    for rep=1:replicates
        [idss(:, rep), Js(rep), disss(:, rep)] = runmvkmeansonce(...
            signals, k, itmax);
    end
    
    [~, id] = min(Js);
    
    J = Js(id);
    ids = idss(:, id);
end

function [ids, J, diss] = runmvkmeansonce(signals, k, itmax)
    [no_subjects, ~, ~] = size(signals); %NxTimexText
    
    ids = zeros(no_subjects, 1);
    
    init_cluster_idxs = initialize_kmeansplusplus(signals, k);
    
    clusters = signals(init_cluster_idxs, :, :);
    
    it = 0;
    J = Inf;
    current_k = k;
    while 1
        if it >= itmax
            break
        end

        dissimilarity = zeros(no_subjects, current_k);
        for cluster_id = 1:current_k
            dissimilarity(:, cluster_id) = compute_dtw_mv_normalised(...
                clusters(cluster_id, :, :), signals);
        end

        Jnew = sum(min(dissimilarity, [], 2)); %use as stopping criteria
        
        if sign(Jnew-J) >= 0
            break
        end
        
        J = Jnew;
        
        [diss, ids] = min(dissimilarity, [], 2);
        
        empty_clusters = [];
        for cluster_id = 1:current_k
            if sum(ids==cluster_id) == 0
                empty_clusters = [empty_clusters, cluster_id];
            else
                clusters(cluster_id, :, :) = mean(signals(ids==cluster_id, :, :), 1);
            end
        end
        
        clusters(empty_clusters, :, :)  = [];
        current_k = current_k - length(empty_clusters);
        
        it = it + 1;
    end
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
