CREATE OR REPLACE FUNCTION migra.f_obtener_cadena_conexion (
)
RETURNS varchar AS
$body$
DECLARE

v_host varchar;
v_puerto varchar;
v_dbname varchar;
p_user varchar;
v_password varchar;
 
BEGIN

v_host='192.168.1.108';
v_puerto='5432';
v_dbname='dbendesis';
p_user='postgres';
v_password='postgres';


RETURN 'hostaddr='||v_host||' port='||v_puerto||' dbname='||v_dbname||' user='||p_user||' password='||v_password; 

 
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;