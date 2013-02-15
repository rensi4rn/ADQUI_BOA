﻿CREATE OR REPLACE FUNCTION migracion.f_trans_tpm_proyecto_tproyecto (
  v_operacion varchar,
  p_codigo_proyecto varchar,
  p_id_proyecto integer,
  p_id_usuario integer,
  p_codigo_sisin bigint,
  p_descripcion_proyecto text,
  p_fase_proyecto varchar,
  p_fecha_registro date,
  p_fecha_ultima_modificacion date,
  p_hora_registro time,
  p_hora_ultima_modificacion time,
  p_id_persona integer,
  p_id_proyecto_actif integer,
  p_id_usr_mod integer,
  p_nombre_corto varchar,
  p_nombre_proyecto varchar,
  p_tipo_estudio varchar
)
RETURNS varchar [] AS
$body$
DECLARE
			 
			g_registros record;
			v_consulta varchar;
			v_res_cone  varchar;
			v_cadena_cnx varchar;
			v_cadena_con varchar;
			resp boolean;
			v_resp varchar;
			v_respuesta varchar[];
			
			g_registros_resp record;
			v_codigo_proyecto varchar;
			v_id_proyecto int4;
			v_codigo_sisin int8;
			v_descripcion_proyecto text;
			v_estado_reg varchar;
			v_fecha_mod timestamp;
			v_fecha_reg timestamp;
			v_hidro varchar;
			v_id_proyecto_actif int4;
			v_id_proyecto_cat_prog int4;
			v_id_usuario_mod int4;
			v_id_usuario_reg int4;
			v_nombre_corto varchar;
			v_nombre_proyecto varchar;
BEGIN
			
			
			          --funcion para obtener cadena de conexion
			          v_cadena_cnx =  migracion.f_obtener_cadena_con_dblink();
			          
			          
			           ---------------------------------------
			           --previamente se tranforman los datos  (descomentar)
			           ---------------------------------------

			v_codigo_proyecto=convert(p_codigo_proyecto::varchar, 'LATIN1', 'UTF8');
			v_id_proyecto=p_id_proyecto::int4;
			v_codigo_sisin=p_codigo_sisin::int8;
			v_descripcion_proyecto=convert(p_descripcion_proyecto::text, 'LATIN1', 'UTF8');
			v_estado_reg=convert('activo'::varchar, 'LATIN1', 'UTF8');
			v_fecha_mod=p_fecha_ultima_modificacion::timestamp;
			v_fecha_reg=p_fecha_registro::timestamp;
			v_hidro=convert('no'::varchar, 'LATIN1', 'UTF8');
			v_id_proyecto_actif=p_id_proyecto_actif::int4;
			v_id_proyecto_cat_prog=NULL::int4;
			v_id_usuario_mod=p_id_usr_mod::int4;
            IF(p_id_usuario IS NULL)THEN 			
                v_id_usuario_reg=1::int4;
            ELSE 
                v_id_usuario_reg=p_id_usuario::int4;
            END IF;
			v_nombre_corto=convert(p_nombre_corto::varchar, 'LATIN1', 'UTF8');
			v_nombre_proyecto=convert(p_nombre_proyecto::varchar, 'LATIN1', 'UTF8');
 
			    --cadena para la llamada a la funcion de insercion en la base de datos destino
			      
			        
			          v_consulta = 'select migra.f__on_trig_tpm_proyecto_tproyecto (
			               '''||v_operacion::varchar||''','||COALESCE(''''||v_codigo_proyecto::varchar||'''','NULL')||','||COALESCE(v_id_proyecto::varchar,'NULL')||','||COALESCE(v_codigo_sisin::varchar,'NULL')||','||COALESCE(''''||v_descripcion_proyecto::varchar||'''','NULL')||','||COALESCE(''''||v_estado_reg::varchar||'''','NULL')||','||COALESCE(''''||v_fecha_mod::varchar||'''','NULL')||','||COALESCE(''''||v_fecha_reg::varchar||'''','NULL')||','||COALESCE(''''||v_hidro::varchar||'''','NULL')||','||COALESCE(v_id_proyecto_actif::varchar,'NULL')||','||COALESCE(v_id_proyecto_cat_prog::varchar,'NULL')||','||COALESCE(v_id_usuario_mod::varchar,'NULL')||','||COALESCE(v_id_usuario_reg::varchar,'NULL')||','||COALESCE(''''||v_nombre_corto::varchar||'''','NULL')||','||COALESCE(''''||v_nombre_proyecto::varchar||'''','NULL')||')';
			          --probar la conexion con dblink
			          
					   --probar la conexion con dblink
			          v_resp =  (SELECT dblink_connect(v_cadena_cnx));
			            
			             IF(v_resp!='OK') THEN
			            
			             	--modificar bandera de fallo  
			                 raise exception 'FALLA CONEXION A LA BASE DE DATOS CON DBLINK';
			                 
			             ELSE
					  
			         
			               PERFORM * FROM dblink(v_consulta,true) AS ( xx varchar);
			                v_res_cone=(select dblink_disconnect());
			             END IF;
			            
			            v_respuesta[1]='TRUE';
                       
			           RETURN v_respuesta;
			EXCEPTION
			   WHEN others THEN
			     v_respuesta[1]='FALSE';
                 v_respuesta[2]=SQLERRM;
                 v_respuesta[3]=SQLSTATE;
                 v_respuesta[4]=v_consulta;
                 
    
                 
                 RETURN v_respuesta;
			
			END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;