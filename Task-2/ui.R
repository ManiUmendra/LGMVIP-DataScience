#Importing Library
library(shiny)
library(shinydashboard)

#Using Shiny Package to Create GUI for data representation
shinyUI(
  #Creating Dashboard Page
  dashboardPage(
    dashboardHeader(title='Exploratorey Data Analysis of Terrorism Dataset'),
    
    #Creation of Dashboard Sidebar
    dashboardSidebar(
      sidebarMenu(
        #Menuitems for Sidebar Panel
        menuItem(tabName='About',text='About Original Data',
                 menuSubItem(tabName='Data',text='Data',icon=icon('code')),
                 menuSubItem(tabName='Summary',text='Summary',icon=icon('clipboard')),
                 menuSubItem(tabName='Structure',text='Structure',icon=icon('database'))
                ),
        menuItem(tabName='AfterClean',text='Data After Cleaning',
                 menuSubItem(tabName='DataAfterClean',text='Data',icon=icon('code')),
                 menuSubItem(tabName='StrAfterClean',text='Structure',icon=icon('clipboard'))
                ),
        menuItem(tabName='Analysis',text='Analysis',
                 menuSubItem(tabName='Bar',text='Bar'),
                 menuSubItem(tabName='Casualities',text='Casuality analysis'),
                 menuSubItem(tabName='Explosive',text='Explosive'),
                 menuSubItem(tabName='Group',text='Terrorist Groups')
                # menuSubItem(tabName='grp2',text='Prominent Region')
                 )
    
    )),
    #Creating Dashbordbody where data will be shown
    dashboardBody(
      #Tab creation in each dashboard for embdding our data in them
      tabItems(
        tabItem(tabName='Data',helpText('Original Dataset'),tableOutput('odata')),
        tabItem(tabName='Summary',helpText('Summary  Of Original Dataset'),verbatimTextOutput('summ')),
        tabItem(tabName='Structure',helpText('Structure Of Original Dataset'),verbatimTextOutput('strr')),
        #After Clean
        tabItem(tabName='DataAfterClean',helpText('Dataset After Cleaning'),tableOutput('datC')),
        tabItem(tabName='StrAfterClean',helpText("Structure"),verbatimTextOutput('strrC')),
        
        #For Analysis
        tabItem(tabName='Bar',
                tabsetPanel(type='pills',
                  tabPanel('Attacks',plotOutput('bar')),
                  tabPanel('Country Affected',plotOutput('con')),
                  tabPanel('Hotspot',plotOutput('hot'))
                )
                ),
        tabItem(tabName='Casualities',
                tabsetPanel(type='pills',
                            tabPanel('Analysis1',plotOutput('cas1')),
                            tabPanel('Analysis2',plotOutput('cas2')))
                
                ),
        tabItem(tabName='Explosive',
                tabsetPanel(
                  tabPanel('Analysis1',plotOutput('exp1')),
                  tabPanel('Analysis2',plotOutput('exp2'))
                )
                ),
        tabItem(
          tabName='Group',
          tabsetPanel(
            tabPanel('Analysis1',helpText('In the dataset there are total number of 3537 Terrorist group
                                          and it is not possible to give the detail of all group.Hence, only data of 
                                           prominent terrorist group is providing.'),plotOutput('group1')),
            tabPanel('Analysis2',tableOutput('group2'))
          )
        )
      )
    )
  )
)