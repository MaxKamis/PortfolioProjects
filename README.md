# Portfolio Project




##  Table Of Content

- Covid Portfolio Project.sql
- Movie Correlation Project.ipynb
## Covid Portfolio Project.sql

In this project, I did some Data Exploration on the Covid-19 Dataset in SQL Server.

I used coviddeaths_son and covidvaccinations tables to make this analysis. 

I mainly focused to find;

- Highest Infection Rate

- Highest Death Count

- Percent of Population got Covid by Country

- Highest Death Count by Country

- Percentage of Death if you Contact Covid in a Specific Country

- Brake numbers down by Continent

- Global numbers

Then, I merged 2 tables with Join statement to see Total Population vs Vaccinations. 
## Movie Correlation Project.ipynb

In this project, I worked in Python to find correlations between variables.

I used movies.csv dataset to make this anlysis possible.

I found correlations between "budget" and "gross" columns. Then, I created scatter plot.

Lastly, I created heat map to show correleation of related columns such as;

- Runtime
- year
- score
- votes
- budgets 



## Libraries 

```python
import pandas as pd
import seaborn as sns
import numpy as np

import matplotlib 
import matplotlib.pyplot as plt
plt.style.use('ggplot')
from matplotlib.pyplot import figure
```
