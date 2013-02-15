﻿CREATE OR REPLACE FUNCTION migracion.f_tri_tpm_institucion_tinstitucion (
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
		   
			 v_consulta =  'SELECT migracion.f_trans_tpm_institucion_tinstitucion (
                  '''||TG_OP::varchar||''','||COALESCE(NEW.id_institucion::varchar,'NULL')||','||COALESCE(NEW.id_persona::varchar,'NULL')||','||COALESCE(NEW.id_tipo_doc_institucion::varchar,'NULL')||','||COALESCE(''''||NEW.casilla::varchar||'''','NULL')||','||COALESCE(''''||NEW.celular1::varchar||'''','NULL')||','||COALESCE(''''||NEW.celular2::varchar||'''','NULL')||','||COALESCE(''''||NEW.codigo_banco::varchar||'''','NULL')||','||COALESCE(''''||NEW.direccion::varchar||'''','NULL')||','||COALESCE(''''||NEW.doc_id::varchar||'''','NULL')||','||COALESCE(''''||NEW.email1::varchar||'''','NULL')||','||COALESCE(''''||NEW.email2::varchar||'''','NULL')||','||COALESCE(''''||NEW.estado_institucion::varchar||'''','NULL')||','||COALESCE(''''||NEW.fax::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_registro::varchar||'''','NULL')||','||COALESCE(''''||NEW.fecha_ultima_modificacion::varchar||'''','NULL')||','||COALESCE(''''||NEW.hora_registro::varchar||'''','NULL')||','||COALESCE(''''||NEW.hora_ultima_modificacion::varchar||'''','NULL')||','||COALESCE(''''||NEW.nombre::varchar||'''','NULL')||','||COALESCE(''''||NEW.observaciones::varchar||'''','NULL')||','||COALESCE(''''||NEW.pag_web::varchar||'''','NULL')||','||COALESCE(''''||NEW.telefono1::varchar||'''','NULL')||','||COALESCE(''''||NEW.telefono2::varchar||'''','NULL')||') as res';				  
		  ELSE 
		      v_consulta =  ' SELECT migracion.f_trans_tpm_institucion_tinstitucion (
		              '''||TG_OP::varchar||''','||OLD.id_institucion||',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL) as res';
		       
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