#Load Libraries
library(shiny)
library(datasets)

#Create a new variable to hold the dataset
mpgData <- mtcars

#Modify dataframe
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
mpgData$cyl<-as.factor(mpgData$cyl)
mpgData$gear<-as.factor(mpgData$gear)
mpgData$carb<-as.factor(mpgData$carb)
mpgData$vs<-as.factor(mpgData$vs)

#Define a server for the Shiny app
shinyServer(function(input, output) {

        #Get all the checked values separated by + (example cyl+hp), if nothing is checked make it 1
        checkedVal <- reactive({
                perm.vector <- as.vector(input$checkGroup)
                predForm<-ifelse(length(perm.vector)>0,
                       predictors<-paste(perm.vector,collapse="+"),
                       "1")
                lmForm<-paste("mpg~",predForm,sep="") 
                
        }) 
        
        fitModel<-reactive({
                fitFormula<-as.formula(checkedVal())
                lm(fitFormula,data=mpgData)
        })
        
        output$caption <- renderText({
               checkedVal()
        })
        
        #Print the coeffecients of the regression model
        output$fit <- renderPrint({
                summary(fitModel())$coef
        })
        
        #Plot Diagnostics for the generated regression model
        output$mpgPlot<-renderPlot({
                par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
                plot(fitModel(),sub.caption="Diagnostic Plots")
      
        })
})
