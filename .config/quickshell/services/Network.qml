pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

/**
 * Simple polled network state service.
 */
Singleton {
    id: root

    property string networkManager: ""

    property bool wifi: true
    property bool ethernet: false
    property int updateInterval: 1000
    property string networkName: ""
    property int networkStrength
    property string materialSymbol: ethernet ? "lan" : (Network.networkName.length > 0 && Network.networkName != "lo") ? (Network.networkStrength > 80 ? "signal_wifi_4_bar" : Network.networkStrength > 60 ? "network_wifi_3_bar" : Network.networkStrength > 40 ? "network_wifi_2_bar" : Network.networkStrength > 20 ? "network_wifi_1_bar" : "signal_wifi_0_bar") : "signal_wifi_off"

    function update() {
        updateNetworkName.running = true;
        updateNetworkStrength.running = true;
    }

    // Process {
    //     id: networkHandler
    //     command: ["bash", "-c", '[ -n "$(pgrep NetworkManager)" ] && echo "nmcli" || echo "connmanctl"']
    //     running: true
    //     stdout: SplitParser {
    //         onRead: data => {
    //             root.networkManager = data;
    //         }
    //     }
    // }

    Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            root.update();
            interval = root.updateInterval;
        }
    }

    Process {
        id: updateNetworkName
        command: ["bash", "-c", "connmanctl services | grep -E '\*A[OR]' | awk '{print $2}' | head -n 1"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.networkName = data;

                root.ethernet = data.startsWith("ethernet");
                root.wifi = !root.ethernet;
            }
        }
    }

    Process {
        id: updateNetworkStrength
        running: true
        command: ["bash", "-c", "connmanctl services $(connmanctl services | grep '\*' | awk '{print $NF}' | head -n 1) | grep Strength | awk '{print $3}'"]
        stdout: SplitParser {
            onRead: data => {
                root.networkStrength = parseInt(data);
            }
        }
    }
}
