#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/netanim-module.h"

using namespace ns3;

int main ()
{
    NodeContainer nodes;
    nodes.Create (21);

    InternetStackHelper internet;
    internet.Install (nodes);

    PointToPointHelper p2p;
    p2p.SetDeviceAttribute ("DataRate", StringValue ("2Mbps"));
    p2p.SetChannelAttribute ("Delay", StringValue ("2ms"));

    for (uint32_t i = 1; i < 21; i++)
    {
        p2p.Install (nodes.Get ((i - 1) / 2), nodes.Get (i));
    }

    AnimationInterface anim ("tree.xml");

    Simulator::Run ();
    Simulator::Destroy ();
    return 0;
}
