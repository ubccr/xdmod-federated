(
    SELECT
        federation_instance_id
    FROM
        ${dest}.federation_instances
    WHERE
        prefix = TRIM('-modw' FROM '${src}')
)
