SET SERVEROUTPUT ON;

DECLARE
    CURSOR hours_worked_cursor IS
        WITH hours_worked_data AS (
            SELECT 
                CASE 
                    WHEN hours_per_week < 20 THEN '< 20'
                    WHEN hours_per_week BETWEEN 20 AND 40 THEN '20-40'
                    WHEN hours_per_week BETWEEN 41 AND 60 THEN '41-60'
                    ELSE '> 60'
                END AS hours_bracket,
                COUNT(CASE WHEN income = '">50K"' THEN 1 END) AS high_income_count,
                COUNT(CASE WHEN income = '"<=50K"' THEN 1 END) AS low_income_count
            FROM adult
            GROUP BY 
                CASE 
                    WHEN hours_per_week < 20 THEN '< 20'
                    WHEN hours_per_week BETWEEN 20 AND 40 THEN '20-40'
                    WHEN hours_per_week BETWEEN 41 AND 60 THEN '41-60'
                    ELSE '> 60'
                END
        )
        SELECT *
        FROM hours_worked_data
        ORDER BY 
            CASE 
                WHEN hours_bracket = '< 20' THEN 1
                WHEN hours_bracket = '20-40' THEN 2
                WHEN hours_bracket = '41-60' THEN 3
                ELSE 4
            END;

    column_width CONSTANT INTEGER := 25;

BEGIN
    -- Table header
    DBMS_OUTPUT.PUT_LINE(RPAD('Hours Worked', column_width) || RPAD('Income >50K', column_width) || 'Income <=50K');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');

    FOR rec IN hours_worked_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.hours_bracket, column_width) || 
                             RPAD(rec.high_income_count, column_width) || 
                             rec.low_income_count);
    END LOOP;
END;
/