function [B,W,obj,k] = get_weights(V, B, max_iter)


    [h_V, w_V] = size(V);
    [h_B, w_B] = size(B);

    W = randi(5, w_B, w_V);
    W = W./sum(W);

    obj = compute_objective(V, B, W);

    k = 1;
    for k = 1:max_iter

        bw = B*W;
        W = W.*(((B'*(V ./ (bw + eps)))'./sum(B)))';

        new_obj = compute_objective(V, B, W);
        obj_diff = abs(obj - new_obj);


        if abs(obj - new_obj) < .001
        
            obj = new_obj;
            break
    
        end

        obj = new_obj;

    end

end