###############################################################################
###############################################################################
###############################################################################

## loaduju globální proměnné --------------------------------------------------

source("global.R")


## ----------------------------------------------------------------------------

###############################################################################

## loaduju tvary --------------------------------------------------------------

source("patterns.R")


## ----------------------------------------------------------------------------

###############################################################################

## loaduju balíčky ------------------------------------------------------------

library(shiny)


## ----------------------------------------------------------------------------

###############################################################################

## ----------------------------------------------------------------------------

shinyServer(function(input, output){
  
  #############################################################################
  
  ## dynamicky renderované ovládací prvky -------------------------------------
  
  output$covering_percentage_of_board <- renderUI({
    
    if(input$my_pattern == "random_cells"){

      sliderInput(inputId = "my_coverage",
                  label = "Vyberte procento pokrytí mřížky buňkami:",
                  min = 0,
                  max = 100,
                  value = 20)
      
    }
    
  })
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## helper funkce ------------------------------------------------------------
  
  getMyCoordinates <- function(my_board){
    
    # '''
    # vrací list horizontálních a vertikálních souřadnic všech
    # jednotkových buněk v mřížce
    # '''
    
    output <- list("horizontal" = NULL, "vertical" = NULL)
    
    for(i in 1:dim(my_board)[1]){
      for(j in 1:dim(my_board)[2]){
        
        if(my_board[i, j] == 1){
          
          output$vertical <- c(output$vertical, i)
          output$horizontal <- c(output$horizontal, j)

        }
        
      }
    }
    
    return(output)
    
  }
  
  
  ## --------------------------------------------------------------------------
  
  getMyCellNeighborhoodSum <- function(my_board, i, j){
    
    # '''
    # vrací počet živých buněk v okolí buňky o souřadnicích [i, j],
    # tj. dívá se, kolik je živých buněk na pozicích
    # {i - 1, i, i + 1} x {j - 1, j, j + 1} kromě [i, j], pokud tyto
    # pozice existují
    # '''
    
    output <- 0
    
    for(my_x in c(i - 1, i, i + 1)){
      for(my_y in c(j - 1, j, j + 1)){
        
        if(
          
          my_x %in% c(1:dim(my_board)[1]) &
          my_y %in% c(1:dim(my_board)[2])
          
          ){
          
          output <- sum(output, my_board[my_x, my_y])
          
        }
        
      }
    }
    
    output <- output - my_board[i, j]
    
    return(output)
    
  }
  
  
  ## --------------------------------------------------------------------------
  
  updateMyCell <- function(my_board, i, j){
    
    # '''
    # vrací pro buňku na souřadnicích [i, j] mřížky buďto 0, pokud buňka
    # zemře (nebo již mrtvá je), nebo 1, pokud buňka oživne (nebo již
    # živá je);
    # a to podle pravidel:
    #
    #   (i) každá živá buňka s méně než dvěma živými sousedy zemře;
    #  (ii) každá živá buňka se dvěma nebo třemi živými sousedy zůstává žít;
    # (iii) každá živá buňka s více než třemi živými sousedy zemře;
    #  (iv) každá mrtvá buňka s právě třemi živými sousedy oživne
    #
    # '''
    
    output <- my_board[i, j]
    
    if(my_board[i, j] == 1){
      
      if(getMyCellNeighborhoodSum(my_board, i, j) < 2){
        output <- 0
      }                                        ## pravidlo (i)
      
      if(getMyCellNeighborhoodSum(my_board, i, j) == 2 |
         getMyCellNeighborhoodSum(my_board, i, j) == 3){
        output <- 1
      }                                        ## pravidlo (ii)
      
      if(getMyCellNeighborhoodSum(my_board, i, j) > 3){
        output <- 0
      }                                        ## pravidlo (iii)
      
    }else{
      
      if(getMyCellNeighborhoodSum(my_board, i, j) == 3){
        output <- 1
      }                                        ## pravidlo (iv)
      
    }
    
    return(output)
    
  }
  
  
  ## --------------------------------------------------------------------------
  
  updateMyBoard <- function(my_board){
    
    # '''
    # vrací updatovanou mřížku, tj. pro každou buňku dle daných pravidel
    # spočítá, zda o jeden krok dopředu bude živá, nebo mrtvá
    # '''
    
    output <- my_board
    
    for(i in 1:dim(my_board)[1]){
      for(j in 1:dim(my_board)[2]){
        
        output[i, j] <- updateMyCell(my_board, i, j)
        
      }
    }
    
    return(output)
    
  }
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## inicializuji hodnoty celulárního automatu --------------------------------

  my_values <- reactiveValues(
    
    my_board = matrix(
      rep(0, my_board_height * my_board_width),
      nrow = my_board_height
    ),                            ## prázdná mřížka (matice) daných rozměrů
    number_of_alive = 0,          ## počet živých buněk
    time_step = 0                 ## časový krok, zde 0 (počátek)
    
    )
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## definuji, co se stane po kliknutí na tlačítko "Start!" -------------------
  
  observeEvent(input$start_button, {
    
    ###########################################################################
    
    ## zavádím dynamicky renderované prvky, které se v interface objeví až
    ## po stisknutí tlačítka "Start!" -----------------------------------------
    
    output$my_text_origination <- renderUI({
      
      HTML(paste("Klikáním posunete vývoj rozestavení buněk celulárního ",
                 "automatu o jeden krok dopředu.", sep = ""))
      
    })
    
    
    output$my_step_button_origination <- renderUI({
      
      actionButton(inputId = "step_button",
                   label = HTML("<b>Pokračovat!</b>"),
                   width = 150)
      
    })
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## iniciální hodnoty při stisknutí tlačítka "Start!" ----------------------
    
    my_values$my_board <- matrix(
      rep(0, my_board_height * my_board_width),
      nrow = my_board_height
    )
    
    my_values$time_step <- 0
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## generuji mřížku celulárního automatu pro jednotlivá zadání uživatele ---
    
    if(input$my_pattern == "random_cells"){
      
      ## (i) náhodné buňky ----------------------------------------------------
      
      ## náhodně zvolené živé buňky v mřížce tak, aby pokryly uživatelem
      ## zvolené procento mřížky ----------------------------------------------
      
      my_points <- sample(
        x = c(1:(my_board_height * my_board_width)),
        size = floor(as.numeric(
          input$my_coverage / 100
          ) * my_board_height * my_board_width),
        replace = FALSE
      )
      
      my_xx <- NULL
      my_yy <- NULL
      
      for(i in 1:length(my_points)){
        
        my_xx <- c(my_xx, (my_points[i] %% my_board_width) + 1)
        my_yy <- c(my_yy, ceiling(my_points[i] / my_board_width))
        
      }
      
    }else{
      
      ## (ii+) ostatní tvary celulárního automatu -----------------------------
      
      my_xx <- get(as.character(input$my_pattern))$my_xx
      my_yy <- get(as.character(input$my_pattern))$my_yy
      
      if(input$my_pattern == "Gosper_glider_gun"){
        
        ## případě Gosperova křídlového děla je nutné omezit kvůli velikosti
        ## celého tvaru automatu náhodnost umístění do mřížky -----------------
        
        my_xx <- my_xx + floor(my_board_width / 2) - 5 + sample(
          x = c(-1:1), size = 1, replace = FALSE
        )
        my_yy <- my_yy + (my_board_height  - 8) + sample(
          x = c(-1:1), size = 1, replace = FALSE
        )
        
      }else{
        
        ## daný tvar celulárního automatu je umístěn přibližně doprostřed
        ## mřížky s malou rolí náhodného umístění -----------------------------
        
        my_xx <- my_xx + floor(my_board_width / 2) + sample(
          x = c(-3:3), size = 1, replace = FALSE
        )
        my_yy <- my_yy + floor(my_board_height / 2) + sample(
          x = c(-3:3), size = 1, replace = FALSE
        )
        
      }
      
    }
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## vytvářím finální vzhled iniciální mřížky celulárního automatu ----------
    
    temp_board <- my_values$my_board
    
    ## přepočítávám, které buňky jsou dle daného tvaru celulárního automatu
    ## živé -------------------------------------------------------------------
    
    for(i in 1:length(my_xx)){
      
      temp_board[my_yy[i], my_xx[i]] <- 1
      
    }
    
    my_values$my_board <- temp_board                     ## aktualizuji
                                                         ## mřížku
    
    my_values$number_of_alive = sum(my_values$my_board)  ## aktualizuji
                                                         ## počet živých
                                                         ## buněk

  })
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## definuji, co se stane po kliknutí na tlačítko "Pokračovat!" --------------
  
  observeEvent(input$step_button, {
    
    temp_board <- updateMyBoard(my_values$my_board)
    
    my_values$my_board <- temp_board                     ## aktualizuji
                                                         ## mřížku
    
    my_values$number_of_alive <- c(my_values$number_of_alive,
                                   sum(my_values$my_board))
                                                         ## na konec vektoru
                                                         ## s počtem živých
                                                         ## buněk přidávám
                                                         ## aktuální počet
    
    my_values$time_step <- c(my_values$time_step,
                             my_values$time_step[
                               length(my_values$time_step)
                               ] + 1)                    ## na konec vektoru
                                                         ## s počtem časových
                                                         ## okamžiků přidávám
                                                         ## aktuální okamžik
    
  })
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## vykresluji mřížku --------------------------------------------------------
  
  output$my_printable_board <- renderPlot({
    
    my_coordinates <- getMyCoordinates(my_values$my_board)
    
    par(mar = c(1, 0.1, 1, 10), xpd = TRUE)
    
    plot(
      x = my_coordinates$horizontal,
      y = my_coordinates$vertical,
      xlab = "",
      ylab = "",
      xlim = c(1, my_board_width),
      ylim = c(1, my_board_height),
      xaxt = "n",
      yaxt = "n",
      pch = 15,
      cex = 3.0
    )
    
    legend(
      x = "topright",
      legend = c(paste("časový okamžik\n= ",
                       my_values$time_step[length(my_values$time_step)],
                       sep = ""),
                 "_______________",
                 paste("počet živých buněk\n= ",
                       my_values$number_of_alive[
                         length(my_values$number_of_alive)
                         ],
                       sep = "")),
      inset = c(-0.15, -0.02),
      bty = "n",
      cex = 1.2
    )
    
  }, height = 640, width = 1150)
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## vytvářím diagram závislosti počtu živých buněk na časovém kroku ----------
  
  observeEvent(input$start_button, {
  
    output$number_of_alive_cells_vs_time <- renderPlot({
      
      par(mar = c(4.2, 4, 1, 1))
      
      plot(
        x = my_values$time_step,
        y = my_values$number_of_alive,
        type = "b",
        xlab = "časový okamžik",
        ylab = "počet živých buněk",
        xlim = c(0, my_values$time_step[length(my_values$time_step)]),
        xaxt = "n",
        cex.lab = 1.2,
        cex.axis = 1.2
      )
      
      axis(1,
           at = seq(0, my_values$time_step[length(my_values$time_step)], 1),
           labels = c(0:my_values$time_step[length(my_values$time_step)])
           )
      
    }, height = 500)
  
  })
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  #############################################################################
  #############################################################################
  
  
})


###############################################################################
###############################################################################
###############################################################################


