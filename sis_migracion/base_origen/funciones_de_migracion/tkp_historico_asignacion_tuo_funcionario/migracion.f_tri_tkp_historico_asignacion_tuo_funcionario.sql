
		CREATE OR REPLACE FUNCTION migracion.f_tri_tkp_historico_asignacion_tuo_funcionario ()
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
		   
			 v_consulta =  'SELECT migracion.f_trans_tkp_historico_asignacion_tuo_funcionario (
                  '''||TG_OP::varchar||''','||COALESCE(NEW.id_historico_asignacion::varchar,'NULL')||','||COALESCE(NEW.id_empleado::varchar,'NULL')||','||COALESCE(NEW.id_unidad_organizacional::varchar,'NULL')||','||COALESCE(NEW.id_usuario_mod::varchar,'NULL')||','||COALESCE(NEW.id_usuario_reg::varchar,'NULL')||','||COALESCE(''''||NEW.estado::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_asignacion::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_finalizacion::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_registro::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_ultima_mod::varchar||'''','NULL')||') as res';				  
		  ELSE 
		      v_consulta =  ' SELECT migracion.f_trans_tkp_historico_asignacion_tuo_funcionario (
		              '''||TG_OP::varchar||''','||OLD.id_historico_asignacion||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL) as res';
		       
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