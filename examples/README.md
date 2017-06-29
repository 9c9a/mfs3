# Examples

These scripts are meant to provide examples demonstrating different functions supported by the simulator.


## Scripts
The scripts are grouped in two subfolders according to the type of information presented.

### Architecture
Examples of maps related to the architecture of the satellite communications system, including frequency reuse and ground segment maps.

| Script | Description |
|--------|-------------|
| [`allocation`](architecture/allocation.m) | Interactive allocation of user beam centers across coverage region using optimal cell packing. |
| [`kaband`](architecture/allocation.m) | Generates maps for user beam frequency reuse, beam-to-gateway allocation and gateway ground station locations in Ka band. |
| [`qvband`](architecture/allocation.m) | Generates maps for user beam frequency reuse, beam-to-gateway allocation and gateway ground station locations in Q/V band. |


### Link budget
Examples of maps of different parameters involved in the calculation of the link budget, such as attenuation, interference and carrier-to-noise maps.

| Script | Description |
|--------|-------------|
| [`attenuation`](budget/attenuation.m) | Generates maps for different types of attenuation and propagation losses at specific frequencies. |
| [`forwardLink`](budget/forwardLink.m) | Generates a map of forward link budget parameters such as C/N, C/I and C/IM ratios for different scenarios (clear sky, rain in uplink and rain in downlink). |
| [`interference`](budget/interference.m) | Generates a map of co-channel interference across user beams, using a defined frequency plan and ground segment architecture. |
| [`rainfall`](budget/rainfall.m) | Generates rainfall rate contour maps for a given probability. |
| [`returnLink`](budget/returnLink.m) | Generates a map of return link budget parameters such as C/N and C/IM ratios for different scenarios (clear sky, rain in uplink and rain in downlink). |


## Information tables
**mfs3** uses [tables](https://www.mathworks.com/help/matlab/tables.html) to store the definitions of the ground segment architecture and the frequency reuse plan, including the locations of user beam centers, their allocation to gateway stations and the assigned frequency/polarization.

There are two tables with sample data that are provided as Microsoft Excel Workbooks (*.xlsx):

| Workbook | Description |
|----------|-------------|
| [`beams.xlsx`](examples/beams.xlsx) | User beam information table. Specifies the coordinates of user beam centers, their assigned frequency/polarization and allocated gateway. |
| [`gateways.xlsx`](examples/gateways.xlsx) | Gateway ground station table. Contains the coordinates for gateway ground stations. |