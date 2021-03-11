  WITH source AS (

  SELECT * FROM {{ source ('dusdisclose', 'green_mbs')}} 
  
  ),

  renamed AS (

      SELECT * EXCEPT(Property_Zip_Code, Property_City),
      INITCAP(Property_City) AS Property_City,
      LPAD(CAST(Property_Zip_Code AS STRING), 5, "0") AS Property_Zip_Code
      
      FROM source

  )

  SELECT * FROM renamed