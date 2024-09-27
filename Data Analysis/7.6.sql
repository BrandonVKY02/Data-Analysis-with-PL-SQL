SET SERVEROUTPUT ON;

DECLARE
    CURSOR sex_income_cursor IS
        SELECT sex,
               COUNT(CASE WHEN income = '">50K"' THEN 1 END) AS high_income_count,
               COUNT(CASE WHEN income = '"<=50K"' THEN 1 END) AS low_income_count
        FROM adult
        GROUP BY sex
        ORDER BY high_income_count DESC;

    column_width CONSTANT INTEGER := 25;

BEGIN
    -- Table header
    DBMS_OUTPUT.PUT_LINE(RPAD('Sex', column_width) || RPAD('Income >50K', column_width) || 'Income <=50K');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');

    FOR rec IN sex_income_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.sex, column_width) || 
                             RPAD(rec.high_income_count, column_width) || 
                             rec.low_income_count);
    END LOOP;
END;
/