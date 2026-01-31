# Introduction

⚾ The goal of this project is to build a Data Warehouse system gathering the pitching and batting data of all Yankees' games since 1950.

🐍 The data is available in the ['source_data'](source_data/) folder and was obtained, gathered and pre-filtered separately using python and the [MLB-statsapi](https://github.com/toddrob99/MLB-StatsAPI/tree/master) package.

# Background

🏟️ Passionate about data and about the Yankees, I wanted to take the opportunity to join my two passions and use baseball statistics to practice and train my skills in building a proper data pipeline.

### My main goals with this project:

* Build a database gathering basic batting and pitching statistics, teams, games and players' information. 📊
* Build interactive dashboards to explore different aspects of the data 📉
* Share my work with others, using as much French as possible in the dashboard, as my main target audience is baseball fans from France 🇫🇷
* Develop my skills in data analytics tools and build best practice habits

# Tools I Used

To develop this project, I used three main tools:

* **Python**: I used Python in order to query the MLB API through the [MLB-statsapi](https://github.com/toddrob99/MLB-StatsAPI/tree/master) package, gather and pre-process the data which was then stored in CSV files. The code for this first step is not included in this repository.
* **SQL**: Then, I used SQL to build a simple data warehouse with multiple layers to load, process, transform and clean the tables. The code for this step is the core content of this repository.
* **Power BI**: Finally, I loaded the database final layer into PowerBI and used Power Query and Dax to build several pages of an interactive dashboard allowing users to explore the data in different ways. The Power BI file is provided in the repository.

# Data Warehouse Structure

The Data Warehouse built in SQL was built in the "medaillon structure".

## Bronze Layer

The **_Bronze Layer_** is used to load the unprocessed data from the source CSV files, with no transformations. The data is stored in tables using the *"Truncate and Insert"* method and no data model is applied at that stage.

## Silver Layer

The **_Silver Layer_** is used to store clean, processed and transformed data. The data is loaded using the *"Truncate and Insert"* method from the Bronze Layer. The data is stored in tables, cleaned, normalized, enriched and standardized.

## Gold Layer

The **_Gold Layer_** is the final layer of the Data Warehouse, with ready to use data for reporting and analytics. The data is stored in Views, with a Star Schema Model.



# Dashboards
