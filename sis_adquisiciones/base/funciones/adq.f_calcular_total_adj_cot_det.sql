--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_calcular_total_adj_cot_det (
  p_id_cotizacion_det integer
)
RETURNS numeric AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Adquisiciones
 FUNCION: 		adq.f_calcular_total_adj_cot_det
 DESCRIPCION:   Funcion que recupera el total adjudicao a partir de la cotizacion  detalle
 AUTOR: 		Rensi Arteaga Copari
 FECHA:	        1-04-2013
 COMENTARIOS:	
***************************************************************************/

DECLARE
  registro record;
  
  v_cantidad_sol integer;
  v_id_solicitud_det integer;
  
  v_total_adjudicado integer;
  v_resp varchar;
  v_nombre_funcion varchar;
  v_id_proceso_compra integer;
BEGIN

v_nombre_funcion = 'adq.f_calcular_total_adj_cot_det';

   --recuperamos la cantidad solicitada
    select
       sd.id_solicitud_det, 
       sd.cantidad
    into 
      
       v_id_solicitud_det,
        v_cantidad_sol
    from adq.tsolicitud_det sd
    inner join adq.tcotizacion_det cd on  cd.id_solicitud_det = sd.id_solicitud_det
    where cd.id_cotizacion_det = p_id_cotizacion_det;


--
select 
c.id_proceso_compra
into 
v_id_proceso_compra
from adq.tcotizacion_det cd 
inner join adq.tcotizacion c on c.id_cotizacion = cd.id_cotizacion
where cd.id_cotizacion_det = p_id_cotizacion_det;  

  -- contamos cuantos item adjudicados existen para este
  
  select 
    sum(cd.cantidad_adju) 
  into 
    v_total_adjudicado
  from adq.tcotizacion_det cd
 inner join adq.tcotizacion c on c.id_cotizacion = cd.id_cotizacion 
  where c.estado !='anulado' 
       and c.estado_reg = 'activo'
       and cd.id_cotizacion_det != p_id_cotizacion_det 
       and c.id_proceso_compra = v_id_proceso_compra
       and cd.id_solicitud_det = v_id_solicitud_det; 
       
  return COALESCE(v_total_adjudicado,0);
  
EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;  
  
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;