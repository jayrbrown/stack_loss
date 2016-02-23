
# Plant Efficiency Simulator
# Jay Brown
# Assignment for Developing Data Products course.
# Shiny UI file

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Plant Efficiency Simulator"),

  # Sidebar with a slider inputs
  sidebarLayout(
    sidebarPanel(
      helpText("Adjust input values to predict what the new stack loss value would be."),
        sliderInput("Air.Flow",
                  label = "Air Flow:",
                  min = 50,
                  max = 100,
                  value = 58)
        ,
        sliderInput("Water.Temp",
                    label = "Water Temp:",
                    min = 15,
                    max = 30,
                    value = 20)
        ,
        sliderInput("Acid.Conc.",
                     label = "Acid Conc.:",
                      min = 70,
                      max = 100,
                      value = 87)
        ),

    # Show the input values and prediction
    mainPanel(
        tabsetPanel(
            tabPanel("Result",
                     p("Stack loss represents an inverse measure of the overall efficiency of the plant."),
                     tags$head(tags$link(rel="stylesheet", type="text/css", href="stackloss.css")),
                     tags$table(
                         tags$tr(),
                         tags$td( plotOutput("densAir", width=200, height=100) ),
                         tags$td( h3( "Predicted stack loss: " ) ),
                         tags$tr(),
                         tags$td( plotOutput("densWater", width=200, height=100) ),
                         tags$td( h2( textOutput("predLoss") ) ),
                         tags$tr(),
                         tags$td( plotOutput("densAcid", width=200, height=100) )
                     )
                ),
            tabPanel("Background",
                     h3("Oxidation of Ammonia to Nitric Acid"),
                     p("Nitric Acid is a chemical compound used primarily in fertilizers. It is produced in large quantities and typically used immediately in a production process onsite as opposed to transporting it."),
                     p("The manufacturing process heats air and mixes it with ammonia and passes it through absorption towers where nitric acid is collected."),
                     tags$ul(
                         tags$li("Stack Loss refers to a measure that is 10 times the percentage of the ingoing ammonia to the plant that escapes from the absorption column unabsorbed."),
                         tags$li("Air Flow represents the flow of cooling air."),
                         tags$li("Water Temp is the temperature of cooling water circulated through coils in the absorption tower."),
                         tags$li("Acid Conc. is the concentration of the acid circulating, minus 50, times 10: that is, 89 corresponds to 58.9 per cent acid.")
                     )

                ),
            tabPanel("Source",
                     h3("Data Source"),
                     p("Data used to create the regression model is the stackloss dataset from the R stats package."),
                     p("Obtained from 21 days of operation of a plant for the oxidation of ammonia (NH3) to nitric acid (HNO3). The nitric oxides produced are absorbed in a countercurrent absorption tower. (Brownlee, cited by Dodge, slightly reformatted by MM.) "),
                     p("Brownlee, K. A. (1960, 2nd ed. 1965) Statistical Theory and Methodology in Science and Engineering. New York: Wiley. pp. 491–500.")
            ),
            tabPanel("Data",
                     p("The complete dataset 'stackloss'."),
                     dataTableOutput( "dfprint" )
                    )
        )
    )
)
))
