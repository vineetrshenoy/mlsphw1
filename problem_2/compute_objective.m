function [obj] = compute_objective(V, B, W) 

    
    [r,c] = size(V);
    bw = B*W;

    %First Term
    first_term = V.*log((V + eps)./(bw + eps));
    first_sum = sum(sum(first_term));

    %Second Term
    second_sum = sum(sum(V));

    %Third Term

    third_sum = sum(sum(bw));

    obj = first_sum + second_sum - third_sum;


end