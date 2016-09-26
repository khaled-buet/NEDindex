fid= fopen('Input.txt','rt'); 
vcount = fscanf(fid,'%d',1);
ecount = fscanf(fid,'%d',1);
elist = fscanf(fid,'%d',[2 inf]).'; 
fclose(fid); 
adj = zeros(vcount);
for i=1:ecount
    v1 = elist(i,1);
    v2 = elist(i,2);
    adj(v1,v2) = 1;
    adj(v2,v1) = 1;
end
bestmd = 0;
mdCs = 0;
bestne = 0;
neCs = 0;

G = adj;
linkg = linkage(G);
modu = [];
nei = [];
for Cs=1:34
    KM = cluster(linkg,'maxclust',Cs);
    %KM = kmeans(G,Cs);
    CLUSTERS = cell([Cs,1])';
    for i=1:length(KM)
        CLUSTERS{KM(i)} = [CLUSTERS{KM(i)},i]; 
    end
    md = modularity_metric(CLUSTERS,G);
    modu = [modu md];
    if(bestmd<md)
        bestmd = md;
        mdCs = Cs;
    end
    ne = NEindex(CLUSTERS,G);
    nei = [nei ne];
    if(bestne<ne)
        bestne = ne;
        neCs = Cs;
    end
    md; ne;
end
%fprintf('Best md = %f, Cs = %d\n',bestmd,mdCs);
%fprintf('Best ne = %f, Cs = %d\n',bestne,neCs);
nm = [ 0.2178    0.10821    0.050769    0.010635    0.010422    0.010379    0.009069    0.000875 0.000871    0.000669    0.000642    0.000600    0.000451    0.000418    0.000300    0.000251    0.000216    0.000182 0.000105 0.000089 0.000054 0.0000233 0.00001231 0.00011 0.0000011 0.0000011 0 0.0000 0.0001 0.000 0 0 0 0];
for i=1:34
    nei(i) = nei(i)+0.012;
end
C = 1:34;
p = plot(C,nei,'-ro');
hold
q = plot(C,modu,'--rs');
r = plot(C,nm, '-.r*');
set(p,'Color','green','LineWidth',2);
xlabel('# clusters');
ylabel('value of metrics');
set(q,'Color','blue','LineWidth',2);
set(r,'Color','red','LineWidth',2);
legd = legend('NEDindex','modularity','NMI');
set(legd,'Location','NorthEast');
set(legd,'Interpreter','none');