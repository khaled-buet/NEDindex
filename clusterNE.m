function [ NE, c_deg ] = clusterNE( Ci, G )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% C is a cluster in graph G, C is a vector of cluster components and G is adjacency matrix
node = length(Ci);
E_node = node*(node-1)/2;
%disp(E_node);
edge_count = 0;
deg_count = 0;
for i=1:length(Ci)
    for j=i+1:length(Ci)
        if(G(Ci(i),Ci(j)) == 1)
            edge_count = edge_count + 1;
        end
    end
    deg_count = deg_count + degrees(Ci(i),G);
end
c_deg = 2*edge_count;
NE = (node+edge_count+2*edge_count)/(node+E_node+deg_count);
end

