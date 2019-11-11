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
                label = "Určete počet hodnot ve výběru",
                min = 100,
                max = 1000,
                value = 200,
                step = 10
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            plotOutput(outputId = "my_histogram"),
            verbatimTextOutput(outputId = "my_table")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    my_x <- reactive({
        
        x <- rnorm(input$my_slider)
        
    })
    
    output$my_histogram <- renderPlot({
        
        hist(
            my_x(),
            xlim = c(-4, 4),
            col = "lightgrey",
            main = "",
            xlab = expression(italic("x")),
            ylab = "absolutní četnost"
        )
        
    })
    
    output$my_table <- renderPrint({
        
        summary(my_x())
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





