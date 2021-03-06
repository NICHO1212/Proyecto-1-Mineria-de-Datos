CREATE OR REPLACE PROCEDURE PROYECTO1.LLENAR_VENTAS (REGISTROS IN INT, FECHA_ID IN INT) IS

    SUCURSAL_ID     PROYECTO1.SUCURSALES.ID%TYPE;
    PRODUCTO_ID     PROYECTO1.PRODUCTOS.ID%TYPE;
    CLIENTE_ID      PROYECTO1.PERSONAS.ID%TYPE;
    EMPLEADO_ID     PROYECTO1.PERSONAS.ID%TYPE;
    CANTIDAD        PROYECTO1.VENTAS.CANTIDAD%TYPE;
    TOTAL           PROYECTO1.VENTAS.TOTAL%TYPE;
    
BEGIN

FOR REG IN 1 .. REGISTROS LOOP

    SELECT ID INTO SUCURSAL_ID FROM (
        SELECT ID FROM PROYECTO1.SUCURSALES SAMPLE(75) ORDER BY DBMS_RANDOM.VALUE
    ) WHERE ROWNUM = 1;
    SELECT ID INTO PRODUCTO_ID FROM (
        SELECT ID FROM PROYECTO1.PRODUCTOS SAMPLE(50) ORDER BY DBMS_RANDOM.VALUE
    ) WHERE ROWNUM = 1;
    SELECT ID INTO CLIENTE_ID FROM (
        SELECT ID FROM PROYECTO1.CLIENTES SAMPLE(0.08) ORDER BY DBMS_RANDOM.VALUE
    ) WHERE ROWNUM = 1;
    SELECT ID INTO EMPLEADO_ID FROM (
        SELECT ID FROM PROYECTO1.EMPLEADOS SAMPLE(75) ORDER BY DBMS_RANDOM.VALUE
    ) WHERE ROWNUM = 1;
    SELECT (1 + ABS(MOD(DBMS_RANDOM.RANDOM, 100))) INTO CANTIDAD FROM DUAL;
    SELECT PRECIO_VENTA INTO TOTAL FROM PROYECTO1.PRODUCTOS WHERE ID = PRODUCTO_ID AND ROWNUM = 1;
    TOTAL := TOTAL * CANTIDAD;
    
    INSERT INTO PROYECTO1.VENTAS 
        (SUCURSAL_ID, PRODUCTO_ID, CLIENTE_ID, EMPLEADO_ID, FECHA_ID, CANTIDAD, TOTAL)
    VALUES
        (SUCURSAL_ID, PRODUCTO_ID, CLIENTE_ID, EMPLEADO_ID, FECHA_ID, CANTIDAD, TOTAL);

END LOOP;

END;

-- **

DECLARE
    FECHA_ID PROYECTO1.FECHAS.ID%TYPE;
BEGIN
    FOR X IN 201 .. 365 LOOP
    
        SELECT ID INTO FECHA_ID FROM (
            SELECT ID, ROWNUM AS RN FROM PROYECTO1.FECHAS ORDER BY FECHA ASC
        ) WHERE RN = X;
        PROYECTO1.LLENAR_VENTAS(5000, FECHA_ID);
    
    END LOOP;
    
END;


-- **


SELECT COUNT(*) FROM PROYECTO1.VENTAS;

DELETE FROM PROYECTO1.VENTAS WHERE 1=1

