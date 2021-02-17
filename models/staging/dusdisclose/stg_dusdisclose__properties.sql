WITH
  non_duplicate_columns AS (
  SELECT
    DISTINCT Property_ID AS property_id,
    Property__Name,
    Property_Address,
    Property_City,
    Property_State,
    Property_Zip_Code,
    Property_County,
    Property_MSA,
    Property_Additional_Addresses,
    Property_Status,
    Property_Value____,
    Property__Value_As_of_Date,
    Property_Year_Built,
    Property_Total_Units,
    Property_Ownership_Interest,
    Property_General_Property_Type,
    Property_Specific_Property_Type,
    Property_Unit_of_Measure,
    Property_Affordable_Housing_Type,
    Property___of_Units_At_or_Below_50__Area_Median_Income,
    Property___of_Units_At_or_Below_60__Area_Median_Income,
    Property___of_Units_At_or_Below_80__Area_Median_Income,
    Property_Units_with_Income_or_Rent_Restrictions____,
    Property_Age_Restricted,
    Property_HAP_Remaining_Term,
    Property_Tax_Escrow,
    Property_Terrorism_Insurance,
    Property__Condition_Rating,
    Property__Condition_Rating_As_of_Date,
    Property_Green_Building_Certification,
    Property_ENERGY_STAR___Score___Issuance,
    Property_Source_Energy_Use_Intensity___Issuance,
    Property_EPA_Water_Score___Issuance,
    Property_Water_Use_Intensity___Issuance,
    Property_Energy_Score_Date___Issuance,
    Property_Green_Performance_Preceding_Year,
    Property_Green_Performance_Preceding_Year_ENERGY_STAR___Score,
    Property_Green_Performance_Preceding_Year_EPA_Water_Score,
    Property_Green_Performance_Preceding_Year_Source_Energy_Use_Intensity,
    Property_Green_Performance_Preceding_Year_Water_Use_Intensity,
    Property_Green_Performance_Preceding_Year_Energy_Score_Date,
    Property_Green_Performance_2nd_Preceding_Year,
    Property_Green_Performance_2nd_Preceding_Year_ENERGY_STAR___Score,
    Property_Green_Performance_2nd_Preceding_Year_EPA_Water_Score,
    Property_Green_Performance_2nd_Preceding_Year_Source_Energy_Use_Intensity,
    Property_Green_Performance_2nd_Preceding_Year_Water_Use_Intensity,
    Property_Green_Performance_2nd_Preceding_Year_Energy_Score_Date,
    Property_Green_Performance_3rd_Preceding_Year,
    Property_Green_Performance_3rd_Preceding_Year_ENERGY_STAR___Score,
    Property_Green_Performance_3rd_Preceding_Year_EPA_Water_Score,
    Property_Green_Performance_3rd_Preceding_Year_Source_Energy_Use_Intensity,
    Property_Green_Performance_3rd_Preceding_Year_Water_Use_Intensity,
    Property_Green_Performance_3rd_Preceding_Year_Energy_Score_Date,
    Property_UW_EGI____,
    Property_UW_Operating_Expenses____,
    Property_UW_Replacement_Reserves____,
    Property_UW_NCF____,
    Property_UW_Physical_Occupancy____,
    Current_Quarter,
    Loan_DSCR__x__YTD,
    Property_EGI_____YTD,
    Property_Operating_Expenses______YTD,
    Property_NCF_____YTD,
    Property_Physical_Occupancy_____YTD,
    Preceding_Annual_Year,
    Loan_Preceding_Year_DSCR__x_,
    Property_Preceding_Year_EGI____,
    Property_Preceding_Year_Operating_Expenses____,
    Property_Preceding_Year_NCF____,
    Property_Preceding_Year_Physical_Occupancy____,
    _2nd_Preceding_Annual_Year,
    Loan_2nd_Preceding_Year_DSCR__x_,
    Property_2nd_Preceding_Year_EGI____,
    Property_2nd_Preceding_Year_Operating_Expenses____,
    Property_2nd_Preceding_Year_NCF____,
    Property_2nd_Preceding_Year_Physical_Occupancy____,
  FROM
    {{ source ('dusdisclose', 'green_mbs')}}),
  duplicate_columns AS (
  SELECT
    property_id,
    MAX(Loan_Number) AS Loan_Number,
    MAX(_3rd_Preceding_Annual_Year) AS _3rd_Preceding_Annual_Year,
    MAX(Loan_3rd_Preceding_Year_DSCR__x_) AS Loan_3rd_Preceding_Year_DSCR__x_,
    MAX(Property_3rd_Preceding_Year_EGI____) AS Property_3rd_Preceding_Year_EGI____,
    MAX(Property_3rd_Preceding_Year_Operating_Expenses____) AS Property_3rd_Preceding_Year_Operating_Expenses____,
    MAX(Property_3rd_Preceding_Year_NCF____) AS Property_3rd_Preceding_Year_NCF____,
    MAX(Property_3rd_Preceding_Year_Physical_Occupancy____) AS Property_3rd_Preceding_Year_Physical_Occupancy____
  FROM
     {{ source ('dusdisclose', 'green_mbs')}}
  GROUP BY
    property_id)
SELECT
  *
FROM
  non_duplicate_columns
LEFT JOIN
  duplicate_columns
USING
  (property_id)
