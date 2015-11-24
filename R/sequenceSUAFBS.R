# This function provides pages for each sua element with a handsontable on each

sequenceSUAFBS = function(){

tagList(
fluidPage( 
  #fluidRow(h1("Data Collection and Estimation for SUA")),
  
  tags$head(tags$script(includeCSS("www/sequentiallyActiveTabs.css"))),
  
  tabsetPanel("FBS and SUA", selected = 'Start', id = "suaNavlist",
              
              tabPanel("Start",
                       fluidPage(br(),column(9,h3("Welcome!"), br(), br(),
                                             h5("On the following pages, the full supply and
                                                utilization accounts (SUA) as well as the
                                                Food Balance Sheets (FBS) are constructed. Please
                                                choose a country and year on the right side side
                                                of this page for which the FBS construction 
                                                procedure should be applied. Also, please make
                                                sure that you have read the Handbook for FBS. 
                                                You will be requested to provide data which you can
                                                either input manually or upload through csv files. Some
                                                more text, descriptions, links, help etc...")
                                             # verbatimTextOutput("range")
                                             ),
                                 sidebarPanel(width = 3, position = 'right',
                                              h4("Please select:"),
                                              selectInput("FBSSUAarea", 
                                                          "Area:", 
                                                          unique(data$geographicArea), selected = unique(data$geographicArea)[1]
                                              ),
                                              selectizeInput("FBSSUAyear", 
                                                             "Year:", 
                                                             c(unique(sua$timePointYears[sua$timePointYears > 2012]), #we'll only create new FBS
                                                               as.character(as.numeric(max(sua$timePointYears[sua$timePointYears > 2012]))+ 1))
                                              ),
                                              sliderInput("sliderYearRange", sep ="", label = "Time Range", min = as.numeric(min(unique(data$timePointYears))), 
                                                          max = as.numeric(max(unique(data$timePointYears))) + 1 , value = c(2010, 2013)),
                                              helpText("Note: Time Range refers to display", 
                                                       "only. It will not influence any estimation"),
                                              
                                              
                                              actionButton("startContinue", "Start Compilation!", align = 'center', styleclass = "success", block =T)
                                 )
                       )
                       ),
              
              tabPanel("Production",
                       fluidRow(column(4, h3(textOutput("Production"))),
                                column(2, actionButton("productionEst","Estimate Data ", align = 'center', styleclass="primary", block=T)),
                                column(2, actionButton("upload", "Upload File", styleclass="warning",block =T)),       
                                column(2, actionButton("productionVisualize", "Visualize", styleclass="danger",block =T)),
                                column(2, actionButton("productionSave", "Save Production Data", styleclass="success",block =T)) 
                       ),
                       tags$style(type='text/css', "#productionEst { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       tags$style(type='text/css', "#upload { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       tags$style(type='text/css', "#productionVisualize { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       tags$style(type='text/css', "#productionSave { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       bsModal("productionEstimation", "Request additional input for estimation here", "productionEst", size = "large"),
                       bsModal("productionVisual", "Selected Plot", "productionVisualize", size = "large", 
                               plotOutput("plotProduction")),
                       rHandsontableOutput("tableProduction")
              ),
              
              
              
              tabPanel("Trade",
                       fluidRow(column(width = 10, h3("Import and Export Data")), 
                                column(width = 2, actionButton("tradeSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#tradeSave { width:100%; margin-top: 15px; margin-bottom: 15px;}")
                       
              ),
              
              tabPanel("Stocks", 
                       fluidRow(column(width = 10, h3(textOutput("Stocks"))), 
                                column(width = 2, actionButton("stocksSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#stocksSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                       
                       rHandsontableOutput("tableStocks")
              ),
              
              tabPanel("Food",
                       fluidRow(column(width = 10, h3(textOutput("Food Use"))), 
                                column(width = 2,actionButton("foodSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#foodSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                       rHandsontableOutput("tableFood Use")
                       
              ),
              
              tabPanel("Feed", 
                       fluidRow(column(width = 10, h3(textOutput("Feed Use"))), 
                                column(width = 2, actionButton("feedSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#feedSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                       rHandsontableOutput("tableFeed Use")
              ),
              
              tabPanel("Seed", 
                       fluidRow(column(width = 10, h3(textOutput("Seed"))), 
                                column(width = 2, actionButton("seedSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#seedSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                       rHandsontableOutput("tableSeed")
              ),
              
              tabPanel("Food Losses & Waste", 
                       fluidRow(column(width = 10, h3(textOutput("Food Losses & Waste"))), 
                                column(width = 2, actionButton("flwSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#flwSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                       rHandsontableOutput("tableFood Losses & Waste")
              ),
              
              tabPanel("Industrial Use", 
                       fluidRow(column(width = 10, h3(textOutput("Industrial Use"))), 
                                column(width = 2, actionButton("industrialSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#industrialSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                       rHandsontableOutput("tableIndustrial Use")
              ),
              
              tabPanel("Tourist Consumption", 
                       fluidRow(column(width = 10, h3("Tourist Consumption")), 
                                column(width = 2, actionButton("touristSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#touristSave { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       rHandsontableOutput("tableTourist Consumption")
              ),
              
              tabPanel("Residual Other Uses",
                       fluidRow(column(width = 10, h3("Residual Other Uses")), 
                                column(width = 2, actionButton("residualSave", "Save and Continue", styleclass = 'success'))
                       ), tags$style(type='text/css', "#residualSave { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       rHandsontableOutput("tableResidual Other Uses")
              ),
              
              tabPanel("Save All", actionButton("saveSave", "Save and Continue", styleclass = 'success'))
              
              
              )
)
)
}