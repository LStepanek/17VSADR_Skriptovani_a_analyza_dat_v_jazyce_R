###############################################################################
###############################################################################
###############################################################################

library("shiny")


## uživatelské rozhraní -------------------------------------------------------

ui <- fluidPage(
    
    # "nadpis" aplikace -------------------------------------------------------
    
    titlePanel("Zobrazení histogramu"),
    
    sidebarLayout(
        
        # ovládací prvky aplikace (vstupy; levý panel) ------------------------
        
        sidebarPanel(
            
            sliderInput(
                inputId = "my_slider",
                label = "Sem vložte počet intervalů histogramu",
                min = 10,
                max = 80,
                value = 20,
                step = 1
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            plotOutput(outputId = "my_histogram")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    output$my_histogram <- renderPlot({
        
        set.seed(1)
        x <- rnorm(1000)
        
        hist(
            x,
            breaks = input$my_slider,
            xlim = c(-4, 4),
            col = "lightgrey",
            main = "",
            xlab = expression(italic("x")),
            ylab = "absolutní četnost"
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





