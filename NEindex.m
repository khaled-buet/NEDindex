function [ nei ] = NEindex( C, G )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% C contains all clusters in cell array. G is the adjacent list of graph.
total_deg = 0;
for i=1:length(C)
    for j=1:length(C{i})
        total_deg = total_deg + degrees(C{i}(j),G);
    end
end

perctg = 1/total_deg;
neC = 0;
for i=1:length(C)
    if(length(C{i})>0)
        [NEI,c_deg] = clusterNE(C{i},G);
        neC = neC + perctg*c_deg*NEI;
    end
end
nei = neC;
end

