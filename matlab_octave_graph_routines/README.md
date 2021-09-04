# Matlab/Octave graph routines
Some common functionalities for working with graphs in Matlab
### Contents: 
- Create a random clusterable (signed/weighted) graph
- Find (the best) clustering of a (signed/weighted) graph using spectral coordinates method

## random_multi_bottleneck_graph.m
Creates the adjacency matrix of a graph that has groups of vertices of sizes N(i) that are connected to each other with some given probablities P(i,j). You can also create weighted or signed graphs.
	
##### Examples 
1. One bottleneck
    ```matlab
	N = [15,25];
	P = [.90,.10; 
		 .10,.85];
	A = random_multi_bottleneck_graph(N,P); 
	spy(A)
	```
![N = [15,25]; 
P = [.90,.10; 
	 .10,.85];](/images/random_multi_bottleneck_simple_graph_ex1.png)
	
2. Three bottlenecks
```matlab
N = [20,15,25];
P = [.90,.10,.10; 
	 .10,.85,.20; 
	 .10,.20,.90];
A = random_multi_bottleneck_graph(N,P); 
spy(A)
```
![N = [20,15,25];
P = [.90,.10,.10; 
	 .10,.85,.20; 
	 .10,.20,.90];](/images/random_multi_bottleneck_simple_graph_ex2.png)

3. Complete connected components
 ```matlab
N = [20,15,25];
P = eye(length(N));
A = random_multi_bottleneck_graph(N,P); 
spy(A)
```
![N = [20,15,25];
P = [1,0,0; 
	 0,1,0; 
	 0,0,1];](/images/random_multi_bottleneck_simple_graph_ex3.png)

You don't have to specify P if you want this.

4. Complete tripartite
```matlab
N = [20,15,25];
P = ones(length(N), length(N)) - eye(length(N));
A = random_multi_bottleneck_graph(N,P); 
spy(A)
```
![N = [20,15,25];
P = [0,1,1; 
	 1,0,1; 
	 1,1,0];](/images/random_multi_bottleneck_simple_graph_ex4.png)

5. Weighted 
```matlab
N = [20,15,25];
P = [.90,.10,.10; 
	 .10,.85,.20; 
	 .10,.20,.90];
A = random_multi_bottleneck_graph(N,P,'weighted',true); 
imagesc(A)
colormap('jet')
caxis([-1,1])
colorbar
```
![weighted](/images/random_multi_bottleneck_simple_graph_ex5.png)

6. Weighted and signed 
```matlab
N = [20,15,25];
P = [.90,.10,.10; 
	 .10,.85,.20; 
	 .10,.20,.90];
A = random_multi_bottleneck_graph(N,P,'weighted',true,'Signed',.5); 
imagesc(A)
colormap('jet')
caxis([-1,1])
colorbar
```
![weighted and signed](/images/random_multi_bottleneck_simple_graph_ex6.png)

You can run the code without any inputs and it will return a graph on 40 vertices with two connected components where the connected components are complete graphs of sizes 10 and 15, respectively.
	
## spectral_coordinate.m
returns the k-dimensional spectral coordinates of a (signed) graph as defined in [1], which then can be used to cluster the vertices.
##### Example
1. First generate a random signed graph that is clusterable, using above, and let's see how good is the known clustering of this graph according to the Girvan-Newman modularity:
```matlab
N = [10,20,30];
P = [.90,.10,.10; 
	 .10,.95,.10; 
	 .10,.10,.90];
A = random_multi_bottleneck_graph(N,P,'weighted',true,'Signed',.1);
str1 = cell(1,size(A,1)); %keeping track of vertex numbers
for j = 1:size(A,1)
	str1{j} = num2str(j);
end
clustering1 = {1:N(1), N(1)+1:sum(N(1:2)), sum(N(1:2)):sum(N) }; % this is the known clustering
q1 = girvan_newman_modularity(A,clustering1) % let's see how good it is
imagesc(A);
caxis([-1,1]);
colormap('jet');
axis square
set(gca,'YTick',1:size(A,1))
set(gca,'YTicklabels',str1)
set(gca,'XTick',1:size(A,1))
set(gca,'XTicklabels',str1)
set(gca,'XTickLabelRotation',90);
```
![a signed graph with some apparent clusters](/images/spectral_coordinate_ex1.png)

It says the signed modularity is `q1 = 0.3904`. Then let's permute it so that it doesn't look as trivial of an example
```matlab
perm = randperm(size(A,1));
B = zeros(size(A));
B = A(perm,perm);
str2 = str1(perm); %keeping track of vertex numbers
imagesc(B);
caxis([-1,1]);
colormap('jet');
axis square
set(gca,'YTick',1:size(A,1))
set(gca,'YTicklabels',str2)
set(gca,'XTick',1:size(A,1))
set(gca,'XTicklabels',str2)
set(gca,'XTickLabelRotation',90);
```
![doesn't look very clusterable any more, does it?](/images/spectral_coordinate_ex2.png)

Then find its spectral coordinates in 3 dimenstions and plot them
```matlab
S = spectral_coordinate(B,3); 
xt = zeros(size(S,1),1);
yt = zeros(size(S,1),1);
zt = zeros(size(S,1),1);
xt(:) = 1.1*S(:,1);
yt(:) = 1.1*S(:,2);
zt(:) = 1.1*S(:,3);

scatter3(S(:,1),S(:,2),S(:,3),'o');
hold on;
text(xt,yt,zt,str2);
[x,y,z] = sphere;
surf(x,y,z,'FaceAlpha',.1);
colormap([0,0,0]);
shading interp
view([-68 -46]);
axis off;
axis equal;
```
![3 dimensional spectral coordinates of the nodes on the unit sphere](/images/spectral_coordinate_ex3.png)

The nodes are very neatly clustered together on the unit sphere. But that's a little bit of cheating as I knew it has 3 clusters. Let's see if it can figure it out on its own
```matlab
[idx, q, sumd] = best_cluster_with_spectral_coordinates(B);
disp([max(idx), q, sumd]);
[~,new_perm] = sort(idx);
```

It says the best it could do is with `max(idx) = 3` clusters. The signed modularity of this clustering that it found is `q = 0.3983` which is marginally better than the actual clustering that we had. Let's permute things with this new clustaring to see how similar it is to the original matrix
```matlab
C = B(new_perm,new_perm);
str3 = str2(new_perm); %keeping track of vertex numbers
imagesc(C);
caxis([-1,1]);
colormap('jet');
axis square
set(gca,'YTick',1:size(A,1))
set(gca,'YTicklabels',str3)
set(gca,'XTick',1:size(A,1))
set(gca,'XTicklabels',str3)
set(gca,'XTickLabelRotation',90);
```

![recovered matrix](/images/spectral_coordinate_ex4.png)

Very nice, indeed! It has recovered everything except for two vertices of the last cluster that are now in the first cluster, but this actually improved the results.

ToDo: 
	[ ] Of course I'm evaluating the eigenvectors several times, and then deleting extra ones. I should put them all together to speed up the process.

[1] L. Wu, X. Wu, A. Lu and Y. Li, 
       "On Spectral Analysis of Signed and Dispute Graphs: Application
       to  Community Structure,"  
       IEEE Transactions on Knowledge and Data Engineering, 
       29, 7, 1480--1493, 2017.
       10.1109/TKDE.2017.2684809
