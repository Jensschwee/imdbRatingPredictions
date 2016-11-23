%% ForwardNetwork: Compute feed forward neural network, Return the output and output of each neuron in each layer
function [realOutput, layerOutputCells] = ForwardNetwork(in, layer, weightCell, biasCell)
    layerCount = size(layer, 2);
    layerOutputCells = cell(1, layerCount);
    out = in;
    for layerIndex = 1:layerCount
        X = out;
        %bias = biasCell{layerIndex};
        if(layerCount==layerIndex)
            out = sigmoid(X * weightCell{layerIndex});
        else
            out = sigmoid(X * weightCell{layerIndex});
        end
        layerOutputCells{layerIndex} = out;
    end
    realOutput = out;    
end