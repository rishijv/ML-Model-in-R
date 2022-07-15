library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(randomForest)

# Read data
VGData <- read.csv('B:/Random Coding Stuff/ML-Model-in-R/vgsales.csv')
VG2Data<- do.call(rbind, Map(data.frame, Platform=VGData$Platform, Genre=VGData$Genre, Publisher=VGData$Publisher, Global_Sales=VGData$Global_Sales))

Things <- read.csv('B:/Random Coding Stuff/ML-Model-in-R/Book1.csv')
View(Things)

# Read in the RF model
model <- readRDS("model.rds")

####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("united"),
                
                # Page header
                headerPanel('Test'),
                
                # Input values
                sidebarPanel(
                  HTML("<h3>Input parameters</h3>"),
                  
                  selectInput("Platform", label = "Platform:", 
                              choices = Things$Platform),
                  selectInput("Genre", "Genre:",
                                choices = Things$Genre, 
                                selected = NULL),
                  selectInput("Publisher", "Publisher:",
                                choices = Things$Publisher, 
                                selected = NULL),
                  actionButton("submitbutton", "Submit", class = "btn btn-primary")
                ),
                
                mainPanel(
                  tags$label(h3('Status/Output')), # Status/Output Text Box
                  verbatimTextOutput('contents'),
                  tableOutput('tabledata') # Prediction results table
                  
                )
)

####################################
# Server                           #
####################################

server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    newdf <- data.frame(
      Platform=input$Platform,
      Genre=input$Genre,
      Publisher=input$Publisher,
      play=predict(model,newdf))
    
    Output <- data.frame(Prediction=predict(model,newdf), round(predict(model,newdf,type="prob"), 3))
    
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput())
    } 
  })
  
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
