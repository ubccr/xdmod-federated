(
    SELECT
        federation_instance_id
    FROM
        ${util}.federation_instances
    WHERE
        prefix =
            LEFT(
                '${src}',
                CHAR_LENGTH('${src}') - LENGTH(SUBSTRING_INDEX('${src}', '-', -1))-1
            )
)
