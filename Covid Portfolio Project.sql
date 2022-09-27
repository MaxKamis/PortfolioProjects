USE project;

SELECT *
FROM coviddeaths_son
order by 3,4

# Select Data that we are going to using

SELECT location, date, total_cases, new_cases, population
FROM coviddeaths_son
WHERE Continent is not null

# Looking at Total Cases vs Total Deaths
# Shows likelihood of dying if you contact covid in a specific country 

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Pct
FROM coviddeaths_son
WHERE Continent is not null
order by 1,2

# Looking at Total Cases vs Population
# Shows what percent of population got Covid

SELECT location, date, total_cases, Population, (total_cases/Population)*100 AS Confirmed_cases_byPopulation
FROM coviddeaths_son
WHERE Continent is not null
order by 1,2

# Looking at Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/Population))*100 AS Pct_Population_Infected
FROM coviddeaths_son
WHERE Continent is not null
Group by location, population
order by Pct_Population_Infected desc

# Showing Countries Highest Death Count per Population

SELECT location, MAX(cast(total_deaths as SIGNED)) as TotalDeathCount 
FROM coviddeaths_son
WHERE Continent is not null
Group by location
order by TotalDeathCount desc

# Let's brake things down by Continent
# Showing continents with the highest death count
SELECT continent, MAX(cast(total_deaths as SIGNED)) as TotalDeathCount 
FROM coviddeaths_son
WHERE Continent is not null
Group by continent
order by TotalDeathCount desc

# Global Numbers

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS SIGNED)) as total_deathsc, SUM(CAST(total_deaths AS SIGNED)) / 
SUM(new_cases) as DeathPercentage
FROM coviddeaths_son
WHERE Continent is not null
#Group by date
order by 1,2

# Looking at Total Population vs Vaccinations
     
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(SIGNED, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM coviddeaths_son dea
JOIN covidvaccinations vac
     On dea.location = vac.location
     and dea.date = vac.date
Where dea.continent is not null 
Order by 2,3          

# Use CTE 

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(SIGNED, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM coviddeaths_son dea
JOIN covidvaccinations vac
     On dea.location = vac.location
     and dea.date = vac.date
Where dea.continent is not null 
#Order by 2,3          
)
Select * , (RollingPeopleVaccinated/Population)*100
From PopvsVac

# Temp Table

Drop Table if exists PercentPopulationsVaccinated
Create Table PercentPopulationsVaccinated
(
Continent nvarchar(255)
Location nvarchar(255)
Date datetime
Population numeric
New_Vaccinations numeric
RollingPeopleVaccinated numeric
)

Insert into 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(SIGNED, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM coviddeaths_son dea
JOIN covidvaccinations vac
     On dea.location = vac.location
     and dea.date = vac.date
Where dea.continent is not null 
#Order by 2,3         

Select * , (RollingPeopleVaccinated/Population)*100
From PercentPopulationsVaccinated

#Creating View to share data for later visualizations

Create view PercentPopulationsVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(SIGNED, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM coviddeaths_son dea
JOIN covidvaccinations vac
     On dea.location = vac.location
     and dea.date = vac.date
Where dea.continent is not null 
#Order by 2,3         