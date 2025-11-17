# BrightTV Viewership Analytics Project

## 📌 Project Overview

BrightTV’s CEO aims to grow the platform’s subscription base. This project analyzes user demographics and viewership behavior to produce insights that will support the Customer Value Management (CVM) team in driving engagement and increasing subscriptions.

Using two datasets — **User Profiles** and **Viewership Sessions** — the analysis includes: usage trends, demographic influence on content consumption, channel popularity, peak viewing times, and targeted recommendations.

---

## 🧩 Miro Project Plan

A Miro project plan was created to outline the full workflow of the BrightTV analysis.  
The plan includes:

- Data ingestion & cleaning steps  
- Transformation logic in Snowflake  
- EDA and Pivot Table analysis  
- Power BI dashboard development  
- Insights & recommendations  
- Final presentation preparation  

It provides a visual overview of the project timeline, dependencies, and key deliverables.


---
## 📁 Project Files

* **BrightTV_UserProfiles.csv** – demographic details of users
* **BrightTV_Viewership.csv** – session-level data including channel, timestamp, and duration
* **BrightTV Cleaned Table (from Snowflake)** – merged, transformed, and enriched dataset created for analysis
* **Excel Pivot Workbook** – pivot tables and visuals based on cleaned data
* **BrightTV_Viewership Insights Presentation-compressed** - created on Canva
* **BrightTV project Gantt Chart** - Shows task completed per week
* **PowerBi Dashboard** - visualizes key BrightTV insights
* **MiroPlan Flowchart** - project workflow
  
---

## 🧹 Data Cleaning & Transformation

All data preparation was completed in **Snowflake** and included:

### **✔ Timestamp Conversion**

* Converted UTC timestamps to **Africa/Johannesburg** timezone
* Extracted:

  * SA_Date
  * SA_Hour
  * SA_Weekday

### **✔ Duration Conversion**

* Converted `HH:MM:SS` to:

  * DurationSeconds (via DATEDIFF)
  * DurationMinutes

### ✔ User Demographic Enrichment

* Age Grouping
* Gender, race, province enrichment via join

### ✔ Cleaned Table Created

A consolidated table, cleaned_viewer_table`, was created containing all transformed fields.

---

## 📊 Analytical Focus Areas

### **1. User & Usage Trends**

* Sessions per day
* Sessions per hour (peak times)

### **2. Demographic Influence**

* Age group behavior
* Gender-based content preference
* Province-level consumption

### **3. Content Insights**

* Top channels
* Category-level drivers (sports, music, kids, drama)

### **4. Session Metrics**

* Total minutes watched per day
* Average session duration per channel

---

## 📈 Visuals & Pivot Tables

Created directly in Excel using cleaned dataset:

### **Pivot Tables:**

* Sessions by Day
* Sessions by Hour
* Top Channels
* Sessions by Age Group
* Sessions by Province
* Total Minutes Watched per Day
* Weekday vs Weekend
* Channel Popularity by Gender
* Channel Popularity by Age Group
* Heatmap: Hour vs Day of Week

### **Charts:**

* Line, bar, stacked bar, and heatmap visuals

---

## 🎯 Key Insights Summary

* **Peak viewing time:** 14h to 21h daily
* **Age group 18–34** drives the highest consumption (youth and young adults)
* **Gauteng & KZN** show the highest activity
* **Sports, Africa Magic, and music channels** are top performers
* **Low-consumption days:

---

## 📊 Power BI Dashboard Overview

A Power BI dashboard was created to visually summarize the BrightTV viewership insights.  
The dashboard includes:

- **KPI Cards:** Total Sessions, Total Minutes Watched, Unique Users  
- **Daily & Hourly Usage Trends**  
- **Top 10 Channels**  
- **Demographic Insights:** Age Group and Gender patterns  
- **Dynamic Filters (Slicers):** Date, Gender, Age Group, Province  

The dashboard provides a clear view of user engagement patterns and supports data-driven content and scheduling decisions.

Screenshots of the dashboard are included in the repository.
