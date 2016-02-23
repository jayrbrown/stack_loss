
# Plant Efficiency Simulator
# Jay Brown
# Assignment for Developing Data Products course.
# Shiny server file

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    data(stackloss)
    fit <- lm(stack.loss ~ ., data=stackloss)

    pred <- reactive({
        af <- input$Air.Flow
        wt <- input$Water.Temp
        ac <- input$Acid.Conc.
        nd <- data.frame("Air.Flow"=af, "Water.Temp"=wt, "Acid.Conc."=ac)
        predict(fit, newdata=nd)
    })

    output$predLoss <- renderText({
        round(as.numeric(pred()))
    })

    output$densAir <- renderPlot({
        # density plot with line at selection
        dens <- ggplot(df, aes(Air.Flow)) +
            geom_density(fill="steelblue", colour=NA, alpha=0.2) +
            geom_line(stat="density") +
            geom_vline(xintercept=input$Air.Flow, colour="red") +
            theme_bw() +
            theme(panel.grid.major=element_blank(),
                  panel.grid.minor=element_blank()) +
            theme(axis.text.y=element_blank(),
                  axis.ticks.y=element_blank(),
                  axis.title.y=element_blank(),
                  axis.line=element_blank(),
                  panel.border=element_blank())
        return(dens)
    })
    output$densWater <- renderPlot({
        # density plot with line at selection
        dens <- ggplot(df, aes(Water.Temp)) +
            geom_density(fill="orange", colour=NA, alpha=0.2) +
            geom_line(stat="density") +
            geom_vline(xintercept=input$Water.Temp, colour="red") +
            theme_bw() +
            theme(panel.grid.major=element_blank(),
                  panel.grid.minor=element_blank()) +
            theme(axis.text.y=element_blank(),
                  axis.ticks.y=element_blank(),
                  axis.title.y=element_blank(),
                  axis.line=element_blank(),
                  panel.border=element_blank())
        return(dens)
    })
    output$densAcid <- renderPlot({
        # density plot with line at selection
        dens <- ggplot(df, aes(Acid.Conc.)) +
            geom_density(fill="green", colour=NA, alpha=0.2) +
            geom_line(stat="density") +
            geom_vline(xintercept=input$Acid.Conc., colour="red") +
            theme_bw() +
            theme(panel.grid.major=element_blank(),
                  panel.grid.minor=element_blank()) +
            theme(axis.text.y=element_blank(),
                  axis.ticks.y=element_blank(),
                  axis.title.y=element_blank(),
                  axis.line=element_blank(),
                  panel.border=element_blank())
        return(dens)
    })
    output$dfprint <- renderDataTable({
        stackloss
    })

})
