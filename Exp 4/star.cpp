#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/internet-module.h"
#include "ns3/netanim-module.h"

using namespace ns3;

int main() {
    NodeContainer hub;
    hub.Create(1);

    NodeContainer spokes;
    spokes.Create(19); // Total = 20 nodes

    InternetStackHelper stack;
    stack.Install(hub);
    stack.Install(spokes);

    PointToPointHelper p2p;
    p2p.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    p2p.SetChannelAttribute("Delay", StringValue("2ms"));

    Ipv4AddressHelper address;

    for (uint32_t i = 0; i < spokes.GetN(); i++) {
        NodeContainer pair(hub.Get(0), spokes.Get(i));
        NetDeviceContainer devices = p2p.Install(pair);

        std::ostringstream subnet;
        subnet << "10.1." << i+1 << ".0";
        address.SetBase(subnet.str().c_str(), "255.255.255.0");
        address.Assign(devices);
    }

    AnimationInterface anim("star.xml");

    anim.SetConstantPosition(hub.Get(0), 50, 50);

    for (uint32_t i = 0; i < spokes.GetN(); i++) {
        anim.SetConstantPosition(spokes.Get(i), 5*i, 10);
    }

    Simulator::Run();
    Simulator::Destroy();
}
