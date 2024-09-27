SET SERVEROUTPUT ON;

DECLARE
    CURSOR age_bracket_cursor IS
        SELECT 
            CASE 
                WHEN age BETWEEN 17 AND 19 THEN '17-19'
                WHEN age BETWEEN 20 AND 30 THEN '20-30'
                WHEN age BETWEEN 31 AND 40 THEN '31-40'
                WHEN age BETWEEN 41 AND 50 THEN '41-50'
                WHEN age BETWEEN 51 AND 60 THEN '51-60'
                ELSE '60+'
            END AS age_bracket,
            COUNT(CASE WHEN income = '">50K"' THEN 1 END) AS high_income_count,
            COUNT(CASE WHEN income = '"<=50K"' THEN 1 END) AS low_income_count
        FROM adult
        GROUP BY 
            CASE 
                WHEN age BETWEEN 17 AND 19 THEN '17-19'
                WHEN age BETWEEN 20 AND 30 THEN '20-30'
                WHEN age BETWEEN 31 AND 40 THEN '31-40'
                WHEN age BETWEEN 41 AND 50 THEN '41-50'
                WHEN age BETWEEN 51 AND 60 THEN '51-60'
                ELSE '60+'
            END
        ORDER BY
            MIN(age);

BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('Age Bracket', 15) || RPAD('Income >50K', 15) || 'Income <=50K');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    FOR rec IN age_bracket_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.age_bracket, 15) || RPAD(rec.high_income_count, 15) || rec.low_income_count);
    END LOOP;
END;
/
