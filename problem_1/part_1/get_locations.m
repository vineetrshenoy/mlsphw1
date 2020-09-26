function [] = get_locations(normdot, graph_title, k_clusters)
    
    [a,b] = size(normdot);
    figure()
    surf(1:b, 1:a, normdot)
    title(graph_title)
    

    [B, I] = max(normdot);
    [J, C] = maxk(B, 30);
    idx = kmeans(C, k_clusters);


end
