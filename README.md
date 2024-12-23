# Azure End-to-End Data Engineering Real-Time Project
This project is a data engineering pipeline solution to a made-up business problem, created to aid in my learning and understanding of data pipelining.

## Project Overview

This project addresses a critical business need by building a comprehensive data pipeline on Azure. The goal is to extract customer and sales data from an on-premises SQL database, transform it in the cloud, and generate actionable insights through a Power BI dashboard. The dashboard will highlight key performance indicators (KPIs) related to gender distribution and product category sales, allowing stakeholders to filter and analyze data by date, product category, and gender.

## Business Requirements

The business has identified a gap in understanding customer demographics—specifically gender distribution—and how it influences product purchases. The key requirements include:

1. **Sales by Gender and Product Category**: A dashboard showing the total products sold, total sales revenue, and a gender split among customers.
2. **Data Filtering**: Ability to filter the data by product category, gender, and date.
3. **User-Friendly Interface**: Stakeholders should have access to an easy-to-use interface for making queries.

## Solution Overview

To meet these requirements, the solution is broken down into the following components:

1. **Data Ingestion**: 
    - Extract customer and sales data from an on-premises SQL database.
    - Load the data into Azure Data Lake Storage (ADLS) using Azure Data Factory (ADF).

2. **Data Transformation**:
    - Use Azure Databricks to clean and transform the data.
    - Organize the data into Bronze, Silver, and Gold layers for raw, cleansed, and aggregated data respectively.

3. **Data Loading and Reporting**:
    - Load the transformed data into Azure Synapse Analytics.
    - Build a Power BI dashboard to visualize the data, allowing stakeholders to explore sales and demographic insights.

4. **Automation**:
    - Schedule the pipeline to run daily, ensuring that the data and reports are always up-to-date.

## Technology Stack

- **Azure Data Factory (ADF)**: For orchestrating data movement and transformation.
- **Azure Data Lake Storage (ADLS)**: For storing raw and processed data.
- **Azure Databricks**: For data transformation and processing.
- **Azure Synapse Analytics**: For data warehousing and SQL-based analytics.
- **Power BI**: For data visualization and reporting.
- **Azure Key Vault**: For securely managing credentials and secrets.
- **SQL Server (On-Premises)**: Source of customer and sales data.

## Setup Instructions

### Prerequisites

- An Azure account with sufficient credits.
- Access to an on-premises SQL Server database.

### Step 1: Azure Environment Setup

1. **Create Resource Group**: Set up a new resource group in Azure.
2. **Provision Services**:
   - Create an Azure Data Factory instance.
   - Set up Azure Data Lake Storage with `bronze`, `silver`, and `gold` containers.
   - Set up an Azure Databricks workspace and Synapse Analytics workspace.
   - Configure Azure Key Vault for secret management.

### Step 2: Data Ingestion

1. **Set up SQL Server**: Install SQL Server and SQL Server Management Studio (SSMS). Restore the AdventureWorks database.
2. **Ingest Data with ADF**: Create pipelines in ADF to copy data from SQL Server to the `bronze` layer in ADLS.

### Step 3: Data Transformation

1. **Mount Data Lake in Databricks**: Configure Databricks to access ADLS.
2. **Transform Data**: Use Databricks notebooks to clean and aggregate the data, moving it from `bronze` to `silver` and then to `gold`.

#### **Before and After Schema**

