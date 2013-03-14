CREATE OR REPLACE FUNCTION adq.verificar_presupuesto_partida (
  p_id_presupuesto integer,
  p_id_partida integer,
  p_id_moneda integer,
  p_monto_total numeric
)
RETURNS varchar AS
$body$
DECLARE
  verificado numeric[];
  v_consulta varchar;
  v_conexion varchar;
  v_resp	varchar;
BEGIN
v_conexion:=migra.f_obtener_cadena_conexion();
v_consulta:='select presto."f_i_ad_verificarPresupuestoPartida" ('||p_id_presupuesto||','||p_id_partida||','||p_id_moneda||','||p_monto_total||')';
select into verificado * from dblink(v_conexion,v_consulta) as (verificado numeric[]);
if verificado[1]=0 then
 v_resp:='false';
else
 v_resp:='true'; 
end if;
return v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;