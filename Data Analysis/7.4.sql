SET SERVEROUTPUT ON;

DECLARE
    CURSOR workclass_income_cursor IS
        SELECT workclass,
               COUNT(CASE WHEN income = '">50K"' THEN 1 END) AS high_income_count,
               COUNT(CASE WHEN income = '"<=50K"' THEN 1 END) AS low_income_count
        FROM adult
        GROUP BY workclass
        ORDER BY high_income_count DESC;

    column_width CONSTANT INTEGER := 25;

BEGIN
    -- Table header
    DBMS_OUTPUT.PUT_LINE(RPAD('Workclass', column_width) || RPAD('Income >50K', column_width) || 'Income <=50K');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');

    FOR rec IN workclass_income_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.workclass, column_width) || 
                             RPAD(rec.high_income_count, column_width) || 
                             rec.low_income_count);
    END LOOP;
END;
/