-- ============================================================
-- Project: U.S. Electric Vehicle Market Share Analysis
-- Database Engine: MySQL Workbench
-- Author: Ravindu Weerasekara
-- ============================================================

-- ------------------------------------------------------------
-- STEP 1: Schema Setup & Data Loading
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS ev_analysis;
USE ev_analysis;

-- Table Creation
CREATE TABLE IF NOT EXISTS vehicle_data (
    State VARCHAR(50),
    Electric_EV INT,
    PlugIn_Hybrid_PHEV INT,
    Hybrid_HEV INT,
    Biodiesel INT,
    Ethanol_Flex_E85 INT,
    Compressed_Natural_Gas_CNG INT,
    Propane INT,
    Hydrogen INT,
    Methanol INT,
    Gasoline INT,
    Diesel INT,
    Unknown_Fuel INT
);

-- Bulk Ingestion via Secure Server Directory
LOAD DATA INFILE '/path/to/secure_uploads/VehicleData_Cleaned.csv'
INTO TABLE vehicle_data
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- ------------------------------------------------------------
-- QUERY 1: Adoption Rates & Top 5 EV States
-- Objective: Calculate overall market share & identify leaders
-- ------------------------------------------------------------
SELECT 
    State,
    Electric_EV,
    (Electric_EV + PlugIn_Hybrid_PHEV + Hybrid_HEV + Biodiesel + 
     Ethanol_Flex_E85 + Compressed_Natural_Gas_CNG + Propane + 
     Hydrogen + Methanol + Gasoline + Diesel + Unknown_Fuel) AS Total_Vehicles,
    ROUND((Electric_EV / (Electric_EV + PlugIn_Hybrid_PHEV + Hybrid_HEV + Biodiesel + 
     Ethanol_Flex_E85 + Compressed_Natural_Gas_CNG + Propane + 
     Hydrogen + Methanol + Gasoline + Diesel + Unknown_Fuel)) * 100, 2) AS EV_Adoption_Rate_Pct
FROM vehicle_data
ORDER BY EV_Adoption_Rate_Pct DESC
LIMIT 5;


-- ------------------------------------------------------------
-- QUERY 2: The Big State Comparison
-- Objective: Benchmark California against lagging mega-states
-- ------------------------------------------------------------
SELECT 
    State,
    Electric_EV,
    ROUND((Electric_EV / (Electric_EV + PlugIn_Hybrid_PHEV + Hybrid_HEV + Gasoline + Diesel)) * 100, 2) AS EV_Adoption_Rate_Pct
FROM vehicle_data
WHERE State IN ('California', 'Texas', 'Florida', 'New York')
ORDER BY EV_Adoption_Rate_Pct DESC;


-- ------------------------------------------------------------
-- QUERY 3: Analyzing Alternative Fuel Mix
-- Objective: Differentiate high-volume alternative fuels from niche usage
-- ------------------------------------------------------------
SELECT 
    SUM(Ethanol_Flex_E85) AS Total_Ethanol_Vehicles,
    SUM(Biodiesel) AS Total_Biodiesel_Vehicles,
    SUM(Hydrogen) AS Total_Hydrogen_Vehicles
FROM vehicle_data;
