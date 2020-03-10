# dispersion_plot
R function that generates a dispersion plots for source-sink data

This function generates a two dimensional plot useful for data points 
depicting a distance from a particular source. For instance, lets think
of points depicting stations in which a particular air pollutant is 
measured, at different distances from a pollutant source, such as a 
factory. The generated plot situates the inputted points so that the 
distance from this point to the center of the plot (the module of the vector) 
relate with the real distance between each point (e.g. a sampling station) 
and the source (e.g. a factory). One can also define a particular 
variable (e.g. the concentration of the pollutant) in order to plot the 
points with a color range (also customizable).

More details can be seen inside the script.

## Examples

data <- data.frame(dist = 1:1000, concentration = 1000:1)

### Random plot pattern
dispersion_plot(dist = data$dist, variable = data$concentration, type = "random")

### With custom colors
dispersion_plot(dist = data$dist, variable = data$concentration, type = "random", col = terrain.colors(5))

### Uniform plot pattern
dispersion_plot(dist = data$dist, variable = data$concentration, type = "uniform")

### Uniform plot pattern with a smaller angle between points
dispersion_plot(dist = data$dist, variable = data$concentration, type = "uniform", angle_diff = pi/32)
