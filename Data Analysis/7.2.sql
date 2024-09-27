SET SERVEROUTPUT ON;

DECLARE
    CURSOR workclass_cursor IS
        SELECT workclass, COUNT(*) AS count
        FROM adult
        GROUP BY workclass;

    CURSOR education_cursor IS
        SELECT education, COUNT(*) AS count
        FROM adult
        GROUP BY education;

    CURSOR marital_status_cursor IS
        SELECT marital_status, COUNT(*) AS count
        FROM adult
        GROUP BY marital_status;

    column_width CONSTANT INTEGER := 30;
BEGIN
    -- Workclass Distribution
    DBMS_OUTPUT.PUT_LINE(RPAD('Workclass', column_width) || RPAD('Count', column_width));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', column_width, '-') || RPAD('-', column_width, '-'));
    FOR rec IN workclass_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.workclass, column_width) || RPAD(rec.count, column_width));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('');

    -- Education Distribution
    DBMS_OUTPUT.PUT_LINE(RPAD('Education', column_width) || RPAD('Count', column_width));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', column_width, '-') || RPAD('-', column_width, '-'));
    FOR rec IN education_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.education, column_width) || RPAD(rec.count, column_width));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('');

    -- Marital Status Distribution
    DBMS_OUTPUT.PUT_LINE(RPAD('Marital Status', column_width) || RPAD('Count', column_width));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', column_width, '-') || RPAD('-', column_width, '-'));
    FOR rec IN marital_status_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.marital_status, column_width) || RPAD(rec.count, column_width));
    END LOOP;
END;
/