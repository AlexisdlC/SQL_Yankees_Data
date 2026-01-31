# Introduction

⚾ The goal of this project is to build a Data Warehouse system gathering the pitching and batting data of all Yankees' games since 1950.

🐍 The data is available in the ['source_data'](source_data/) folder and was obtained, gathered and pre-filtered separately using python and the [MLB-statsapi](https://github.com/toddrob99/MLB-StatsAPI/tree/master) package.

🗽 One important note: the data shown is for New York Yankees games only, so when looking at specific individual players, the totals shown are not their career total or averages, but it is limited to only the games they played with the Yankees (except of course if they spent their whole career with the Yankees)

# Background

🏟️ Passionate about data and about the Yankees, I wanted to take the opportunity to join my two passions and use baseball statistics to practice and train my skills in building a proper data pipeline.

### My main goals with this project:

* Build a database gathering basic batting and pitching statistics, teams, games and players' information. 📊
* Build interactive dashboards to explore different aspects of the data 📉
* Share my work with others, using as much French as possible in the dashboard, as my main target audience is baseball fans from France 🇫🇷
* Develop my skills in data analytics tools and build best practice habits

### Who Am I?

My name is **Alexis** and I am a Physics PhD with a passion for Data and Baseball. I am also on Twitter behind the account @PinstripesFr, where I provide news, updates, visuals and analysis about the New York Yankees in French. Don't hesitate to contact me if you have questions, ideas or suggestions!

[![text](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/alexisdlc/)
[![text](https://img.shields.io/badge/X-000000?style=for-the-badge&logo=x&logoColor=white)](https://x.com/PinstripesFr)


# Tools I Used

To develop this project, I used three main tools:

* **Python**: I used Python in order to query the MLB API through the [MLB-statsapi](https://github.com/toddrob99/MLB-StatsAPI/tree/master) package, gather and pre-process the data which was then stored in CSV files. The code for this first step is not included in this repository.
* **SQL**: Then, I used SQL to build a simple data warehouse with multiple layers to load, process, transform and clean the tables. The code for this step is the core content of this repository.
* **Power BI**: Finally, I loaded the database final layer into PowerBI and used Power Query and Dax to build several pages of an interactive dashboard allowing users to explore the data in different ways. The Power BI file is provided in the repository.

# Data Warehouse Structure

The Data Warehouse was built in SQL using *SQL Server*, and in the *"Medaillon Structure"*.

## Bronze Layer

The **_Bronze Layer_** is used to load the unprocessed data from the source CSV files, with no transformations. The data is stored in tables using the *"Truncate and Insert"* method and no data model is applied at that stage.

## Silver Layer

The **_Silver Layer_** is used to store clean, processed and transformed data. The data is loaded using the *"Truncate and Insert"* method from the Bronze Layer. The data is stored in tables, cleaned, normalized, enriched and standardized.

## Gold Layer

The **_Gold Layer_** is the final layer of the Data Warehouse, with ready to use data for reporting and analytics. The data is stored in Views, with a Star Schema Model.

![Architecture of the model of the Gold Layer](/assets/DataModelv2.png)

# Dashboards

The dashboards were built by connecting and loading the **_Gold Layer_** to **Power BI**. Power Query was used to transform some of the data (translating some terms to French for example) and DAX was used as well to build Measures allowing for a responsive experience.

The **Power BI** file is provided in the repository, and contains several pages. It can also be accessed using this link: [Dashboard](https://tinyurl.com/NYYDashboard)

## Statistiques Globales
![Screenshot of the Dashboard Page, "Statistiques Globales"](/assets/StatistiquesGlobales.PNG)

This page of the dashboard presents global statistics about the Yankees' team record. In the center of the page are two slicers that can be used to filter the data:

* A *Date Slicer*, going year by year between 1950 and 2025, to filter the range of the data that is presented in the whole page
* A *Game Type Slicer*, with five options (Regular, Wild Card, ALDS, ALCS, World Series), to filter the data based on the stage of the season the games were played

The top row of the page shows the global Win/Loss record of the Yankees for the selected time period and type of games:
* A donut chart shows the global Win and Loss percentages
* A stacked column chart shows the same record, but broken up by season, with a horizontal line indicating the 50% Win mark

Below this, there is a stacked bar chart decomposing the Win/Loss record by opponent. This graph can be interesting to interact with, as clicking on a team name will further filter the data of the page to show the global record and season by season record for the selected team. It also filters the two tables next to it, where basic batting and pitching stats are presented.

## Statistiques Leaders - Régulière / Playoffs
![Screenshot of the Dashboard Page, "Statistiques Leaders Regulière"](/assets/StatistiquesLeadersRegulière.PNG)

This page of the dashboard presents detailed statistical analysis, for the team, batters and pitchers, limited to regular season games only, and as indicated on the page, showing only batters with a minimum of 400 at bats and pitchers with at least 50 innings pitched.

The page is divided in two halves, one for batting stats, and the second one for pitching stats. There is one *Date Slicer*, going year by year between 1950 and 2025, to filter the range of the data that is presented in the whole page.

The left side presents batting data, with a slicer allowing to select a statistic that will be presented in the two graphs below:
* A bar chart, showing the individual leaders in the selected statistic.
* A line chart, showing the team season by season trend of the selected statistic.

The right side is similar to the left side, but for pitching stats. Note, the ordering of the bar chart can/should be reversed when certain statistics are selected. This can be done using the "..." icon on top of the graph ('More Options') and the "Sort Axis" sub-menu.

![Screenshot of the Dashboard Page, "Statistiques Leaders Playoffs"](/assets/StatistiquesLeadersPlayoffs.PNG)

The next page has the exact same structure and slicers, but it is filtered to present only data for all postseason games. The minimum at bats and innings pitched have also been lowered to 20 and 10 respectively.

## Comparaison Joueurs - Frappeurs / Lanceurs
![Screenshot of the Dashboard Page, "Comparaison Joueurs Frappeurs"](/assets/ComparaisonJoueursFrappeurs.PNG)

This pages allows users to compare the batting stats of two players. Both players can be selected from dropdown slicers (with a search bar available) and the table below each slicer will update with common batting stats for the player. 

On the left side of the page, a slicer is available to select a batting statistic, and the two line charts will update to show the season by season trend of the selected statistic for each player.

![Screenshot of the Dashboard Page, "Comparaison Joueurs Lanceurs"](/assets/ComparaisonJoueursLanceursv2.PNG)

This pages is the same as the previous one, but for pitching stats.
