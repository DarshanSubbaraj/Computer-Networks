#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/netanim-module.h"

using namespace ns3;

int main ()
{
    NodeContainer nodes;
    nodes.Create (20);

    InternetStackHelper internet;
    internet.Install (nodes);

    PointToPointHelper p2p;
    p2p.SetDeviceAttribute ("DataRate", StringValue ("5Mbps"));
    p2p.SetChannelAttribute ("Delay", StringValue ("2ms"));

    for (uint32_t i = 0; i < 19; i++)
    {
        p2p.Install (nodes.Get (i), nodes.Get (i + 1));
    }

    p2p.Install (nodes.Get (19), nodes.Get (0));

    AnimationInterface anim ("ring.xml");

    Simulator::Run ();
    Simulator::Destroy ();
    return 0;
}
