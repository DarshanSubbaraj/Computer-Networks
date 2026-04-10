NodeColor = 30;
BorderThickness = 8;
NodeDiameter = 25;
WindowIndex = 1;

ListOfNodes = 1:NumberOfNodes;

[ColoredGraph, tmp] = NL_G_HighlightNodes(TopologyGraph, ...
    ListOfNodes, NodeColor, BorderThickness, NodeDiameter, WindowIndex);

EdgeColor = 5;
EdgeWidth = 4;
WindowIndex = 2;

ListOfEdges = 1:length(ColoredGraph.head);

[ColoredGraph, tmp] = NL_G_HighlightEdges(ColoredGraph, ...
    ListOfEdges, EdgeColor, EdgeWidth, WindowIndex);

WindowIndex = 3;
NL_G_ShowGraph(ColoredGraph, WindowIndex);
xtitle("Hybrid Topology (Colored)", "X", "Y");

WindowIndex = 4;
NL_G_ShowGraphNE(TopologyGraph, WindowIndex);
xtitle("Hybrid Topology (Node & Edge Numbers)", "X", "Y");
