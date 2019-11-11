###############################################################################
###############################################################################
###############################################################################

## loaduju balíčky ------------------------------------------------------------

library(shiny)
library(shinyjs)


## ----------------------------------------------------------------------------

###############################################################################

## ----------------------------------------------------------------------------

shinyUI(
    
    fluidPage(
        
        tagList(
        
            ## ----------------------------------------------------------------
            
            ###################################################################
            
            ## zavádím busy indicator -----------------------------------------
            
            tags$head(
            
                tags$link(
                    rel = "stylesheet",
                    type = "text/css",
                    href = "style.css"
                ),
                
                tags$script(
                    type = "text/javascript",
                    src = "busy.js"
                ),
                
                tags$script(
                    type = "text/javascript",
                    src = "problem_1_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_2_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_3_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_4_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_5_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_6_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_7_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_8_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_9_submission_message.js"
                ),
                
                tags$script(
                  type = "text/javascript",
                  src = "problem_10_submission_message.js"
                ),
                
                # tags$script(
                    # type = "text/javascript",
                    # src = "problem_11_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_12_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_13_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_14_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_15_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_16_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_17_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_18_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_19_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_20_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_21_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_22_submission_message.js"
                # ),
                
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_23_submission_message.js"
                # ),
                  
                # tags$script(
                  # type = "text/javascript",
                  # src = "problem_24_submission_message.js"
                # ),
                
                tags$link(
                    rel = "stylesheet",
                    type = "text/css",
                    href = "margins_and_paddings.css"
                ),
                
                tags$link(
                    rel = "shortcut icon",
                    href = "christmas_tree_favicon.png"
                ),
                
                tags$style(
                    type = "text/css",
                    paste(
                        ".panel-footer {position:",
                        "fixed; right: 0;",
                        "bottom: 0;",
                        "left: 0;}",
                        sep = ""
                    )
                )
                
            ),
            
            div(
                class = "busy",
                p("Aplikace je zaneprázdněná..."),
                img(
                    src = "busy_indicator.gif",
                    height = 100,
                    width = 100
                )
            ),
            
            
            ## volám shinyjs funkcionality ------------------------------------
            
            shinyjs::useShinyjs(),
            
            
            ## user-interface aplikace ----------------------------------------
            
            navbarPage(
            
                
                ## header -----------------------------------------------------
            
                title = div(
                    HTML(
                        "<font size = '5'>Adventní kalendář</font>"
                    )
                ),
                
                id = "my_navbar_page_set",
                
                windowTitle = "Adventní kalendář",
                
                position = "fixed-top",
                
                selected = "introduction",
                
                collapsible = TRUE,
                
                
                ## footer -----------------------------------------------------
                
                footer = list(
                   
                    div(class = "clear"),
                    div(
                        class = "panel-footer",
                        HTML(
                            '
                                <!-- název aplikace -->
                                <font size = "4">
                                    Adventní kalendář
                                </font>
                                
                                <!-- verze aplikace -->
                                <font size = "2">
                                    &nbsp; | &nbsp;
                                    verze 0.0.1
                                    &nbsp; | &nbsp;
                                </font>
                                
                                <!-- licence a její logo -->
                                <a
                                    href =
                                    "https://creativecommons.org/
                                    licenses/by-nc-nd/3.0/cz/"
                                    id = "tooltip_cc"
                                    target = "_blank"
                                >
                                    <img
                                        src = "cc_by_nc_nd.png",
                                        style = "height: 20px;"
                                    >
                                </a>
                                
                                <!-- zkratka licence -->
                                &nbsp;
                                | &nbsp; CC BY-NC-ND 3.0 CZ &nbsp;
                                | &nbsp; 2018 &nbsp;
                                | &nbsp;
                                
                                <!-- technická podpora -->
                                <a
                                    href =
                                    "mailto:lubomir.stepanek@lf1.cuni.cz"
                                >
                                    Lubomír Štěpánek
                                </a> věnuje (nejen) <a
                                  href = "http://dychanky.vse.cz/"
                                  target = "_blank"
                                >
                                  Statistickým dýchánkům na VŠE
                                </a>
                            ',
                            '
                            <!-- počítadlo návštěv -->
                            <span style = "float:right">
                            ',
                            paste(
                                "<font size = '2'><b>",
                                textOutput(
                                    "my_counter",
                                    inline = TRUE
                                ),
                                "&emsp; </b></font>",
                                sep = ""
                            ),
                            '
                            <!-- logo FIS VŠE -->
                            <a
                                href = "https://fis.vse.cz/"
                                id = "tooltip_vse_fis"
                                target = "_blank"
                            >
                                <img
                                    src = "logo_vse_fis.png",
                                    style = "height: 30px;"
                                >
                            </a>
                            <a
                                href = "https://www.lf1.cuni.cz/"
                                id = "tooltip_lf1"
                                target = "_blank"
                            >
                                <img
                                    src = "logo_lf1.png",
                                    style = "height: 30px;"
                                >
                            </a>
                            <a
                                href = "https://www.fbmi.cvut.cz/"
                                id = "tooltip_fbmi"
                                target="_blank"
                            >
                                <img
                                    src = "logo_fbmi.png",
                                    style = "height: 30px;"
                                >
                            </a>',
                            '</span>',
                            '
                            <!-- javascriptové funkcionality v HTML -->
                            <script>
                                $("#tooltip_cc").attr(
                                    "title",
                                    "CC BY-NC-ND 3.0 CZ"
                                );
                                $("#tooltip_vse_fis").attr(
                                    "title",
                                    "FIS VŠE"
                                );
                                $("#tooltip_lf1").attr(
                                    "title",
                                    "1. LF UK"
                                );
                                $("#tooltip_fbmi").attr(
                                    "title",
                                    "FBMI ČVUT"
                                );
                            </script>'
                        ),
                        style = "opacity: 1.00; z-index: 1000;"
                    )
                    
                ),
                
                theme = "bootstrap.css",
                
                
                ## první záložka ----------------------------------------------
                
                tabPanel(
                    
                    title = "Úvod",
                    
                    value = "introduction",
                    
                    h3("K čemu je vlastně tahle aplikace dobrá?"),
                    
                    HTML("<hr>"),
                    
                    p(
                        "(i) No, v podstatě k ničemu. Nicméně ..."
                    ),
                    
                    p(HTML(
                        "(ii) ... smyslem této aplikace je naladit ",
                        "(nejen) komunitu ",
                        "kolem <a href='http://dychanky.vse.cz/' target='_blank'>",
                        "Statistických dýchánků na VŠE</a> do vánoční ",
                        "atmosféry. A současně také poměřit síly v řešení ",
                        "rekreačních úloh, kde lze ",
                        "šikovně uplatnit naše milované R-ko."
                    )),
                    
                    p(HTML(
                        "Mezi 1. až 24. prosincem se zde (v záložkách ",
                        "<b>Kalendář</b> a <b>Úlohy</b>) každý den objeví ",
                        "vždy nová úloha rekreačního charakteru a Vy si ji ",
                        "můžete zkusit (jakkoliv) vyřešit a uploadnout ",
                        "vaše řešení pod vaším nickem. Pokud bude řešení ",
                        "správné, přičte se Vám za úlohu bod. Pozor, je ",
                        "třeba si udržovat stále stejný nick a současně si",
                        "kolegiálně na začátku vytvořit nějaký svůj vlastní, ",
                        "originální (jinak se budou body přičítat jen ",
                        "dotyčnému, který si daný nick založil jako první). ",
                        "Každou úlohu lze řešit opakovaně bez jakýchkoliv ",
                        "bodových sankcí."
                    )),
                    
                    p(HTML(
                      "Řešit a získávat body lze za úlohy i zpětně, podobně ",
                      "jako hodně z nás vyjídala čokoládový adventní ",
                      "kalendář ",
                      "za 'odměnu' až těsně před Štědrým dnem. :-) Takže ",
                      "<i>i</i>-tý den lze řešit každou <i>j</i>-tou úlohu pro ",
                      "všechna <i>j</i> &isin; {1, 2, ..., <i>i</i>} tak, že je ",
                      "<i>i</i> &isin; ",
                      "{1, 2, ..., 24}. ",
                      "Aktuální pořadí řešících lze nahlédnout v záložce ",
                      "<b>Řešitelé</b>."
                    )),
                    
                    fluidRow(
                      column(
                        width = 3,
                        offset = 0,
                        actionButton(
                          inputId = "jump_to_calendar_tab",
                          label = HTML(
                            "Přejdi na záložku <b>Kalendář</b>"
                          )
                        )
                      ),
                      column(
                        width = 3,
                        offset = 0,
                        actionButton(
                          inputId = "jump_to_solvers_tab",
                          label = HTML(
                            "Přejdi na záložku <b>Řešitelé</b>"
                          )
                        )
                      )
                    ),
                    
                    HTML("<hr>"),
                    
                    p(
                        HTML(
                            "Kontaktní informace na autora aplikace jsou ",
                            "dostupné v záložce <b>O aplikaci</b>. ",
                            "Tahle aplikace by nevznikla bez silné inspirace ",
                            "'profi' aplikací",
                            "<a href=
                            'https://shiny.cs.cas.cz/ShinyItemAnalysis/'
                            target='_blank'
                            ><tt>ShinyItemAnalysis</tt></a>, ",
                            "kterou vytváří tým úžasných a inspirativních ",
                            "lidí -- jde o Patrici Martínkovou, Adélu ",
                            "Drabinovou a Kubu Houdka (a tak trochu i mě). ",
                            "Všechen kredit jde jim!"
                        )
                    ),
                    
                    actionButton(
                        inputId = "jump_to_about_tab",
                        label = HTML(
                            "Přejdi na záložku <b>O aplikaci</b>"
                        )
                    ),
                    
                    HTML("<hr>"),
                    
                    # HTML(
                    #   "<center>
                    #   <img
                    #   src = 'christmas_tree_favicon.png'
                    #   alt = 'christmas_tree_favicon'
                    #   align = 'middle'
                    #   width = '250px'
                    #   class = 'img-responsive'
                    #   >
                    #   </center>"
                    # ),
                    
                    fluidRow(
                      column(
                        width = 6,
                        offset = 0,
                        HTML(
                          "<img
                          src = 'christmas_tree_favicon.png'
                          alt = 'christmas_tree_favicon'
                          align = 'right'
                          width = '180px'
                          class = 'img-responsive'
                          >"
                        )
                      ),
                      column(
                        width = 6,
                        offset = 0,
                        HTML(
                          "<img
                          src = 'statisticke_dychanky_logo.png'
                          alt = 'statisticke_dychanky'
                          align = 'left'
                          width = '148px'
                          class = 'img-responsive'
                          >"
                        )
                      )
                    ),
                    
                    HTML("<hr>")
                    
                ),
                
                
                ## druhá záložka ----------------------------------------------
                
                tabPanel(
                    
                    title = "Kalendář",
                    
                    value = "calendar_tab",
                    
                    h3("Adventní kalendář"),
                    
                    HTML("<hr>"),
                    
                    uiOutput("today_date"),
                    
                    tags$hr(),
                    
                    fluidRow(
                      column(
                        width = 3,
                        offset = 0,
                        actionButton(
                          inputId = "jump_to_problem_1_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 1</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_3_tab",
                          label = HTML(
                          "Přejdi na <b>úlohu 3</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_5_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 5</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_7_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 7</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_9_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 9</b>"
                          )
                        )#,
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_11_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 11</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_13_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 13</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_15_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 15</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_17_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 17</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_19_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 19</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_21_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 21</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_23_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 23</b>"
                        #   )
                        # )
                      ),
                      
                      
                      #########################################################•
                      
                      column(
                        width = 6,
                        offset = 0,
                        HTML(
                            "<center>
                            <img
                            src = 'christmas_tree.png'
                            alt = 'christmas_tree'
                            align = 'middle'
                            width = '500px'
                            class = 'img-responsive'
                            >
                            </center>"
                        )
                      ),
                      
                      
                      #########################################################
                      
                      column(
                        width = 3,
                        offset = 0,
                        actionButton(
                          inputId = "jump_to_problem_2_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 2</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_4_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 4</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_6_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 6</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_8_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 8</b>"
                          )
                        ),
                        br(),
                        br(),
                        actionButton(
                          inputId = "jump_to_problem_10_tab",
                          label = HTML(
                            "Přejdi na <b>úlohu 10</b>"
                          )
                        )#,
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_12_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 12</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_14_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 14</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_16_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 16</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_18_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 18</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_20_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 20</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_22_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 22</b>"
                        #   )
                        # ),
                        # br(),
                        # br(),
                        # actionButton(
                        #   inputId = "jump_to_problem_24_tab",
                        #   label = HTML(
                        #     "Přejdi na <b>úlohu 24</b>"
                        #   )
                        # )
                      )
                    ),
                    
                    tags$hr()
                    
                ),
                
                
                ## třetí záložka ----------------------------------------------
                
                navbarMenu(
                    
                    title = "Úlohy",
                    
                    ###########################################################
                    
                    ## úloha 1 ------------------------------------------------
                    
                    tabPanel(
                      
                        title = "1. úloha",
                      
                        value = "problem_1_tab",
                      
                        h3("Úloha 1"),
                        
                        tags$hr(),
                        
                        p(HTML(
                          "Jeroným obchází kolem dokola kruhové náměstí, ",
                          "které je na obvodu osvětleno celkem 2018 lampami. ",
                          "Na začátku jsou všechny lampy zhasnuté. Jeroným ",
                          "vyjde ze své strážní budky a při své první obchůzce ",
                          "náměstí se zastaví u každé lampy -- pokud lampa ",
                          "nesvítí, rozsvítí ji, pokud svítí, zhasne ji.<sup>1</sup>",
                          "Pak dojde zpět ke své budce. Následně vyjde znovu ",
                          "kolem dokola náměstí a při druhé obchůzce se zastaví ",
                          "u každé druhé lampy -- pokud lampa nesvítí, rozsvítí ",
                          "ji, pokud svítí, zhasne ji. Nakonec se opět vrátí ",
                          "do své budky. Jenže potom vyjde znovu na obchůzku ",
                          "kolem náměstí a při své třetí obchůzce se zastaví u ",
                          "každé třetí lampy -- pokud lampa nesvítí, rozsvítí ",
                          "ji, pokud svítí, zhasne ji, než dojde zpět ke své ",
                          "budce. To opakuje tolikrát, že provede celkem 2018 ",
                          "obchůzek náměstí a při každé obchůzce některé lampy ",
                          "zhasne a ",
                          "některé rozsvítí tak, jak je uvedeno výše.<sup>2</sup> ",
                                      "Vždy chodí náměstím ve stejném směru.",
                          "Kolik lamp svítí po jeho 2018-té obchůzce náměstí?"
                        )),
                        
                                  p(
                                    "Výsledek uveďte jako přirozené číslo."
                                  ),
                                  
                        p("__________________________________"),
                        
                        p(HTML(
                          "<sup>1</sup> Tedy při první obchůzce rozsvítí všech ",
                          "2018 lamp."
                        )),
                        
                        p(HTML(
                          "<sup>2</sup> Formálněji, Jeroným provede celkem 2018 ",
                          "obchůzek náměstí a při <i>i</i>-té obchůzce náměstí, ",
                          "kde <i>i</i> &isin; {1, 2, ..., 2018}, se zastaví u ",
                          "každé <i>i</i>-té lampy: pokud ona lampa nesvítí, ",
                          "rozsvítí ji, pokud svítí, zhasne ji."
                        )),
                          
                        tags$hr(),
                        
                        "Sem vlož svůj nick (pouze alfanumerické znaky).",
                        
                        br(),
                        
                        HTML(
                          paste(
                            '<textarea style="width:200px; height:30px;"',
                            'id="problem_1_nickname"',
                            'placeholder=""></textarea>',
                            sep = ""
                          )
                        ),
                        
                        tags$hr(),
                        
                        "Sem vlož své heslo (pouze alfanumerické znaky;
                        při úplně prvním vložení si ho zvol
                        a zapamatuj, kdykoliv potom již musíš své heslo použít
                        v nezměněné podobě).",
                        
                        br(),
                        
                        HTML(
                          paste(
                            '<textarea style="width:200px; height:30px;"',
                            'id="problem_1_password"',
                            'placeholder=""></textarea>',
                            sep = ""
                          )
                        ),
                        
                        tags$hr(),
                        
                        "Sem vlož své řešení.",
                        
                        br(),
                        
                        HTML(
                          paste(
                            '<textarea style="width:200px; height:30px;"',
                            'id="problem_1_solution"',
                            'placeholder=""></textarea>',
                            sep = ""
                          )
                        ),
                        
                        tags$hr(),
                        
                        "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                        
                        br(),
                        
                        actionButton(
                          inputId = "problem_1_submitting",
                          label = HTML(
                            "Potvrzuji!"
                          )
                        ),
                        
                        tags$hr(),
                        
                        p(HTML(
                            "Jak jsi uspěl, se dozvíš v záložce ",
                            "<b>Řešitelé</b>."
                        )),
                        
                        actionButton(
                          inputId = "jump_to_solvers_tab_from_problem_1",
                          label = HTML(
                            "Přejdi na záložku <b>Řešitelé</b>"
                          )
                        ),
                        
                        tags$hr()
                        
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 2 ------------------------------------------------
                    
                    tabPanel(
                    
                        title = "2. úloha",
                    
                        value = "problem_2_tab",
                    
                        h3("Úloha 2"),
                    
                        tags$hr(),
                        
                        p(HTML(
                          "Házíme jedenkrát šipkou na kruhový jednotkový<sup>1</sup> terč, ",
                          "který s jistotou zasáhneme; ",
                          "každý bod terče má stejnou pravděpodobnost zásahu. ",
                          "Pravděpodobnost, že se trefíme do vzdálenosti větší než ",
                          "<span style='font-family:Times'><i>p</i></span> od ",
                          "středu terče, je ",
                          "<span style='font-family:Times'><i>p</i></span>. ",
                          "Určete ",
                          "<span style='font-family:Times'><i>p</i></span>."
                        )),
                        
                        p(
                          "Výsledek uveďte jako desetinné číslo s přesností na ",
                          "tři desetinná místa, použijte desetinnou tečku či čárku."
                        ),
                        
                        p("__________________________________"),
                        
                        p(HTML(
                          "<sup>1</sup> Poloměr terče je roven přesně 1,0."
                        )),
                    
                        tags$hr(),
                    
                        "Sem vlož svůj nick (pouze alfanumerické znaky).",
                    
                        br(),
                    
                        HTML(
                          paste(
                            '<textarea style="width:200px; height:30px;"',
                            'id="problem_2_nickname"',
                            'placeholder=""></textarea>',
                            sep = ""
                          )
                        ),
                        
                        tags$hr(),
                        
                        "Sem vlož své heslo (pouze alfanumerické znaky;
                        při úplně prvním vložení si ho zvol
                        a zapamatuj, kdykoliv potom již musíš své heslo použít
                        v nezměněné podobě).",
                        
                        br(),
                        
                        HTML(
                          paste(
                            '<textarea style="width:200px; height:30px;"',
                            'id="problem_2_password"',
                            'placeholder=""></textarea>',
                            sep = ""
                          )
                        ),
                    
                        tags$hr(),
                    
                        "Sem vlož své řešení.",
                    
                        br(),
                    
                        HTML(
                          paste(
                            '<textarea style="width:200px; height:30px;"',
                            'id="problem_2_solution"',
                            'placeholder=""></textarea>',
                            sep = ""
                          )
                        ),
                    
                        tags$hr(),
                    
                        "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                    
                        br(),
                    
                        actionButton(
                          inputId = "problem_2_submitting",
                          label = HTML(
                            "Potvrzuji!"
                          )
                        ),
                    
                        tags$hr(),
                    
                        p(HTML(
                          "Jak jsi uspěl, se dozvíš v záložce ",
                          "<b>Řešitelé</b>."
                        )),
                    
                        actionButton(
                          inputId = "jump_to_solvers_tab_from_problem_2",
                          label = HTML(
                            "Přejdi na záložku <b>Řešitelé</b>"
                          )
                        ),
                    
                        tags$hr()
                    
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 3 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "3. úloha",
                      
                      value = "problem_3_tab",
                      
                      h3("Úloha 3"),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Najděte pravděpodobnost, že rovnice"
                      )),
                      
                      withMathJax(),
                      ("$$ x^2  + Yx + Z = 0 $$"),
                      
                      withMathJax(),
                      p(HTML(
                        "má alespoň jeden reálný kořen, tedy ",
                        "\\( x \\in \\mathbb{R} \\), ",
                        "víte-li, že ",
                        "\\( Y \\sim \\mathcal{N}(0, 1) \\) ",
                        "a dále<sup>1</sup> že ",
                        "\\( P(Z = 1/4) = P(Z = 1/2) = P(Z = 3/4) = P(Z = 1) = 1/4 \\)."
                      )),
                      
                      p(
                        "Výsledek uveďte jako desetinné číslo s přesností na ",
                        "pět desetinných míst, použijte desetinnou tečku či čárku."
                      ),
                      
                      p("__________________________________"),
                      
                      withMathJax(),
                      p(HTML(
                        "<sup>1</sup> Tedy \\( Y \\sim \\mathcal{N}(0, 1) \\) ",
                        "značí, že náhodná veličina \\( Y \\) sleduje ",
                        "standardní normální rozdělení, a ",
                        "\\( P(A) \\) značí ",
                        "pravděpodobnost jevu \\( A \\)."
                      )),
                        
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_3_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_3_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_3_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_3_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_3",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 4 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "4. úloha",
                      
                      value = "problem_4_tab",
                      
                      h3("Úloha 4"),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Ondra s Radimem hrají následující hru: na tabuli ",
                        "napíšou všechna přirozená čísla od 1 do 40 (včetně) ",
                        "a poté se postupně střídají v jejich náhodném ",
                        "umazávání. ",
                        "Když na tabuli zbývá posledních pět čísel, přestane ",
                        "je hra bavit. ",
                        "S&nbsp;jakou pravděpodobností je všech pět čísel, ",
                        "která zbyla na tabuli, navzájem soudělných<sup>1</sup>?"
                      )),
                      
                      p(
                        "Výsledek uveďte jako desetinné číslo s přesností na ",
                        "čtyři desetinná místa, použijte desetinnou tečku či čárku."
                      ),
                      
                      p("__________________________________"),
                        
                      p(HTML(
                        "<sup>1</sup> Všech pět čísel na tabuli je soudělných, ",
                        "pokud je jejich největší ",
                        "společný dělitel větší než 1."
                      )),
                        
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_4_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_4_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                        
                      tags$hr(),
                      
                      "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_4_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_4_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_4",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 5 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "5. úloha",
                      
                      value = "problem_5_tab",
                      
                      h3("Úloha 5"),
                      
                      tags$hr(),
                      
                      withMathJax(),
                      p(HTML(
                        "Z intervalu ",
                        "\\( (0, 1) \\) ",
                        "náhodně vybíráme dvě reálná čísla ",
                        "\\( x \\) a ",
                        "\\( y \\). ",
                        "Určete, s jakou pravděpodobností je"
                      )),
                      
                      withMathJax(),
                      ("$$ \\frac{\\max\\{x^2, y^2\\}}{\\min\\{x, y\\}} \\geq 2 .$$"),
                      
                      p(
                        "Výsledek uveďte jako desetinné číslo s přesností na ",
                        "čtyři desetinná místa, použijte desetinnou tečku či čárku."
                      ),
                      
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_5_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                      
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_5_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_5_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_5_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_5",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 6 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "6. úloha",
                      
                      value = "problem_6_tab",
                      
                      h3("Úloha 6"),
                      
                      tags$hr(),
                      
                      withMathJax(),
                      p(HTML(
                        "Označme \\( V_{k, \\ n} \\) ",
                        "množinu všech uspořádaných ",
                        "\\( k \\)-tic ",
                        " přirozených čísel<sup>1</sup>, ",
                        #" ve tvaru ",
                        #"\\( [x_{1}, x_{2}, x_{3}, \\ldots, x_{k - 1}, x_{k}] \\), ",
                        "které jsou řešením nerovnice"
                      )),
                      
                      withMathJax(),
                      ("$$ x_{1} + x_{2} + x_{3} + \\cdots + x_{k - 1} + x_{k} \\leq n ,$$"),
                      
                      withMathJax(),
                      p(HTML(
                        "kde \\( k \\) a \\( n \\) jsou daná přirozená čísla. ",
                        "Najděte počet všech libovolně dlouhých, uspořádaných řešení ",
                        "uvedené nerovnice<sup>2</sup> pro \\( n = 2018 \\). Jinými slovy, ",
                        "najděte hodnotu výrazu"
                      )),
                      
                      withMathJax(),
                      ("$$ \\sum\\limits_{\\forall k > 0} \\lvert V_{k, \\ 2018} \\rvert .$$"),
                      
                      withMathJax(),
                      p(
                        "Výsledek uveďte jako poslední šestičíslí počtu ",
                        "všech takových řešení, tedy poslední šestičíslí výrazu ",
                        "\\( \\sum\\limits_{\\forall k > 0} \\lvert V_{k, \\ 2018} \\rvert \\)."
                      ),
                      
                      p("__________________________________"),
                        
                      p(HTML(
                        "<sup>1</sup> Nulu za přirozené číslo nepovažujeme."
                      )),
                      
                      withMathJax(),
                      p(HTML(
                        "<sup>2</sup> Snadno nahlédneme, že ",
                        "počet řešení takové nerovnice pro \\( n = 3 \\) by byl ",
                        "\\( \\sum\\limits_{\\forall k > 0} \\lvert V_{k, \\ 3} \\rvert  = \\lvert V_{1, \\ 3} \\rvert + \\lvert V_{2, \\ 3} \\rvert + \\lvert V_{3, \\ 3} \\rvert = \\lvert \\{ [1], [2], [3] \\} \\rvert + \\lvert \\{ [1, 1], [1, 2], [2, 1] \\} \\rvert + \\lvert \\{ [1, 1, 1] \\} \\rvert = 7 \\)."
                      )),
                      
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_6_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_6_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                        
                      tags$hr(),
                      
                      "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_6_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_6_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_6",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 7 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "7. úloha",
                      
                      value = "problem_7_tab",
                      
                      h3("Úloha 7"),
                      
                      tags$hr(),
                      
                      withMathJax(),
                      p(HTML(
                        "Honza stojí před úkolem vydláždit svůj chodník ",
                        "o rozměrech \\( n \\times 1 \\) pomocí pěti typů ",
                        "dlaždic, a sice ",
                        "\\( 1 \\times 1 \\), \\( 2 \\times 1 \\), \\( 3 \\times 1 \\), ",
                        "\\( 4 \\times 1 \\) a \\( 5 \\times 1 \\). ",
                        "Od každého z pěti typů dlaždic má dostatečný počet kusů<sup>1</sup>. ",
                        "Kolika navzájem různými<sup>2</sup> způsoby se mu může vydláždění ",
                        "chodníku podařit?"
                      )),
                      
                      withMathJax(),
                      p(
                        "Výsledek uveďte jako poslední šestičíslí počtu ",
                        "všech takových možných způsobů vydláždení chodníku ",
                        "o rozměrech \\( n \\times 1 \\) pro \\( n = 2018 \\)."
                      ),
                      
                      p("__________________________________"),
                      
                      p(HTML(
                        "<sup>1</sup> I kdyby celý chodník vydláždil jen jedním daným ",
                        "typem dlaždice, ještě mu dlaždice onoho typu zbydou. ",
                        "To platí pro každý z pěti typů dlaždic."
                      )),
                      
                      withMathJax(),
                      p(HTML(
                        "<sup>2</sup> Takže například chodník o rozměrech ",
                        "\\( 3 \\times 1 \\) ",
                        "lze pomocí dostatečného počtu dlaždic typu ",
                        "\\( 1 \\times 1 \\) (<img src = 'dlazdice_1_1.png', style = 'height: 15px;'>), ",
                        "\\( 2 \\times 1 \\) (<img src = 'dlazdice_2_1.png', style = 'height: 15px;'>) a ",
                        "a \\( 3 \\times 1 \\) (<img src = 'dlazdice_3_1.png', style = 'height: 15px;'>) ",
                        "vydláždit celkem čtyřmi způsoby: ",
                        "<img src = 'reseni_1_1_1.png', style = 'height: 15px;'>, ",
                        "<img src = 'reseni_1_2.png', style = 'height: 15px;'>, ",
                        "<img src = 'reseni_2_1.png', style = 'height: 15px;'>, ",
                        "<img src = 'reseni_3.png', style = 'height: 15px;'>."
                      )),
                      
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_7_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_7_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                        
                      tags$hr(),
                      
                      "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_7_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_7_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_7",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 8 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "8. úloha",
                      
                      value = "problem_8_tab",
                      
                      h3("Úloha 8"),
                      
                      tags$hr(),
                      
                      withMathJax(),
                      p(HTML(
                        "Jirka, zvídavý R-kař a zkušený donchuán<sup>1</sup>, ",
                        "řeší v rámci doktorského ",
                        "přijímacího řízení na VŠe (Vysoká škola eRkařská) ",
                        "úlohu o Tribonacciho číslech. ",
                        "Pro každé přirozené \\( i \\in \\{ 1, 2, 3, 4, \\ldots \\} \\) ",
                        "je zde<sup>2</sup> Tribonacciho číslo \\( T_{i}\\) definováno jako "
                      )),
                      
                      withMathJax(),
                      (
                      "$$ T_{i} =
                        \\cases{
                          1 ,&  $\\quad i \\in \\{ 1, 2, 3 \\}$ \\\\
                          T_{i - 1} + T_{i - 2} + T_{i - 3} ,& $\\quad i \\in \\{ 4, 5, \\ldots \\}$.
                        }
                      $$"
                      ),
                      
                      withMathJax(),
                      p(HTML(
                        "Jirka má konkrétně za úkol najít hodnotu \\( T_{42} \\). ",
                        "To je snadné, pomyslí si, a napíše si k nalezení výsledku ",
                        "následují R-kovou funkci a příkaz "
                      )),
                      
                      p(HTML(                        
                        "<blockquote><pre><code>",                        
                        "getMyTribonacci <- function(n){ <br>",
                        "<br>",
                        "    # ''' <br>",
                        "    # Vrací 'n'-té Tribonacciho číslo. <br>",
                        "    # ''' <br>",
                        "<br>",
                        "    if(n <= 3){ <br>",
                        "        return(1) <br>",
                        "    }else{ <br>",
                        "        return( <br>",
                        "            getMyTribonacci(n - 1) + <br>",
                        "            getMyTribonacci(n - 2) + <br>",
                        "            getMyTribonacci(n - 3) <br>",
                        "        ) <br>",
                        "    } <br>",
                        "    <br>",
                        "} <br>",                        
                        "<br>",
                        "getMyTribonacci(42)",
                        "<br>",
                        "</code></pre></blockquote>"
                      )),
                      
                      p(HTML(
                        "Výpočet trvá ale docela dlouho, ",
                        "a Jirku správně napadne, že je to nejspíš tím, ",
                        "jak funkce <tt>getMyTribonacci()</tt> ",
                        "volá opakovaně ve svém těle sama sebe. ",
                        "Kolikrát od okamžiku, kdy jsem zavolal příkaz ",
                        "<tt>getMyTribonacci(42)</tt> (včetně), až do okamžiku, ",
                        "kdy jsem dostal její výstup (včetně), byla asi funkce ",
                        "<tt>getMyTribonacci()</tt> volána? ",
                        "Pomozte Jirkovi počet volání funkce <tt>getMyTribonacci()</tt> ",
                        "nalézt."
                      )),
                      
                      withMathJax(),
                      p(HTML(
                        "Jako výsledek uveďte počet ",
                        "všech volání funkce <tt>getMyTribonacci()</tt> od ",
                        "okamžiku, kdy Jirka zavolal příkaz <tt>getMyTribonacci(42)</tt> ",
                        "(včetně), až do okamžiku, kdy získal výstup tohoto ",
                        "příkazu<sup>3</sup>. ",
                        "Voláním rozumíme tedy jak iniciální zavolání uživatelem, ",
                        "tak všechna vnitřní volání funkce sebou samotnou během ",
                        "výpočtu."                        
                      )),
                      
                      p("__________________________________"),
                        
                      p(HTML(
                        "<sup>1</sup> Velikost pozornosti, kterou věnuje oběma aktivitám, ",
                        "nemusí nutně odpovídat uvedenému pořadí."
                      )),
                      
                      p(HTML(
                        "<sup>2</sup> Definice Tribonacciho čísel se může ",
                        "v závislosti na literatuře lišit."
                      )),
                      
                      withMathJax(),
                      p(HTML(
                        "<sup>3</sup> Hodnotu \\( T_{42} \\) si samozřejmě můžete ",
                        "také spočítat, ale jako výsledek ji neuvádějte."
                      )),
                      
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_8_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_8_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                        
                      tags$hr(),
                      
					  "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_8_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_8_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_8",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 9 ------------------------------------------------
                    
                    tabPanel(
                      
                      title = "9. úloha",
                      
                      value = "problem_9_tab",
                      
                      h3("Úloha 9"),
                      
                      tags$hr(),
                      
                      withMathJax(),
                      p(HTML(
                        "Verča nezná pojem nuda, a protože nade všechno na světě ",
                        "miluje aritmetiku trojúhelníků s&nbsp;celočíselnými stranami, ",
                        "mezi cvičeními, která vede, se sama zabavuje miniúlohami, ",
                        "které si v&nbsp;duchu řeší. Naposledy se rozptýlila touhle: "
                      )),
                      
                      withMathJax(),                    
                      p(HTML(
                        ">>&nbsp;<i>Když rozdělím číslo 2018 zcela náhodně na tři kladné ",
                        "sčítance, s jakou pravděpodobností budou tato tři kladná čísla ",
                        "tvořit strany trojúhelníku?</i>&nbsp;<<"
                      )),
                      
                      p(HTML(
                        "K&nbsp;jakému číslu<sup>1</sup> se ",
                        "Verča dopočítala?"
                      )),
                      
                      p(HTML(
                        "Výsledek uveďte jako desetinné číslo s přesností na ",
                        "šest desetinných míst, použijte desetinnou tečku či čárku."
                      )),
                      
                      p("__________________________________"),
                      
                      p(HTML(
                        "<sup>1</sup> Předpodkládáme samozřejmě, že Verča ",
                        "si na úlohu odpověděla správně. Narozdíl od nudy totiž ",
                        "zná pravděpodobnost sestavení trojúhelníku ze tří ",
                        "náhodně dlouhých částí úsečky dané konstantní délky."
                      )),
                      
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_9_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_9_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                        
                      tags$hr(),
                      
                      "Sem vlož své řešení.",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_9_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_9_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_9",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    ),
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 10 -----------------------------------------------
                    
                    tabPanel(
                      
                      title = "10. úloha",
                      
                      value = "problem_10_tab",
                      
                      h3("Úloha 10"),
                      
                      tags$hr(),
                      
                      withMathJax(),
                      p(HTML(
					    "Mikuláš letos přinesl každému to, co má dotyčný nejraději. ",
                        "Karlovi, velkému milovníkovi optimalizací, proto nadělil ",
						"následující nelineární celočíselný program, "
                      )),
                      
                      withMathJax(),
                      (
                      "$$ \\max\\limits_{n_{1}, n_{2}, n_{3}, \\ldots} P =
					    n_{1} \\cdot n_{2} \\cdot n_{3} \\cdot \\ldots \\\\
						\\\\
						\\\\
						\\qquad \\qquad \\textrm{s. t.} \\qquad n_{1} + n_{2} + n_{3} + \\ldots = 2018 \\\\
						\\  \\  \\  \\ \\qquad \\qquad \\qquad \\qquad n_{1}, n_{2}, n_{3}, \\ldots \\in \\mathbb{N} \\textrm{.}
                      $$"
                      ),
                      
					  withMathJax(),
					  p(HTML(
                        "Jinými slovy, Karel stojí před úkolem rozdělit číslo 2018 na ",
						"konečný počet libovolných přirozených sčítanců tak, aby jejich součin ",
						"byl maximální možný. Čemu se tento součin, značený \\( P \\), ",
						"rovná?"
                      )),
					  
					  withMathJax(),
					  p(HTML(
                        "Výsledek uveďte jako poslední šestičíslí čísla \\( P \\)."
                      )),
					  
                      tags$hr(),
                      
                      "Sem vlož svůj nick (pouze alfanumerické znaky).",
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_10_nickname"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                        
                      "Sem vlož své heslo (pouze alfanumerické znaky;
                      při úplně prvním vložení si ho zvol
                      a zapamatuj, kdykoliv potom již musíš své heslo použít
                      v nezměněné podobě).",
                        
                      br(),
                        
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_10_password"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                        
                      tags$hr(),
                      
					  "Sem vlož své řešení.",                      
                      
                      br(),
                      
                      HTML(
                        paste(
                          '<textarea style="width:200px; height:30px;"',
                          'id="problem_10_solution"',
                          'placeholder=""></textarea>',
                          sep = ""
                        )
                      ),
                      
                      tags$hr(),
                      
                      "Potvrď, že jseš si jistý/á/é nickem, heslem i řešením.",
                      
                      br(),
                      
                      actionButton(
                        inputId = "problem_10_submitting",
                        label = HTML(
                          "Potvrzuji!"
                        )
                      ),
                      
                      tags$hr(),
                      
                      p(HTML(
                        "Jak jsi uspěl, se dozvíš v záložce ",
                        "<b>Řešitelé</b>."
                      )),
                      
                      actionButton(
                        inputId = "jump_to_solvers_tab_from_problem_10",
                        label = HTML(
                          "Přejdi na záložku <b>Řešitelé</b>"
                        )
                      ),
                      
                      tags$hr()
                      
                    )#,
                    
					
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 11 -----------------------------------------------
                    
                    
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 12 -----------------------------------------------
                    
                    
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 13 -----------------------------------------------
                    
                    
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 14 -----------------------------------------------
                    
                    
                    
                    
                    ## --------------------------------------------------------
                    
                    ###########################################################
                    
                    ## úloha 15 -----------------------------------------------
                    
                    
                    
                    
                ),
                
                
                ## čtvrtá záložka ---------------------------------------------
                
                tabPanel(
                    
                    title = "Řešitelé",
                    
                    value = "solvers_tab",
                    
                    h3("Tabulka s řešiteli"),
                    
                    tags$hr(),
                    
                    p(HTML(
                      "Napsal jsi omylem špatný nick? Zapomněl jsi svoje ",
					  "heslo? Našel jsi v některém ",
                      "zadání chybu, ať už jazykovou, nebo věcnou? Napiš mi ",
                      "na ",
                      "<a
                      href=
                      'mailto:lubomir.stepanek@lf1.cuni.cz'
                      >
                      lubomir.stepanek[AT]lf1[DOT]cuni[DOT]cz
                      </a> nebo na ",
                      "<a
                      href=
                      'mailto:lubomir.stepanek@fbmi.cvut.cz'
                      >
                      lubomir.stepanek[AT]fbmi[DOT]cvut[DOT]cz
                      </a> a vše individuálně vyřešíme. ;-)"
                    )),
                    
                    p(
                      "Pokud znáš nebo Tě napadne nějaká pěkná úloha a ",
                      "budeš souhlasit, aby se některý z adventních dnů ",
                      "objevila jako soutěžní, určitě mi taky napiš. ;-)"
                    ),
                    
                    p(
                      "Celkovou mírou, podle které zkusme měřit úspěšnost ",
                      "jednoho uživatele ",
                      "při řešení úloh, ať je"
                    ),
                    
                    withMathJax(),
                    ("$$\\text{power} = \\sum\\limits_{i = 1}^{24}\\frac{b_{i}}{\\max\\{1, p_{i} - 2\\}} ,$$"),
                    
                    withMathJax(),
                    p(HTML(
                      "kde ",
                      "\\( b_{i} \\)",
                      " je počet bodů, které uživatel za řešení ",
                      "\\( i \\)-té ",
                      "úlohy získal ",
                      "(pokud uživatel \\( i \\)-tou ",
                      "úlohu vůbec neřešil, je ",
                      "\\( b_{i} = 0 \\)), ",
                      "a ",
                      "\\( p_{i} \\)",
                      " je počet pokusů, pomocí kolika se snažil uživatel ",
                      "\\( i \\)-tou ",
                      "úlohu vyřešit ",
                      "(pokud uživatel \\( i \\)-tou ",
                      "úlohu vůbec neřešil, je ",
                      "\\( p_{i} = 0 \\)). ",
                      "První tři pokusy tedy nesnižují váhu počtu ",
                      "bodů za úlohu."
                    )),
                    
                    tags$hr(),
                    
                    h4("Počty bodů"),
                    
                    p(
                      "Prázné políčko značí, že řešitel danou úlohu ještě ",
                      "neřešil. Nula v políčku značí, že řešitel se danou ",
                      "úlohu pokusil vyřešit, ale (zatím) se mu to nepovedlo.",
                      " Jednička v políčku znamená, že řešitel úlohu vyřešil ",
                      "správně."
                    ),
                    
                    tableOutput("my_solvers_table_display"),
                    
                    tags$hr(),
                    
                    h4("Počty pokusů"),
                    
                    p(
                      "Je zobrazen nenulový počet pokusů."
                    ),
                    
                    tableOutput("my_solvers_attempts_table_display"),
                    
                    tags$hr()
                    
                ),
                
                
                ## pátá záložka -----------------------------------------------
                
                tabPanel(
                    title = "O aplikaci",
                    value = "about_tab",
                    h3("Náměty a bug reporting"),
                    tags$hr(),
                    p(
                        "Svoje náměty, připomínky, nápady na nové úlohy ",
                        "či upozornění na chyby ",
                        "můžete směřovat na"
                    ),
                    tags$br(),
                    HTML(
                        "<a
                            href = 'https://www.lf1.cuni.cz/kontakty?nContactID=98944#contacts'
                            target = '_blank'
                        ><img
                            src = 'lubomir_stepanek_4.jpg'
                            alt = 'lubomir_stepanek'
                            align = 'middle'
                            width = '160px'
                        ></a>"
                    ),
                    tags$br(),
                    tags$br(),
                    HTML(
                        "<a
                            href=
                            'https://www.lf1.cuni.cz/kontakty?nContactID=98944#contacts'
                            target='_blank'
                        >
                            MUDr. Lubomír Štěpánek
                        </a>"
                    ),
                    tags$br(),
                    tags$br(),
                    paste(
                        "Oddělení biomedicínské statistiky & ",
                        "Centrum informačních technologií",
                        sep = ""
                    ),
                    tags$br(),
                    "Ústav biofyziky a informatiky",
                    tags$br(),
                    "1. lékařská fakulta",
                    tags$br(),
                    "Univerzita Karlova",
                    tags$br(),
                    HTML(
                        "<a
                            href=
                            'mailto:lubomir.stepanek@lf1.cuni.cz'
                        >
                            lubomir.stepanek[AT]lf1[DOT]cuni[DOT]cz
                        </a>"
                    ),
                    tags$br(),
                    tags$br(),
                    "Katedra biomedicínské informatiky",
                    tags$br(),
                    "Fakulta biomedicínského inženýrství",
                    tags$br(),
                    "České vysoké učení technické v Praze",
                    tags$br(),
                    HTML(
                        "<a
                            href=
                            'mailto:lubomir.stepanek@fbmi.cvut.cz'
                        >
                            lubomir.stepanek[AT]fbmi[DOT]cvut[DOT]cz
                        </a>"
                    ),
                    tags$hr(),
                    h3("Kredit"),
                    p(HTML(
                        "Design aplikace je inspirován podobnou, ",
                        "ale rozsáhlejší aplikací ",
                        "<a href=
                        'https://shiny.cs.cas.cz/ShinyItemAnalysis/'
                        target='_blank'
                        ><tt>ShinyItemAnalysis</tt></a>",
                        "vyvíjenou inspirativní ženou a vědkyní",
                        "dr. Patricií Martínkovou a jejím týmem."
                    )),
                    
                    tags$hr()
                    
                )
                
            )
            
        )
        
    )
    
)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################






