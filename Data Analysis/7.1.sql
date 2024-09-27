SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION GET_MEDIAN(column_name VARCHAR2, table_name VARCHAR2) RETURN NUMBER IS
        result NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT MEDIAN(' || column_name || ') FROM ' || table_name INTO result;
        RETURN result;
END GET_MEDIAN;
/

CREATE OR REPLACE FUNCTION GET_MODE(column_name VARCHAR2, table_name VARCHAR2) RETURN NUMBER IS
    result NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT ' || column_name || ' 
                       FROM (SELECT ' || column_name || ', COUNT(*) AS cnt 
                             FROM ' || table_name || ' 
                             GROUP BY ' || column_name || ' 
                             ORDER BY cnt DESC, ' || column_name || ' ASC) 
                       WHERE ROWNUM = 1'
                       INTO result;
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in GET_MODE: ' || SQLERRM);
        RETURN NULL;
END GET_MODE;
/
DECLARE
    v_min_age NUMBER;
    v_max_age NUMBER;
    v_mean_age NUMBER;
    v_median_age NUMBER;
    v_mode_age NUMBER;
    v_min_education_num NUMBER;
    v_max_education_num NUMBER;
    v_mean_education_num NUMBER;
    v_median_education_num NUMBER;
    v_mode_education_num NUMBER;
    v_min_hours_per_week NUMBER;
    v_max_hours_per_week NUMBER;
    v_mean_hours_per_week NUMBER;
    v_median_hours_per_week NUMBER;
    v_mode_hours_per_week NUMBER;
    v_min_final_weight NUMBER;
    v_max_final_weight NUMBER;
    v_mean_final_weight NUMBER;
    v_median_final_weight NUMBER;
    v_mode_final_weight NUMBER;
    v_min_capital_gain NUMBER;
    v_max_capital_gain NUMBER;
    v_mean_capital_gain NUMBER;
    v_median_capital_gain NUMBER;
    v_mode_capital_gain NUMBER;
    v_min_capital_loss NUMBER;
    v_max_capital_loss NUMBER;
    v_mean_capital_loss NUMBER;
    v_median_capital_loss NUMBER;
    v_mode_capital_loss NUMBER;

    column_width CONSTANT INTEGER := 20;

    

    
BEGIN
    -- Age statistics
    SELECT MIN(age), MAX(age), ROUND(AVG(age), 2)
    INTO v_min_age, v_max_age, v_mean_age
    FROM adult;

    v_median_age := GET_MEDIAN('age', 'adult');
    v_mode_age := GET_MODE('age', 'adult');

    -- Education number statistics
    SELECT MIN(education_num), MAX(education_num), ROUND(AVG(education_num), 2)
    INTO v_min_education_num, v_max_education_num, v_mean_education_num
    FROM adult;

    v_median_education_num := GET_MEDIAN('education_num', 'adult');
    v_mode_education_num := GET_MODE('education_num', 'adult');

    -- Hours per week statistics
    SELECT MIN(hours_per_week), MAX(hours_per_week), ROUND(AVG(hours_per_week), 2)
    INTO v_min_hours_per_week, v_max_hours_per_week, v_mean_hours_per_week
    FROM adult;

    v_median_hours_per_week := GET_MEDIAN('hours_per_week', 'adult');
    v_mode_hours_per_week := GET_MODE('hours_per_week', 'adult');

    -- Final weight statistics
    SELECT MIN(fntwgt), MAX(fntwgt), ROUND(AVG(fntwgt), 2)
    INTO v_min_final_weight, v_max_final_weight, v_mean_final_weight
    FROM adult;

    v_median_final_weight := GET_MEDIAN('fntwgt', 'adult');
    v_mode_final_weight := GET_MODE('fntwgt', 'adult');

    -- Capital gain statistics
    SELECT MIN(capital_gain), MAX(capital_gain), ROUND(AVG(capital_gain), 2)
    INTO v_min_capital_gain, v_max_capital_gain, v_mean_capital_gain
    FROM adult;

    v_median_capital_gain := GET_MEDIAN('capital_gain', 'adult');
    v_mode_capital_gain := GET_MODE('capital_gain', 'adult');

    -- Capital loss statistics
    SELECT MIN(capital_loss), MAX(capital_loss), ROUND(AVG(capital_loss), 2)
    INTO v_min_capital_loss, v_max_capital_loss, v_mean_capital_loss
    FROM adult;

    v_median_capital_loss := GET_MEDIAN('capital_loss', 'adult');
    v_mode_capital_loss := GET_MODE('capital_loss', 'adult');

    -- Print the table header
    DBMS_OUTPUT.PUT_LINE(RPAD('Statistic', column_width) || 
                         RPAD('Min', column_width) || 
                         RPAD('Max', column_width) || 
                         RPAD('Mean', column_width) ||
                         RPAD('Median', column_width) ||
                         RPAD('Mode', column_width));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------');

    -- Print the values for each category
    DBMS_OUTPUT.PUT_LINE(RPAD('Age', column_width) || 
                         RPAD(v_min_age, column_width) || 
                         RPAD(v_max_age, column_width) || 
                         RPAD(v_mean_age, column_width) ||
                         RPAD(v_median_age, column_width) ||
                         RPAD(v_mode_age, column_width));

    DBMS_OUTPUT.PUT_LINE(RPAD('Education Number', column_width) || 
                         RPAD(v_min_education_num, column_width) || 
                         RPAD(v_max_education_num, column_width) || 
                         RPAD(v_mean_education_num, column_width) ||
                         RPAD(v_median_education_num, column_width) ||
                         RPAD(v_mode_education_num, column_width));

    DBMS_OUTPUT.PUT_LINE(RPAD('Hours per Week', column_width) || 
                         RPAD(v_min_hours_per_week, column_width) || 
                         RPAD(v_max_hours_per_week, column_width) || 
                         RPAD(v_mean_hours_per_week, column_width) ||
                         RPAD(v_median_hours_per_week, column_width) ||
                         RPAD(v_mode_hours_per_week, column_width));

    DBMS_OUTPUT.PUT_LINE(RPAD('Final Weight', column_width) ||
                         RPAD(v_min_final_weight, column_width) || 
                         RPAD(v_max_final_weight, column_width) || 
                         RPAD(v_mean_final_weight, column_width) ||
                         RPAD(v_median_final_weight, column_width) ||
                         RPAD(v_mode_final_weight, column_width));

    DBMS_OUTPUT.PUT_LINE(RPAD('Capital Gain', column_width) || 
                         RPAD(v_min_capital_gain, column_width) || 
                         RPAD(v_max_capital_gain, column_width) || 
                         RPAD(v_mean_capital_gain, column_width) ||
                         RPAD(v_median_capital_gain, column_width) ||
                         RPAD(v_mode_capital_gain, column_width));

    DBMS_OUTPUT.PUT_LINE(RPAD('Capital Loss', column_width) || 
                         RPAD(v_min_capital_loss, column_width) || 
                         RPAD(v_max_capital_loss, column_width) || 
                         RPAD(v_mean_capital_loss, column_width) ||
                         RPAD(v_median_capital_loss, column_width) ||
                         RPAD(v_mode_capital_loss, column_width));

END;
/
