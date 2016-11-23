%% BackPropagate: Backpropagate the output through the network and adjust weights and biases
function weightCell = BackPropagate(rate, in, realOutput, sampleTarget, layer, weightCell, layerOutputCells)
    layerCount = size(layer, 2);
    delta = cell(1, layerCount);
    D_weight = cell(1, layerCount);
    %---From Output layer, it has different formula
    output = layerOutputCells{layerCount};
    delta{layerCount} = output .* (1-output^2) .* (sampleTarget - output);
    preoutput = layerOutputCells{layerCount-1};
    D_weight{layerCount} = rate .* preoutput' * delta{layerCount};
    %---Back propagate for Hidden layers
    for layerIndex = layerCount-1:-1:1
        output = layerOutputCells{layerIndex};
        if layerIndex == 1
            preoutput = in;
        else
            preoutput = layerOutputCells{layerIndex-1};
        end
        weight = weightCell{layerIndex+1};
        sumup = (weight * delta{layerIndex+1}')';
        delta{layerIndex} = output .* (1 - output) .* sumup;
        D_weight{layerIndex} = rate .* preoutput' * delta{layerIndex};
    end
    %---Update weightCell
    for layerIndex = 1:layerCount
        weightCell{layerIndex} = weightCell{layerIndex} + D_weight{layerIndex};
    end
end