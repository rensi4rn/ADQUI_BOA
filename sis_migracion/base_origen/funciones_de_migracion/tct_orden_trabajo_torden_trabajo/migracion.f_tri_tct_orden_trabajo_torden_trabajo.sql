CREATE OR REPLACE FUNCTION migracion.f_tri_tct_orden_trabajo_torden_trabajo (
)
RETURNS trigger AS
$body$
DECLARE
		 
		g_registros record;
		v_consulta varchar;
		v_res_cone  varchar;
		v_cadena_cnx varchar;
		v_cadena_con varchar;
		resp boolean;
		
		BEGIN
		   IF(TG_OP = 'INSERT' or  TG_OP ='UPDATE' ) THEN
		   
			 v_consulta =  'SELECT migracion.f_trans_tct_orden_trabajo_torden_trabajo (
                  '''||TG_OP::varchar||''','||COALESCE(NEW.id_orden_trabajo::varchar,'NULL')||','||COALESCE(NEW.id_usuario::varchar,'NULL')||','||COALESCE(''''||NEW.desc_orden::varchar||'''','NULL')||','||COALESCE(NEW.estado_orden::varchar,'NULL')||','||COALESCE(''''||NEW.fecha_final::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_inicio::varchar||'''','NULL')||','||COALESCE(''''||NEW.motivo_orden::varchar||'''','NULL')||') as res';				  
		  ELSE 
		      v_consulta =  ' SELECT migracion.f_trans_tct_orden_trabajo_torden_trabajo (
		              '''||TG_OP::varchar||''','||OLD.id_orden_trabajo||',NULL,NULL,NULL,NULL,NULL,NULL) as res';
		       
		   END IF;
		   --------------------------------------
		   -- PARA PROBAR SI FUNCIONA LA FUNCION DE TRANFROMACION, HABILITAR EXECUTE
		   ------------------------------------------
		     --EXECUTE (v_consulta);
		   
		   
		    INSERT INTO 
		                      migracion.tmig_migracion
		                    (
		                      verificado,
		                      consulta,
		                      operacion
		                    ) 
		                    VALUES (
		                      'no',
		                       v_consulta,
		                       TG_OP::varchar
		                       
		                    );
		
		  RETURN NULL;
		
		END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;