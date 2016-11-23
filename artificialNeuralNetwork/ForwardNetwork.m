%% ForwardNetwork: Compute feed forward neural network, Return the output and output of each neuron in each layer
function [realOutput, layerOutputCells] = ForwardNetwork(in, layer, weightCell)
    layerCount = size(layer, 2);
    layerOutputCells = cell(1, layerCount);
    out = in;
    for layerIndex = 1:layerCount
        X = out;
        %bias = biasCell{layerIndex};
        if layerIndex == layerCount
            out = linearActivator(X * weightCell{layerIndex});
        else
            out = sigmoidActivator(X * weightCell{layerIndex});
        end
        layerOutputCells{layerIndex} = out;
    end
    realOutput = out;    
end