clear;
clc;

NameOfNetwork = "Hybrid Topology (Bus + Ring + Star)";
NumberOfNodes = 25;

BusStart = [1 2 3 4 5 6 7 8 9];
BusEnd   = [2 3 4 5 6 7 8 9 10];

RingStart = [11 12 13 14 15 16 17 18];
RingEnd   = [12 13 14 15 16 17 18 11];

StarStart = [19 19 19 19 19 19];
StarEnd   = [20 21 22 23 24 25];

StartingNodes = [BusStart RingStart StarStart];
EndingNodes   = [BusEnd   RingEnd   StarEnd];

X_bus = [100 200 300 400 500 600 700 800 900 1000];
Y_bus = [300 300 300 300 300 300 300 300 300 300];

X_ring = [300 400 500 600 600 500 400 300];
Y_ring = [600 700 700 600 500 400 400 500];

X_star = [800 700 900 700 900 750 850];
Y_star = [200 100 100 300 300 400 400];

X = [X_bus X_ring X_star];
Y = [Y_bus Y_ring Y_star];

TopologyGraph = NL_G_MakeGraph( ...
    NameOfNetwork, ...
    NumberOfNodes, ...
    StartingNodes, ...
    EndingNodes, ...
    X, Y);

WindowIndex = 1;
NL_G_ShowGraphNE(TopologyGraph, WindowIndex);
xtitle("Hybrid Topology (Bus + Ring + Star)", "X", "Y");

NodeColor = 5;
BorderThickness = 8;
NodeDiameter = 25;

NodesToColor = [1 5 10 15 19 22 25];

WindowIndex = 2;
NL_G_HighlightNodes( ...
    TopologyGraph, ...
    NodesToColor, ...
    NodeColor, ...
    BorderThickness, ...
    NodeDiameter, ...
    WindowIndex);

xtitle("Highlighted Nodes", "X", "Y");

EdgeColor = 3;
EdgeWidth = 4;

EdgesToColor = [1 5 10 15 20];

WindowIndex = 3;
NL_G_HighlightEdges( ...
    TopologyGraph, ...
    EdgesToColor, ...
    EdgeColor, ...
    EdgeWidth, ...
    WindowIndex);

xtitle("Highlighted Edges", "X", "Y");

[nNodes, nEdges] = NL_G_GraphSize(TopologyGraph);

disp("Total Nodes = ", nNodes);
disp("Total Edges = ", nEdges);

maxEdges = 0;
maxNode = 0;

for i = 1:nNodes
    edgesOfNode = NL_G_EdgesOfNode(TopologyGraph, i);
    count = length(edgesOfNode);

    disp("Node " + string(i) + " has edges = ", count);

    if count > maxEdges then
        maxEdges = count;
        maxNode = i;
    end
end

disp("Node with maximum edges = ", maxNode);
disp("Maximum number of edges = ", maxEdges);
