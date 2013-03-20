
		CREATE OR REPLACE FUNCTION migracion.f_tri_tpm_periodo_tperiodo ()
		RETURNS trigger AS
		$BODY$

DECLARE
		 
		g_registros record;
		v_consulta varchar;
		v_res_cone  varchar;
		v_cadena_cnx varchar;
		v_cadena_con varchar;
		resp boolean;
		
		BEGIN
		   IF(TG_OP = 'INSERT' or  TG_OP ='UPDATE' ) THEN
		   
			 v_consulta =  'SELECT migracion.f_trans_tpm_periodo_tperiodo (
                  '''||TG_OP::varchar||''','||COALESCE(NEW.id_periodo::varchar,'NULL')||','||COALESCE(NEW.id_gestion::varchar,'NULL')||','||COALESCE(''''||NEW.estado_peri_gral::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_final::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_inicio::varchar||'''','NULL')||','||COALESCE(NEW.periodo::varchar,'NULL')||') as res';				  
		  ELSE 
		      v_consulta =  ' SELECT migracion.f_trans_tpm_periodo_tperiodo (
		              '''||TG_OP::varchar||''','||OLD.id_periodo||',NULL,NULL,NULL,NULL,NULL) as res';
		       
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
		$BODY$LANGUAGE 'plpgsql'
		VOLATILE
		CALLED ON NULL INPUT
		SECURITY INVOKER;