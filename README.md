# Equivalent Resistance Calculator (Nodal Analysis)

A MATLAB script that computes the equivalent resistance between two terminals of an arbitrary resistor network, using nodal (admittance matrix) analysis. Several classic network topologies — parallel, series, triangle (bridge-like), and ladder networks — are included as worked examples.

## How it works

Each resistor network is described as a graph:
- **Nodes** — the electrical nodes in the circuit.
- **Edges** — the resistors connecting pairs of nodes, each with a resistance value.
- **Port** — the two nodes across which the equivalent resistance is measured.

The `resistance` function builds the network's admittance (conductance) matrix `Y`, where each resistor of value `r` between nodes `n1` and `n2` contributes `1/r` to the diagonal entries and `-1/r` to the corresponding off-diagonal entries (standard nodal analysis stamping).

To solve for the equivalent resistance, one port node is grounded (its row/column removed from `Y`), a unit test current is injected at the other port node, and the resulting node voltage is solved via `X = A \ R`. Since a unit current was injected, the solved voltage at the port node is numerically equal to the equivalent resistance.

## Usage

Define a network with:
```matlab
nodes = [1; 2; 3];              % list of node indices
edges = [1 2 5; 2 3 10];        % [node1, node2, resistance] per row
port  = [1 3];                  % [terminal1, terminal2]
resistance(nodes, edges, port);
```

Run `EC_project.m` directly in MATLAB to see results for all five example networks:

| Network  | Description                                   |
|----------|------------------------------------------------|
| Parallel | Two resistors (2 Ω, 3 Ω) between the same node pair |
| Series   | Three 1 Ω resistors in a chain                  |
| Triangle | A bridge-like network with mixed 8 Ω / 12 Ω resistors |
| Ladder   | An 8-node resistor ladder network               |
| Star/mesh| A 6-node network with a central hub node        |

Each call prints the reduced admittance matrix and the computed equivalent resistance (rounded to 2 decimal places).

## Requirements

- MATLAB (no additional toolboxes required)

## Notes

- Node indexing is 1-based, matching MATLAB convention.
- The script assumes the network graph is connected between the two port nodes.
