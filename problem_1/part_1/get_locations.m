function [loc] = get_locations(normdot, k_clusters, num_top)
    rng(1);
    [a,b] = size(normdot);
    %figure()
    %surf(1:b, 1:a, normdot)
    %title(graph_title)
    

    [B, I] = max(normdot);
    [topk, idx_k] = maxk(B, num_top);
    idx = kmeans(idx_k', k_clusters);


    loc = zeros(k_clusters, 3);
    for i = 1:k_clusters

        indices = find(idx == i);
        ith_cluster = idx_k(indices);
        ith_cluster = rmoutliers(ith_cluster);
        peak_idx_col = ith_cluster(1);
        peak_idx_row = I(peak_idx_col);
        loc(i, :) = [peak_idx_row, peak_idx_col, normdot(peak_idx_row, peak_idx_col)];


    end
    


end
