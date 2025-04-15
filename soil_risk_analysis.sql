-- Analisis Risiko Longsor Tambang X
-- Dataset: Soil_Test_Tambang_X.csv (50 sampel, tabel soil_test)
-- Dibuat oleh: Christiria Frilisa, April 2025

-- Tahap 1: Eksplorasi Data
-- 1.1: Total Sampel
SELECT COUNT(*) AS Total_Samples
FROM soil_test;

-- 1.2: Ringkasan per Jenis Tanah
SELECT Soil_Type, 
       COUNT(*) AS Sample_Count, 
       ROUND(AVG(Moisture_Pct), 2) AS Avg_Moisture,
       ROUND(AVG(Shear_Strength_kPa), 2) AS Avg_Shear
FROM soil_test
GROUP BY Soil_Type;

-- Tahap 2: Identifikasi Risiko Awal
-- 2.1: Sampel Basah
SELECT Sample_ID, Location, Soil_Type, Moisture_Pct, Shear_Strength_kPa
FROM soil_test
WHERE Moisture_Pct > 20
ORDER BY Moisture_Pct DESC
LIMIT 5;

-- 2.2: Sampel Lemah
SELECT Sample_ID, Location, Soil_Type, Moisture_Pct, Shear_Strength_kPa
FROM soil_test
WHERE Shear_Strength_kPa < 110
ORDER BY Shear_Strength_kPa ASC
LIMIT 5;

-- Tahap 3: Fokus Risiko
-- 3.1: Risiko Sedang
SELECT Sample_ID, Location, Soil_Type, Moisture_Pct, Shear_Strength_kPa
FROM soil_test
WHERE Moisture_Pct > 20 AND Shear_Strength_kPa < 110
ORDER BY Moisture_Pct DESC;

-- 3.2: Tambah Kohesi
SELECT Sample_ID, Location, Soil_Type, Moisture_Pct, Shear_Strength_kPa, Cohesion_kPa
FROM soil_test
WHERE Moisture_Pct > 20 AND Shear_Strength_kPa < 110 AND Cohesion_kPa < 18
ORDER BY Cohesion_kPa ASC;

-- Tahap 4: Analisis per Zona
-- 4.1: Risiko per Zona
SELECT Location, 
       COUNT(*) AS Risky_Samples,
       ROUND(AVG(Moisture_Pct), 2) AS Avg_Moisture,
       ROUND(AVG(Shear_Strength_kPa), 2) AS Avg_Shear,
       ROUND(AVG(Cohesion_kPa), 2) AS Avg_Cohesion
FROM soil_test
WHERE Moisture_Pct > 20 AND Shear_Strength_kPa < 110
GROUP BY Location
ORDER BY Risky_Samples DESC;

-- Tahap 5: Rekomendasi
-- 5.1: Sampel Paling Riskan
SELECT Sample_ID, Location, Soil_Type, Depth_m, Moisture_Pct, Shear_Strength_kPa, Cohesion_kPa
FROM soil_test
WHERE Moisture_Pct > 20 AND Shear_Strength_kPa < 110 AND Cohesion_kPa < 18
ORDER BY Shear_Strength_kPa ASC
LIMIT 3;