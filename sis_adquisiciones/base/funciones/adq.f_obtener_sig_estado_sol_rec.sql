--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_obtener_sig_estado_sol_rec (
  p_id_solicitud integer,
  p_id_proceso_wf integer,
  p_id_tipo_estado integer,
  out ps_id_tipo_estado integer [],
  out ps_codigo_estado varchar [],
  out ps_disparador varchar [],
  out ps_regla varchar [],
  out ps_prioridad integer []
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		adq.f_obtener_sig_estado_sol_rec
 DESCRIPCION: 	funcion que busca resursivamente el siguiente estado 
 
 
 AUTOR: 		KPLIAN(RAC)
 FECHA:			21/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE

    va_id_tipo_estado integer [];
    va_codigo_estado varchar [];
    va_disparador varchar [];
    va_regla varchar [];
    va_prioridad integer [];
    v_obs text;
    va_obs text[];
    v_x text;
    v_count integer;
	
BEGIN
   --buscamos siguiente estado correpondiente al proceso del WF
               SELECT 
                 *
              into
                va_id_tipo_estado,
                va_codigo_estado,
                va_disparador,
                va_regla,
                va_prioridad
            
            FROM wf.f_obtener_estado_wf(p_id_proceso_wf, NULL,p_id_tipo_estado,'siguiente');
            
             ps_id_tipo_estado = va_id_tipo_estado;
             ps_codigo_estado =  va_codigo_estado;
             ps_disparador = va_disparador;
             ps_regla=  va_regla;
             ps_prioridad= va_prioridad; 
            
    --   raise notice 'xxx  -> % % % % % ', va_id_tipo_estado,   va_codigo_estado,va_disparador, va_regla,  va_prioridad  ;  
    
   if va_id_tipo_estado[2] is not null then
   
    raise exception 'El flujo de adquisiciones solo admite un estado sin bifurcacion, configuracion de WF inadecuada';
   
   end if; 
   
    

   --si el estado siguiente es de activos dijo o de la uti verificamos
   --verificamos las partida en el detalle de la solicitud correponden con las configuradas para su revision
   --si no pasamos al siguiente estado recursicamente 
   if va_codigo_estado[1] in ('vbactif','vbuti') then
   
            select 
            te.obs
           into 
            v_obs
           from wf.ttipo_estado te
           where te.id_tipo_estado = va_id_tipo_estado[1];
           
          
           v_obs = TRIM (v_obs);
           
           IF v_obs  is NULL  or v_obs =''  THEN
           
             return;
           
           END IF;
           
           
           
           va_obs=string_to_array(v_obs,',');
           --elimina espacios en blanco
            v_count = 0;
           FOREACH v_x IN ARRAY va_obs
            LOOP
              v_count = v_count +1;
             va_obs[v_count] = TRIM(v_x);
            END LOOP;
           
         
         
           
           IF  exists(select 
                         1
                       from adq.tsolicitud_det sd 
                       inner join pre.tpartida p on p.id_partida = sd.id_partida
                       where   sd.id_solicitud = p_id_solicitud 
                              and TRIM(p.codigo) =ANY (va_obs)) THEN
                 return;
                  
           ELSE
   
              --lamada recursica
             SELECT  
     			 *
              into
                va_id_tipo_estado,
                va_codigo_estado,
                va_disparador,
                va_regla,
                va_prioridad 
               FROM adq.f_obtener_sig_estado_sol_rec(p_id_solicitud,p_id_proceso_wf, va_id_tipo_estado[1]);
               
              ps_id_tipo_estado = va_id_tipo_estado;
              ps_codigo_estado =  va_codigo_estado;
              ps_disparador = va_disparador;
              ps_regla=  va_regla;
              ps_prioridad= va_prioridad;
              
              return;
         END IF;
   else
      return;
   end if;
    
 
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;