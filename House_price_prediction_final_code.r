library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(HTML(
      '
      body {
        background-image: url("https://www.mymove.com/wp-content/uploads/2020/03/exterior-house-color-hero.jpg");
        background-size: cover;
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-position: center;
        background-color: #87CEEB; 
      }
      .header-panel-text {
        color: #f0f0f0; 
        text-shadow: 2px 2px 4px #000000;
        font-size: 24px;
        font-weight: bold;
        text-align: center;
      }
      .main-panel-text {
        color: #ffffff;
        background-color: rgba(0, 0, 0, 0.5);
        padding: 10px;
        border-radius: 5px;
        font-size: 18px;
        font-weight: bold;
      }
      .predicted-price {
        color: #ffeb3b;
        background-color: rgba(0, 0, 0, 0.8);
        padding: 20px;
        border-radius: 10px;
        font-size: 24px;
        font-weight: bold;
        text-align: center;
        margin: 20px 0;
      }
      .btn-predict {
        background-color: #1E90FF;
        color: #ffffff;
        font-size: 16px;
        font-weight: bold;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }
      .btn-predict:hover {
        background-color: #1C86EE;
      }
      .sidebar-panel {
        background-color: rgba(255, 255, 255, 0.7);
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      }
      .sidebar-label {
        font-size: 16px;
        font-weight: bold;
        color: #333333;
      }
      .sidebar-input {
        width: 100%;
        padding: 8px;
        border: 1px solid #cccccc;
        border-radius: 5px;
        margin-bottom: 10px;
        font-size: 14px;
      }
      '
    ))
  ),
  
  headerPanel(div(class = "header-panel-text", "Bangalore Estate Price Prediction")),
  
  sidebarLayout(
    sidebarPanel(
      div(class = "sidebar-panel",
          div(class = "sidebar-label", "Estate Type"),
          selectInput("area", "", 
                      choices = list("Residential Apartment Estate 1",
                                     "Villa Communities Estate 4",
                                     "Town House and Row house Estate 3",
                                     "Luxury Residential Estate 2")),
          div(class = "sidebar-label", "Estate ID"),
          textInput("area_id", "", ""),
          div(class = "sidebar-label", "Pin Code"),
          textInput("location_id", "", ""),
          div(class = "sidebar-label", "Number of Bedrooms"),
          textInput("bhk", "", ""),
          div(class = "sidebar-label", "Total Square Feet"),
          textInput("sqft", "", ""),
          div(class = "sidebar-label", "Number of Bathrooms"),
          textInput("bath", "", ""),
          div(class = "sidebar-label", "Number of Balconies"),
          textInput("balcony", "", ""),
          actionButton('go', "Predict Estate Price", class = "btn-predict")
      )
    ),
    
    mainPanel(
      headerPanel(div(class = "main-panel-text", "The Price Of an Estate IS:")),
      div(class = "predicted-price", 
          h3("Predicted Price:"),
          textOutput("value")),
      plotOutput("scatter_plot"),
      plotOutput("inflation_plot")
    )
  )
)

server <- function(input, output) {
  calculate_inflation <- function(amount, rate, years) {
    future_values <- numeric(length = years)
    for (i in 1:years) {
      amount <- amount * (1 + rate)
      future_values[i] <- amount
    }
    return(future_values)
  }
  
  data2 <- reactiveValues()
  
  observeEvent(input$go, {
    
    data <- read.csv("C:/Users/magar/Downloads/House_Price_Prediction-main/House_Price_Prediction-main/new house data 2.csv")
    
    data$area_type <- as.factor(data$area_type)
    data$location <- as.factor(data$location)
    
    Use_Data <- data[,c("area_type", "location", "size", "total_sqft", "bath", "balcony", "price")]
    na_clean_data <- na.omit(Use_Data)
    
    area.type <- sapply(na_clean_data$area_type, as.numeric)
    data.location <- sapply(na_clean_data$location, as.numeric)
    
    second_final <- cbind(na_clean_data, area_id = area.type)
    second_main_dataset <- cbind(second_final, location_id = data.location)
    
    Main_data_set <- second_main_dataset[,c("area_type", "area_id", "location", "location_id", "size", "total_sqft", "bath", "balcony", "price")]
    
    inputdata <- Main_data_set[,c("area_id", "location_id", "size", "total_sqft", "bath", "balcony", "price")]
    
    data2$myarea_id <- as.numeric(input$area_id)
    data2$myloaction_id <- as.numeric(input$location_id)
    data2$mybhk <- as.numeric(input$bhk)
    data2$mysqft <- as.numeric(input$sqft)
    data2$mybath <- as.numeric(input$bath)
    data2$mybalcony <- as.numeric(input$balcony)
    
    newPredict <- data.frame(area_id = data2$myarea_id, location_id = data2$myloaction_id,
                             size = data2$mybhk, total_sqft = data2$mysqft,
                             bath = data2$mybath, balcony = data2$mybalcony)
    
    model <- lm(price ~ area_id + location_id + size + total_sqft + bath + balcony,
                data = inputdata, weights = 1/inputdata$price^1.9)
    
    data2$op <- predict(model, newPredict)
    
    # Plot the scatter plot
    output$scatter_plot <- renderPlot({
      plot(inputdata$total_sqft, inputdata$price, main = "Total Square Feet vs Price",
           xlab = "Total Square Feet", ylab = "Price", col = "blue", pch = 19)
      abline(model, col = "red", lwd = 2)
    })
    
    inflation_rate <- 0.03  # 3 percent inflation rate
    current_price <- data2$op
    years <- 2023:2030
    future_prices <- calculate_inflation(current_price, inflation_rate, length(years))
    
    # Plot the inflation
    output$inflation_plot <- renderPlot({
      plot(years, future_prices, type = "o", col = "blue", lwd = 2,
           xlab = "Year", ylab = "Price", main = "Effect of Inflation on Estate Price",
           xaxt = "n")
      axis(1, at = years)
    })
  })
  
  output$value <- renderPrint({ data2$op })
}

shinyApp(ui, server)