![ER_Diagram](https://github.com/user-attachments/assets/c6ea0240-db77-48fb-baf9-ca3c0fc08298)

##### **Bronze Layer (Raw Data)**
- **Description**: Contains raw earthquake data as ingested from the source. No transformations are applied.
- **Schema**:
  | Column Name        | Data Type   | Description                                    |
  |--------------------|-------------|------------------------------------------------|
  | id                 | String      | Unique identifier for the earthquake event.   |
  | time               | Timestamp   | Timestamp of the event.                       |
  | latitude           | Float       | Latitude of the earthquake's epicenter.       |
  | longitude          | Float       | Longitude of the earthquake's epicenter.      |
  | depth              | Float       | Depth of the earthquake in kilometers.        |
  | magnitude          | Float       | Magnitude of the earthquake.                  |
  | place              | String      | Description of the location.                  |
  | status             | String      | Status of the event (e.g., reviewed, automatic). |
  | alert              | String      | Alert level issued (if any).                  |

---

##### **Silver Layer (Cleansed and Transformed Data)**
- **Description**: Cleansed and partially transformed data. Invalid or incomplete records are removed, and key fields are standardized.
- **Schema**:
  | Column Name        | Data Type   | Description                                    |
  |--------------------|-------------|------------------------------------------------|
  | id                 | String      | Unique identifier for the earthquake event.   |
  | time               | DateTime    | Converted to ISO 8601 format.                 |
  | latitude           | Float       | Latitude of the earthquake's epicenter.       |
  | longitude          | Float       | Longitude of the earthquake's epicenter.      |
  | depth              | Float       | Depth of the earthquake in kilometers.        |
  | magnitude          | Float       | Magnitude of the earthquake.                  |
  | magnitude_category | String      | Categorized as low, medium, or high.          |
  | country_code       | String      | ISO country code based on geolocation.        |
  | place              | String      | Standardized location description.            |

---

##### **Gold Layer (Aggregated and Enriched Data)**
- **Description**: Aggregated and enriched data ready for analysis and visualization. Includes counts and averages by country and severity.
- **Schema**:
  | Column Name         | Data Type   | Description                                    |
  |---------------------|-------------|------------------------------------------------|
  | country_code        | String      | ISO country code based on geolocation.        |
  | total_earthquakes   | Integer     | Total number of earthquakes in the region.    |
  | avg_magnitude       | Float       | Average magnitude of earthquakes.             |
  | max_magnitude       | Float       | Maximum magnitude recorded.                   |
  | depth_category      | String      | Shallow (<70km), Intermediate (70-300km), or Deep (>300km). |
  | low_count           | Integer     | Count of low-magnitude earthquakes.           |
  | medium_count        | Integer     | Count of medium-magnitude earthquakes.        |
  | high_count          | Integer     | Count of high-magnitude earthquakes.          |

---

#### **Transformation Highlights**
1. **Bronze to Silver**:
   - **Data Cleansing**: Remove invalid or incomplete records.
   - **Standardization**: Format timestamps, normalize location fields, and derive country codes.
   - **Categorization**: Derive `magnitude_category` (low, medium, high).

2. **Silver to Gold**:
   - **Aggregation**: Group data by `country_code` and summarize key metrics.
   - **Enrichment**: Calculate derived metrics such as average and maximum magnitude.
   - **Additional Insights**: Categorize depths into `shallow`, `intermediate`, and `deep`.

### Step 4: Data Loading and Reporting

1. **Load Data into Synapse**: Set up a Synapse SQL pool and load the `gold` data for analysis.
2. **Create Power BI Dashboard**: Connect Power BI to Synapse and create visualizations based on business requirements.

### Step 5: Automation and Monitoring

1. **Schedule Pipelines**: Use ADF to schedule the data pipelines to run daily.
2. **Monitor Pipeline Runs**: Use the monitoring tools in ADF and Synapse to ensure successful pipeline execution.

### Step 6: Security and Governance

1. **Manage Access**: Set up role-based access control (RBAC) using Azure Entra ID (formerly Active Directory).

### Step 7: End-to-End Testing

1. **Trigger and Test Pipelines**: Insert new records into the SQL database and verify that the entire pipeline runs successfully, updating the Power BI dashboard.

## Conclusion

This project provides a robust end-to-end solution for understanding customer demographics and their impact on sales. The automated data pipeline ensures that stakeholders always have access to the most current and actionable insights.
