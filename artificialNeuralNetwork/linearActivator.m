function [z] = linearActivator(z)
%The linear function
z = purelin(z, z);
end

