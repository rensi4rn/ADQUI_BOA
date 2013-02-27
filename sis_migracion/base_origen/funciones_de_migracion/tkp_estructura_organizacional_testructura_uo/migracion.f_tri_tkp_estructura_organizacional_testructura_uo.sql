CREATE OR REPLACE FUNCTION migracion.f_tri_tkp_estructura_organizacional_testructura_uo (
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
		   
			 v_consulta =  'SELECT migracion.f_trans_tkp_estructura_organizacional_testructura_uo (
                  '''||TG_OP::varchar||''','||COALESCE(NEW.id_estructura_organizacional::varchar,'NULL')||','||COALESCE(NEW.id_hijo::varchar,'NULL')||','||COALESCE(NEW.id_padre::varchar,'NULL')||','||COALESCE(''''||NEW.fecha_reg::varchar||'''','NULL')||','||COALESCE(''''||NEW.observaciones::varchar||'''','NULL')||','||COALESCE(''''||NEW.relacion::varchar||'''','NULL')||') as res';				  
		  ELSE 
		      v_consulta =  ' SELECT migracion.f_trans_tkp_estructura_organizacional_testructura_uo (
		              '''||TG_OP::varchar||''','||OLD.id_estructura_organizacional||',NULL,NULL,NULL,NULL,NULL) as res';
		       
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