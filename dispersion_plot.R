# DESCRIPTION ############################################################
# This function generates a two dimensional plot useful for data points 
# depicting a distance from a particular source. For instance, lets think
# of points depicting stations in which a particular air pollutant is 
# measured, at different distances from a pollutant source, such as a 
# factory. The generated plot # situates the inputted points so that the 
# distance from this point to the # center of the plot (the vector module) 
# relate with the real distance between each point (e.g.# a sampling station) 
# and the source (e.g. a factory). One can also define # a particular 
# variable (e.g. the concentration of the pollutant) in order to plot the 
# points with a color range (also customizable).
#
# ARGUMENTS ##############################################################
# dist     = a numeric vector with the distance values
# variable = a numeric vector with a particular value, whose values will
#            be used to plot points in a color range
# type = "random" or "uniform". Defines the pattern in which points will
#         be plotted. If "uniform" is selected, points will be plotted
#         following a uniform pattern determined by the angle defined
#         in angle_diff
# angle_diff = the angle (in radians) that will be used to plot the points 
#              evenly. Only valid when type = "uniform"
# output = 0 to only generate the plot, 1 to generate the plot and return
#          a data.frame from which plot is made, and 2 to only return the
#          mentioned data.frame. data.frame is returned only if the function
#          is assigned to an object
# arguments col, size, alpha, legend_title and axis_name allows to visually 
# customize the plot. If more curtomization is needed, the user can use the
# returned data.frame and generate the plot by its own.
#
# Note: there is no error checking in this function, so errors or warnings
# may appear. Please check the object classes to be inputted in each argument.
dispersion_plot <- function(dist = NULL, variable = NULL, 
                            type = "random", angle_diff = pi/16, 
                            col = c("blue", "red"), size = 2, alpha = 0.5, legend_title = "variable", axis_name = "Distance to source",
                            output = 0)
{
  
  dist <- sort(dist)
  
  if(type == "uniform")
  {
    angles_vec <- rep(NA, 2 * pi / angle_diff)
    angles_vec[1] <- 0
    for(i in 2:(2*pi/angle_diff))
    {
      angles_vec[i] <- angles_vec[i - 1] + angle_diff
    }
  }

  df <- data.frame(x = rep(NA, length(dist)), y = rep(NA, length(dist)), dist = dist)

  a <- 1
  for(i in 1:nrow(df))
  {
    if(type == "random")
    {
      angle <- runif(1, min = 0, max = 2 * pi)
      df$x[i] <- df$dist[i] * cos(angle)
      df$y[i] <- df$dist[i] * sin(angle)
    }
    else
    {
      if(a > length(angles_vec)) a <- 1
      df$x[i] <- df$dist[i] * cos(angles_vec[a])
      df$y[i] <- df$dist[i] * sin(angles_vec[a])
      a <- a + 1
    }
  }
  
  plot <- ggplot(data = df) +
    aes(x = x, y = y) +
    geom_point(alpha = alpha, size = size) +
    geom_vline(xintercept = 0) +
    geom_hline(yintercept = 0) +
    scale_x_continuous(name = axis_name) +
    scale_y_continuous(name = axis_name) +
    theme(panel.background = element_rect(fill = NA),
          panel.grid.major = element_line(colour = "gray", linetype = "dashed", size = 0.3),
          panel.grid.minor = element_line(colour = "gray", linetype = "dashed", size = 0.3),
          aspect.ratio = 1)
  
  if(!is.null(variable))
  {
    plot <- plot + aes(x = x, y = y, col = variable) + 
      scale_colour_gradientn(colours = col, name = legend_title)
  }
  
  if(output == 0)
  {
    plot
  } else if(output == 1)
  {
    plot
    invisible(df)
  } else if(output == 2)
  {
    invisible(df)
  }
}
