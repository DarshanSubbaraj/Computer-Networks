#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/netanim-module.h"

using namespace ns3;

int main ()
{
    NodeContainer nodes;
    nodes.Create (25);

    InternetStackHelper internet;
    internet.Install (nodes);

    PointToPointHelper p2p;
    p2p.SetDeviceAttribute ("DataRate", StringValue ("1Mbps"));
    p2p.SetChannelAttribute ("Delay", StringValue ("3ms"));

    for (uint32_t i = 0; i < 25; i++)
    {
        for (uint32_t j = i + 1; j < 25; j++)
        {
            p2p.Install (nodes.Get (i), nodes.Get (j));
        }
    }

    AnimationInterface anim ("mesh.xml");

    Simulator::Run ();
    Simulator::Destroy ();
    return 0;
}
