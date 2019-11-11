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
            ),
            
            numericInput(
                inputId = "my_angle",
                label = "Sem vložte hodnotu úhlu šrafování",
                min = 10,
                max = 80,
                value = 45,
            ),
            
            selectInput(
                inputId = "my_colour",
                label = "Vyberte barvu histogramu",
                choices = c(
                    "šedá" = "grey",
                    "zelená" = "green",
                    "červená" = "red"
                ),
                selected = "šedá",
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
            col = input$my_colour,
            main = "",
            xlab = expression(italic("x")),
            ylab = "absolutní četnost",
            density = 15,
            angle = input$my_angle
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





