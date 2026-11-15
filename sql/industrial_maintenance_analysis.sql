-- =====================================================
-- INDUSTRIAL PREDICTIVE MAINTENANCE
-- SQL DATABASE ANALYSIS
-- =====================================================

USE IndustrialMaintenanceDB;
GO

-- 1. Verify the machine data table
SELECT TOP 10 *
FROM dbo.machine_data;
GO

-- 2. Check total machine records
SELECT COUNT(*) AS TotalMachines
FROM dbo.machine_data;
GO

-- 3. Machine failure distribution
SELECT
    Machine_failure,
    COUNT(*) AS MachineCount
FROM dbo.machine_data
GROUP BY Machine_failure;
GO



-- 4. Machine failure analysis by product type
SELECT
    Type,
    COUNT(*) AS TotalMachines,
    SUM(CAST(Machine_failure AS INT)) AS FailedMachines,
    CAST(
        100.0 * SUM(CAST(Machine_failure AS INT)) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS FailureRatePercentage
FROM dbo.machine_data
GROUP BY Type
ORDER BY FailureRatePercentage DESC;
GO


-- 5. Compare operating conditions by machine failure status
SELECT
    Machine_failure,
    COUNT(*) AS TotalMachines,
    AVG(Air_temperature_K) AS AverageAirTemperature,
    AVG(Process_temperature_K) AS AverageProcessTemperature,
    AVG(Rotational_speed_rpm) AS AverageRotationalSpeed,
    AVG(Torque_Nm) AS AverageTorque,
    AVG(Tool_wear_min) AS AverageToolWear
FROM dbo.machine_data
GROUP BY Machine_failure
ORDER BY Machine_failure;
GO



-- 6. Exploratory high torque and high tool wear analysis
SELECT
    UDI,
    Type,
    Torque_Nm,
    Tool_wear_min,
    Rotational_speed_rpm,
    Machine_failure
FROM dbo.machine_data
WHERE Torque_Nm >= 50
  AND Tool_wear_min >= 150
ORDER BY Torque_Nm DESC, Tool_wear_min DESC;
GO



-- 7. Failure mode distribution
SELECT
    SUM(CAST(TWF AS INT)) AS ToolWearFailures,
    SUM(CAST(HDF AS INT)) AS HeatDissipationFailures,
    SUM(CAST(PWF AS INT)) AS PowerFailures,
    SUM(CAST(OSF AS INT)) AS OverstrainFailures,
    SUM(CAST(RNF AS INT)) AS RandomFailures
FROM dbo.machine_data;
GO



-- 8. Failure rate by tool-wear category
SELECT
    CASE
        WHEN Tool_wear_min < 50 THEN 'Low Tool Wear'
        WHEN Tool_wear_min < 150 THEN 'Medium Tool Wear'
        ELSE 'High Tool Wear'
    END AS ToolWearCategory,
    COUNT(*) AS TotalMachines,
    SUM(CAST(Machine_failure AS INT)) AS FailedMachines,
    CAST(
        100.0 * SUM(CAST(Machine_failure AS INT)) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS FailureRatePercentage
FROM dbo.machine_data
GROUP BY
    CASE
        WHEN Tool_wear_min < 50 THEN 'Low Tool Wear'
        WHEN Tool_wear_min < 150 THEN 'Medium Tool Wear'
        ELSE 'High Tool Wear'
    END
ORDER BY FailureRatePercentage DESC;
GO



-- 9. Failure rate by torque category
SELECT
    CASE
        WHEN Torque_Nm < 30 THEN 'Low Torque'
        WHEN Torque_Nm < 50 THEN 'Medium Torque'
        ELSE 'High Torque'
    END AS TorqueCategory,
    COUNT(*) AS TotalMachines,
    SUM(CAST(Machine_failure AS INT)) AS FailedMachines,
    CAST(
        100.0 * SUM(CAST(Machine_failure AS INT)) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS FailureRatePercentage
FROM dbo.machine_data
GROUP BY
    CASE
        WHEN Torque_Nm < 30 THEN 'Low Torque'
        WHEN Torque_Nm < 50 THEN 'Medium Torque'
        ELSE 'High Torque'
    END
ORDER BY FailureRatePercentage DESC;
GO