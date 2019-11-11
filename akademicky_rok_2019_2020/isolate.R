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
            ),
            
            actionButton(
                inputId = "go_button",
                label = "Přepočítej!"
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
        
        input$go_button
        
        x <- isolate(
            rnorm(input$my_slider)
        )
        
        hist(
            x,
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





