CREATE OR REPLACE FUNCTION adq.calcular_monto_total (
  p_id_presupuesto integer,
  p_id_partida integer,
  p_id_moneda integer
)
RETURNS numeric AS
$body$
DECLARE
  registro record;
BEGIN
  select soldet.id_centro_costo, soldet.id_partida, sum(soldet.precio_ga_mb) as monto_total into registro 
            from adq.tsolicitud_det soldet 
            where soldet.id_centro_costo=p_id_presupuesto and soldet.id_partida=p_id_partida
            group by soldet.id_partida, soldet.id_centro_costo order by soldet.id_centro_costo asc;
  
  return registro.monto_total;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;