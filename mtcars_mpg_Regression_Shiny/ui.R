#Load Libraries
library(shiny)
library(datasets)
library(dplyr)

# Define UI for miles per gallon application
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Linear Regression of Miles/Gallon(mpg) with One or More Predictors"),
        
        # Sidebar with controls to select the variable to plot against
        # mpg and to specify whether outliers should be included
        sidebarLayout(
                sidebarPanel(
                        checkboxGroupInput("checkGroup", 
                                           label = h3("Predictor/s"), 
                                           choices=names(select(mtcars,-mpg)),
                                           selected = "cyl"
                                           ),
                        width=3
                ),
                

                mainPanel(
                        h4(textOutput("caption")),
                        verbatimTextOutput("fit"),
                        plotOutput("mpgPlot")
                )
        )
))

