# U.S. Electric Vehicle Market Share Analysis 

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black) ![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white) ![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white) 

**Author:** Ravindu Weerasekara  
**Background:** MS in Applied Economics, University of Cincinnati 

## Executive Summary
This project analyzes the electric vehicle (EV) and alternative fuel landscape across 51 U.S. states and territories to identify market penetration disparities and inform infrastructure policy. By engineering a local MySQL database pipeline and constructing an interactive Power BI dashboard, the analysis processes over 287 million registered vehicles to uncover regional adoption gaps. 

The findings highlight a critical disconnect between total vehicle density and EV adoption, specifically identifying massive pent-up demand in lagging mega-states like Texas, New York, and Florida.

## Tech Stack & Environment
* **Data Preprocessing:** Microsoft Excel (Generalizing numeric formats, stripping thousand separators)
* **Database Management:** MySQL Workbench (v26.7.0)
* **Data Visualization:** Power BI Desktop (September 2026 release)
* **Languages:** SQL, DAX

## Data Engineering Pipeline

### 1. Database Configuration & Secure File Handling
To bypass client-side security restrictions (Error 2068) commonly encountered when bulk-loading data via standard GUI tools, I utilized MySQL's native server-side `Uploads` directory. This approach mirrors enterprise-level secure file staging.
```sql
-- Extracted CSV loaded via secure server path to circumvent LOCAL INFILE restrictions
LOAD DATA INFILE '/path/to/secure_uploads/VehicleData_Clean.csv'
INTO TABLE vehicle_data
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

2. SQL Analytical Queries

Core data aggregations were executed natively in MySQL before visualization to validate metric accuracy.

    Adoption Rate Calculation: Aggregated total EV volumes against total state vehicle counts to calculate true market share percentages.

    Mega-State Comparisons: Filtered high-population states (CA, TX, FL, NY) to contrast infrastructure leaders against market laggards.

    Alternative Fuel Mix: Summed nationwide totals for E85, Biodiesel, and Hydrogen to separate statistically significant fuel types from niche markets.

3. Visual Dashboard Architecture

The Power BI report was designed using strict information design principles to minimize cognitive load and deliver executive-ready insights.

    Dynamic KPI Banner: Features interactive cards (Total EVs, National Adoption Rate, Total Vehicles) that cross-filter based on geospatial selection.

    Geospatial Mapping: Utilizes a custom gradient filled map to highlight localized adoption density.

    Data-to-Ink Optimization: Standard Power BI visuals were stripped of redundant axes, utilizing clean data labels and high-contrast color palettes (Primary Blue vs. Neutral Grays) to direct viewer attention.

Strategic Insights & Recommendations

    Target High-Volume, Low-Adoption States: Texas (0.89%), New York (1.16%), and Florida (1.37%) severely lag California (3.41%) despite massive total vehicle fleets. Prioritize federal Level-3 fast-charging grants along major transit corridors in these three states to unlock pent-up EV demand.

    Reallocate Hydrogen Capital to BEVs: Hydrogen accounts for a negligible 0.07% of the alternative fuel market. Reallocate public subsidies and private capital away from consumer hydrogen refueling stations toward battery-electric vehicle (BEV) charging grid expansion.

    Convert Ethanol Users to Pure EVs: Ethanol (E85) commands 87.77% of alternative fuel vehicles (20M+). Target high-E85 regions with trade-in incentives to convert transitional alternative-fuel drivers into zero-emission BEV owners.

Repository Contents

    SQL_Queries/: Contains the DDL table creation scripts, secure bulk-load commands, and the three primary analytical queries.

    Dashboard/: The .pbix Power BI file and a high-resolution PDF export of the final executive dashboard.

    Data/: The raw and cleaned CSV datasets utilized for the analysis.
