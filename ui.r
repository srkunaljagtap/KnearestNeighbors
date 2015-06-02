
library(shinydashboard)
library(shiny)

dashboardPage(
  dashboardHeader(title = "K Nearest Neighbors"),
  
  sidebar <- dashboardSidebar(
    #sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                      #label = "Search..."),
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Select Inputs", tabName = "Input1",icon = icon("th")),
      menuItem("Selected Data", tabName = "Output",icon = icon("bars")),
      menuItem("plots", tabName = "plot",icon = icon("bar-chart")),
      menuItem("Summary", tabName = "Summary",icon = icon("list")),
      menuItem("Contact Info", tabName = "contact",icon = icon("linkedin"))
    )

  ),
  
#   dashboardBody()
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
        wellPanel(
          h3(strong('K Nearest Neighbors',align = "center",style = "color:skyblue")),
         h4('This is a simple web app for K nearest neighbors algorithm.'),
         h4('Default selected data set is iris flower data set.'),
         h4('You can upload your own data set from select inputs option.'),
         helpText('Note that: this KNN algorithm will find out two most largest possible variance features using Principal component analysis (PCA) if your data set has more than two features.'),
         br()
        ),
        wellPanel(
        
         h4(strong('KNN algorithm:')),
         h4('In pattern recognition, the k-Nearest Neighbors algorithm (or k-NN for short) is a non-parametric method used for classification and regression. In both cases, the input consists of the k closest training examples in the feature space. The output depends on whether k-NN is used for classification or regression.'),
         h4('The training examples are vectors in a multidimensional feature space, each with a class label. The training phase of the algorithm consists only of storing the feature vectors and class labels of the training samples.

In the classification phase, k is a user-defined constant, and an unlabeled vector (a query or test point) is classified by assigning the label which is most frequent among the k training samples nearest to that query point.')
         )      
              
              ),
      
      tabItem(tabName = "Input1",
              
       
#            textInput("Id", "Label"),
           checkboxInput('header','Header', value = F),
           checkboxInput('default','Default Data Set', value = T),
           br(),
           radioButtons('sep', 'separator', c(comma = ',', semicolon = ';', tab = '\t'), selected = NULL, inline = FALSE),
           br(),
           fileInput('data', 'Choose file to upload', multiple = FALSE, accept = c('.text/ comma-separated-values',
                                                                        '.csv',
                                                                        '.xlsx',
                                                                        '.txt',
                                                                        '.text/ tab-separated-values')),
           helpText('Deselect default data set when you upload your data set'),

           br(),

           numericInput("traindata", "select Percentage of training data:", 80,min = 1, max = 100),
           helpText("Here, select the percent of data set you would want as a training data for KNN"),
           br(),
           numericInput("obs", "Observations:", 150,min = 1, max = 100),

           numericInput("Kvalue", "value of K:", 3,min = 1, max = 100)
          ),
      
      
      
      tabItem(tabName = "Output",
              
              tabPanel("Table", tableOutput("table"))
              
              ),
      tabItem(tabName = "plot",
              tabPanel("Plot",plotOutput("plot"))    
              
        ),
      
      tabItem(tabName = "Summary",
              h4('Summary of total data'),
              tabPanel("Summary", verbatimTextOutput("summary")),
              h4('Summary of test data'),
              tabPanel("KNNSummary", verbatimTextOutput("KNNSummary")),
              helpText('This summary shows the selected labels for test samples.')
      ),
#      
      
      tabItem(tabName = "contact",
              wellPanel(
                h5(strong("Contact Info:")),
                h5("Kunal Jagtap"),
                helpText(   a("View My LinkedIn Profile",href="https://www.linkedin.com/in/kunaljagtap")),
                helpText(   a("View codes",href="https://github.com/srkunaljagtap/KnearestNeighbors.git")),
              helpText("srkunaljagtap@gmail.com"))
              )
  )
)
)
