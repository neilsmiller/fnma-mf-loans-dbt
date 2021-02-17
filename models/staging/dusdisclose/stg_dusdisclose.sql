  WITH source AS (

  SELECT * FROM {{ source ('dusdisclose', 'green_mbs')}} 
  
  ),

  renamed AS (

      SELECT * FROM source

  )

  SELECT * FROM renamed