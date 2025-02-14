#1.Trends in Admission Over Time: 
 SELECT 
    DATE_FORMAT(Admit_Date, '%Y-%m') AS Month,
    COUNT(*) AS Total_Admissions
FROM patient_data
GROUP BY Month
ORDER BY Month

#2.Identifying the top 5 most common diagnoses.
SELECT 
    Diagnosis AS Disease, 
    COUNT(*) AS Frequency
FROM patient_data
GROUP BY Diagnosis
ORDER BY Frequency DESC
LIMIT 5;

#3.Bed Occupancy Analysis: 
#Analyzing the distribution of bed occupancy types. 
SELECT 
    Bed_Occupancy, 
    COUNT(*) AS Total_Count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patient_data)), 2) AS Percentage
FROM patient_data
GROUP BY Bed_Occupancy
ORDER BY Total_Count DESC;

#4.Length of Stay Distribution: 
#Analyze the average and maximum length of stay for patients.
SELECT 
    ROUND(AVG(DATEDIFF(Discharge_Date, Admit_Date)), 2) AS Avg_Length_of_Stay,
    MAX(DATEDIFF(Discharge_Date, Admit_Date)) AS Max_Length_of_Stay
FROM patient_data
WHERE Discharge_Date IS NOT NULL AND Admit_Date IS NOT NULL;

#5.Seasonal Admission Patterns: 
#Identify the seasonality in admissions based on the month. 
SELECT 
    MONTHNAME(Admit_Date) AS Month_Name,
    MONTH(Admit_Date) AS Month_Number,
    COUNT(*) AS Total_Admissions
FROM patient_data
WHERE Admit_Date IS NOT NULL
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;

#6.Readmission count
SELECT 
    Patient_ID, 
    COUNT(*) AS Readmission_Count
FROM patient_data
WHERE Admit_Date BETWEEN DATE_SUB(Discharge_Date, INTERVAL 30 DAY) AND Discharge_Date
GROUP BY Patient_ID
HAVING Readmission_Count > 1
ORDER BY Readmission_Count DESC;

#7.Diagnosis
SELECT 
    Diagnosis, 
    COUNT(*) AS Total
FROM patient_data
GROUP BY Diagnosis
ORDER BY Total DESC;

#8.Test
SELECT 
    Test, 
    COUNT(*) AS Frequency
FROM patient_data
GROUP BY Test
ORDER BY Frequency DESC;

#9.Bed occupancy
SELECT 
    Bed_Occupancy, 
    COUNT(*) AS Patient_Count
FROM patient_data
GROUP BY Bed_Occupancy
ORDER BY Patient_Count DESC;

#10.patient with extended stay
SELECT 
    Patient_ID, 
    DATEDIFF(Discharge_Date, Admit_Date) AS Length_of_Stay
FROM patient_data
WHERE DATEDIFF(Discharge_Date, Admit_Date) > (SELECT AVG(DATEDIFF(Discharge_Date, Admit_Date)) FROM patient_data)
ORDER BY Length_of_Stay DESC;


#12.Discharge trends
SELECT 
    DATE_FORMAT(Discharge_Date, '%Y-%m') AS Month,
    COUNT(*) AS Total_Discharges
FROM patient_data
WHERE Discharge_Date IS NOT NULL
GROUP BY Month
ORDER BY Month;

#13.patient with highest number of test
SELECT 
    Patient_ID, 
    COUNT(Test) AS Total_Tests
FROM patient_data
GROUP BY Patient_ID
ORDER BY Total_Tests DESC
LIMIT 10;

#14.followup rate analysis
SELECT 
    Diagnosis, 
    COUNT("Followup Date") AS Follow_Up_Count, 
    COUNT(*) AS Total_Patients,
    ROUND((COUNT("Followup_Date") * 100.0 / COUNT(*)), 2) AS Follow_Up_Rate
FROM patient_data
GROUP BY Diagnosis
ORDER BY  Follow_Up_Rate DESC;

#15.day with highest number of queries
SELECT 
    Admit_Date, 
    COUNT(*) AS Total_Admissions
FROM patient_data
GROUP BY Admit_Date
ORDER BY Total_Admissions DESC
LIMIT 1;






