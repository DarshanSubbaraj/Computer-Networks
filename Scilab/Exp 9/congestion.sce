clc;
clear;
close;

// Generate random network
function adj = generate_random_network(n)
    adj = zeros(n, n);
    for i = 1:n
        for j = i+1:n
            if rand() > 0.8 then
                adj(i, j) = 1;
                adj(j, i) = 1;
            end
        end
    end
endfunction

// ARC-based congestion simulation
function t = ARC_time(adj)
    n = size(adj, 1);
    load = rand(1, n) * 100;
    capacity = 50 * ones(1, n);
    alpha = 0.2;

    tic();
    for iter = 1:20
        for i = 1:n
            if load(i) > capacity(i) then
                load(i) = load(i) * (1 - alpha);
            else
                load(i) = load(i) + alpha * 5;
            end
        end
    end
    t = toc();
endfunction

// Part 1: 200 vs 300 nodes
disp("Running Part 1...");
adj200 = generate_random_network(200);
adj300 = generate_random_network(300);

time200 = ARC_time(adj200);
time300 = ARC_time(adj300);

scf(1);
clf();
bar([1 2], [time200 time300]);
xtitle("Congestion Time (200 vs 300 Nodes)", "Network Size", "Time (seconds)");

a = gca();
a.x_ticks = tlist(["ticks", "locations", "labels"], [1 2], ["200", "300"]);

// Part 2: Reduction from 500 nodes
disp("Running Part 2...");
sizes = [500 400 300 200 100];
times = [];

adj500 = generate_random_network(500);

for i = 1:length(sizes)
    n = sizes(i);
    adj_reduced = adj500(1:n, 1:n);
    t = ARC_time(adj_reduced);
    times = [times t];
end

scf(2);
clf();
plot(sizes, times, '-o');
xtitle("Congestion Time for Different Node Sizes",
        "Number of Nodes",
        "Time (seconds)");

disp("Program Completed Successfully!");