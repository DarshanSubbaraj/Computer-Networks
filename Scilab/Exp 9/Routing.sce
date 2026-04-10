clc;
clear;
close;

// Function to create graph
function [cost] = create_graph(n)
    cost = grand(n, n, 'uin', 1, 20); // Random weights
    for i = 1:n
        cost(i, i) = 0;
    end
    for i = 1:n
        for j = i+1:n
            cost(j, i) = cost(i, j);
        end
    end
    for i = 1:n
        for j = 1:n
            if rand() < 0.3 then
                cost(i, j) = %inf; // No connection
            end
        end
    end
endfunction

// Dijkstra Algorithm
function dist = dijkstra(cost, source)
    n = size(cost, 1);
    visited = zeros(1, n);
    dist = ones(1, n) * %inf;
    dist(source) = 0;

    for count = 1:n-1
        min_val = %inf;
        u = -1;

        for i = 1:n
            if visited(i) == 0 & dist(i) < min_val then
                min_val = dist(i);
                u = i;
            end
        end

        if u == -1 then
            break;
        end

        visited(u) = 1;

        for v = 1:n
            if visited(v) == 0 & cost(u, v) <> %inf then
                if dist(u) + cost(u, v) < dist(v) then
                    dist(v) = dist(u) + cost(u, v);
                end
            end
        end
    end
endfunction

// Bellman-Ford Algorithm
function dist = bellman_ford(cost, source)
    n = size(cost, 1);
    dist = ones(1, n) * %inf;
    dist(source) = 0;

    for k = 1:n-1
        for u = 1:n
            for v = 1:n
                if cost(u, v) <> %inf then
                    if dist(u) + cost(u, v) < dist(v) then
                        dist(v) = dist(u) + cost(u, v);
                    end
                end
            end
        end
    end
endfunction

// Main execution
node_sizes = 5:5:100;
dijkstra_time = [];
bellman_time = [];

for n = node_sizes
    cost = create_graph(n);
    source = 1;

    tic();
    dist1 = dijkstra(cost, source);
    t1 = toc();

    tic();
    dist2 = bellman_ford(cost, source);
    t2 = toc();

    dijkstra_time = [dijkstra_time t1];
    bellman_time = [bellman_time t2];

    disp("Nodes: " + string(n) + " | Dijkstra: " + string(t1) + " | Bellman-Ford: " + string(t2));
end

// Plot comparison
figure();
plot(node_sizes, dijkstra_time, '-o');
plot(node_sizes, bellman_time, '-r*');
xlabel("Number of Nodes");
ylabel("Execution Time (seconds)");
title("Routing Algorithm Performance Comparison");
legend("Dijkstra", "Bellman-Ford");

// Graph visualization
cost = create_graph(100);
adj = cost;
adj(adj == %inf) = 0;
g = graph(adj);

figure();
plot(g);
title("Visualization of 100 Node Network");