# Satellite Orbit Simulation and Visualization

## Overview

This MATLAB project simulates the orbits of multiple satellites around Earth using provided orbital elements stored in a JSON file. The project includes a function to evaluate the line of sight between satellites and specific cities during their orbits. It also generates 3D visualizations to illustrate the satellites' paths, their positional relationships, and their visibility from selected observation points on Earth.

## Features

Orbital Simulation: Utilizes data from a JSON file to simulate precise satellite orbits around Earth.
Line of Sight Assessment: Includes a function to determine if satellites are within the line of sight of selected cities, which is useful for planning communications and observation windows.
3D Visualizations: Creates detailed 3D models of satellite trajectories, providing clear insights into their movement and positional relationships relative to Earth and selected observation points.

## File Descriptions

### example_constellation.json:
A JSON file containing the orbital elements for each satellite in the simulation. This file should include parameters such as semi-major axis, eccentricity, inclination, RAAN, argument of periapsis, and true anomaly for each satellite.

### loadConstellation.m:
A MATLAB function that reads the example_constellation.json file and loads the satellite orbital elements into the workspace.

### propagateState.m:
This function calculates the satellites' positions over time based on their orbital elements, simulating their orbits around Earth.

### Runner.m:
The main script that runs the entire simulation. It calls the necessary functions to load satellite data, propagate their states, and assess visibility from selected cities.

### testLoS.m:
A test script to verify the line of sight functionality, ensuring that the function correctly evaluates if a satellite is visible from a city at any given time.

### world_coastline_low.txt:
A data file containing simplified global coastline coordinates, used to plot the Earth's surface in 3D visualizations. This enhances the realism of the satellite trajectory visualizations by showing the Earth’s surface and the relative position of satellites during their orbits.

## Requirements

The simulation was run on MATLAB R2023b.
