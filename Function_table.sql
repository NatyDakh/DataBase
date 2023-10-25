CREATE FUNCTION initials(VARCHAR(40), VARCHAR(40), VARCHAR(40))
  RETURNS VARCHAR(6)
AS $$
    SELECT
        CASE
          WHEN $3 is null then  concat(substring($1, 1, 1), '.', substring($2, 1,1), '.')
          ELSE concat(substring($1, 1, 1), '.', substring($2, 1, 1), '.',substring($3, 1, 1), '.' )
$$ LANGUAGE SQL;


CREATE PROCEDURE insert_data(a integer, B integer, c integer)
LANGUAGE SQL
AS $$
  INSERT INTO booking VALUES (a, b, c);
$$;
