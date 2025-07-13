#!/bin/bash
set -e

echo "🔁 Cleaning up old screen sessions..."
pkill screen || true

echo "📂 Creating logs directory..."
mkdir -p logs

echo "🚀 Starting Nexus CLI nodes..."

nodes=(
    6633931
    6694030
    7043877
    7538118
    7377559
    7897705
    7842319
    7830090
    7565618
    14629480
    13332269
    13156545
    8161206
)

for node in "${nodes[@]}"; do
    session="nexusnode_$node"
    echo "🟢 Launching node $node in session $session..."
    screen -L -Logfile "logs/$session.log" -dmS "$session" bash -c "./nexus-cli start --node-id $node"
done

echo "🌐 Keeping Gitpod alive on port 8080..."
while true; do nc -lkp 8080 -e echo "🔄 Nexus CLI running..."; done
