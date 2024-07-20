
# Hi, I'm Sai Magar! 👋


## 🚀 About Me
I'm a Data Scientist Enthusiast--


# Real Estate Market Prognostication:  

An R project leveraging the Shiny library to create interactive web applications for predicting real estate market trends. This project employs linear regression methods to analyze historical data and generate accurate market forecasts. The repository includes all necessary scripts, datasets, and thorough documentation to facilitate detailed analysis and comprehensive market predictions.




## Features

- Interactive Interface: Users can input various parameters such as estate type, number of bedrooms, total square feet, and more to predict the price of an estate.
- Dynamic Visualizations: Includes scatter plots and inflation projections to visualize data and predicted trends.
- Custom Styling: Enhanced UI with custom CSS to provide a visually appealing user experience.

## Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/Bangalore-Estate-Price-Prediction.git
cd Bangalore-Estate-Price-Prediction
```

Install the required packages in R:

```bash
install.packages("shiny")
```

Ensure the dataset (new house data 2.csv) is placed in the correct path:

```bash
C:/Users/magar/Downloads/House_Price_Prediction-main/House_Price_Prediction-main/

```
    
## Usage

Run the Shiny application:

```bash
library(shiny)
runApp("path_to_your_app")
```
Access the application in your web browser:

```bash
http://127.0.0.1:3838/

```


## Project Structure

- ui.R: Contains the user interface definition.
- server.R: Contains the server logic and model predictions.
- www/: Directory containing custom CSS and other assets.
- data/: Directory containing the dataset used for predictions.
## Prediction Methodology

The application uses linear regression to predict the price of an estate based on the following inputs:

- Estate Type
- Estate ID
- Pin Code
- Number of Bedrooms
- Total Square Feet
- Number of Bathrooms
- Number of Balconies
## Contributing

Contributions are always welcome!

See `contributing.md` for ways to get started.

`feel free to open an issue or submit a pull request`.


## Screenshots

![App Screenshot](https://media.licdn.com/dms/image/D562DAQFW5XWZrszAMg/profile-treasury-image-shrink_800_800/0/1721501808029?e=1722106800&v=beta&t=P2WurXElnf-L1nv3oRJta70vwekEDGmWwlG8cvIJaas)

![App Screenshot](https://media.licdn.com/dms/image/D562DAQHWuTo1UuDBwQ/profile-treasury-image-shrink_800_800/0/1721501828403?e=1722106800&v=beta&t=j7BRdH1Kzz0AibL0grAy7shIzKBVyso3zO2U-2rN-0Q)




## License

This project is licensed under the MIT License. See the LICENSE file for details.




## FAQ

#### What is the purpose of this project?

The project aims to predict real estate prices in Bangalore using an interactive web application built with R and Shiny. It employs linear regression models to provide accurate price forecasts based on various input parameters.

#### How do I run the application?

To run the application, ensure you have R and the Shiny library installed. Clone the repository, set up the required dataset, and run the app using the runApp function. Detailed instructions are provided in the Installation and Usage sections of the README.

#### What is the inflation rate used in the prediction?
The application uses a default inflation rate of 3% per year to project future prices. This rate can be adjusted in the server logic if needed.

#### How does the application visualize the data?

The application includes scatter plots to show the relationship between total square feet and price. It also includes a plot to show the effect of inflation on future prices based on the current predicted price.
.
#### How is the predicted price calculated?

The predicted price is calculated using a linear regression model that takes into account the input parameters provided by the user. The model is trained on historical data to generate accurate predictions.
