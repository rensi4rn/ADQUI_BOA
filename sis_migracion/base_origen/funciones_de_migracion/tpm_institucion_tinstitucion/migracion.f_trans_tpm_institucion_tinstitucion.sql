﻿CREATE OR REPLACE FUNCTION migracion.f_trans_tpm_institucion_tinstitucion (
  v_operacion varchar,
  p_id_institucion integer,
  p_id_persona integer,
  p_id_tipo_doc_institucion integer,
  p_casilla varchar,
  p_celular1 varchar,
  p_celular2 varchar,
  p_codigo_banco varchar,
  p_direccion varchar,
  p_doc_id varchar,
  p_email1 varchar,
  p_email2 varchar,
  p_estado_institucion varchar,
  p_fax varchar,
  p_fecha_registro date,
  p_fecha_ultima_modificacion date,
  p_hora_registro time,
  p_hora_ultima_modificacion time,
  p_nombre varchar,
  p_observaciones text,
  p_pag_web varchar,
  p_telefono1 varchar,
  p_telefono2 varchar
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
			v_codigo varchar;
			v_id_institucion int4;
			v_id_persona int4;
			v_cargo_representante varchar;
			v_casilla varchar;
			v_celular1 varchar;
			v_celular2 varchar;
			v_codigo_banco varchar;
			v_direccion varchar;
			v_doc_id varchar;
			v_email1 varchar;
			v_email2 varchar;
			v_es_banco varchar;
			v_estado_reg varchar;
			v_fax varchar;
			v_fecha_mod timestamp;
			v_fecha_reg timestamp;
			v_id_usuario_mod int4;
			v_id_usuario_reg int4;
			v_nombre varchar;
			v_observaciones text;
			v_pag_web varchar;
			v_telefono1 varchar;
			v_telefono2 varchar;
            v_nombre_largo varchar;
BEGIN
			
			
			          --funcion para obtener cadena de conexion
			          v_cadena_cnx =  migracion.f_obtener_cadena_con_dblink();
			          
			          
			           ---------------------------------------
			           --previamente se tranforman los datos  (descomentar)
			           ---------------------------------------
			
			v_nombre_largo := substr(split_part(ltrim(p_nombre),' ',1),0,11)||substr(split_part(ltrim(p_nombre),' ',2),0,5)||substr(split_part(ltrim(p_nombre),' ',3),0,4)||substr(split_part(ltrim(p_nombre),' ',4),0,4)||substr(split_part(ltrim(p_nombre),' ',5),0,4);
            
			v_codigo=convert(v_nombre_largo::varchar, 'LATIN1', 'UTF8');
			v_id_institucion=p_id_institucion::int4;
			v_id_persona=p_id_persona::int4;
			v_cargo_representante=convert(NULL::varchar, 'LATIN1', 'UTF8');
			v_casilla=convert(p_casilla::varchar, 'LATIN1', 'UTF8');
			v_celular1=convert(p_celular1::varchar, 'LATIN1', 'UTF8');
			v_celular2=convert(p_celular2::varchar, 'LATIN1', 'UTF8');
			v_codigo_banco=convert(p_codigo_banco::varchar, 'LATIN1', 'UTF8');
			v_direccion=convert(p_direccion::varchar, 'LATIN1', 'UTF8');
            if(p_doc_id='xxx' OR p_doc_id='sss' OR p_doc_id=0 OR p_doc_id=1)then 
            	v_doc_id=convert(NULL::varchar, 'LATIN1', 'UTF8');
            else	
				v_doc_id=convert(p_doc_id::varchar, 'LATIN1', 'UTF8');
			end if;
			v_email1=convert(p_email1::varchar, 'LATIN1', 'UTF8');
			v_email2=convert(p_email2::varchar, 'LATIN1', 'UTF8');
            if p_codigo_banco is null then
            	v_es_banco=convert('no'::varchar, 'LATIN1', 'UTF8');	
			else
            	v_es_banco=convert('si'::varchar, 'LATIN1', 'UTF8');
            end if;
			v_estado_reg=convert(p_estado_institucion::varchar, 'LATIN1', 'UTF8');
			v_fax=convert(p_fax::varchar, 'LATIN1', 'UTF8');
			v_fecha_mod=p_fecha_ultima_modificacion::timestamp;
			v_fecha_reg=p_fecha_registro::timestamp;
			v_id_usuario_mod=NULL::int4;
			v_id_usuario_reg=1::int4;
			v_nombre=convert(p_nombre::varchar, 'LATIN1', 'UTF8');
			v_observaciones=convert(p_observaciones::text, 'LATIN1', 'UTF8');
			v_pag_web=convert(p_pag_web::varchar, 'LATIN1', 'UTF8');
			v_telefono1=convert(p_telefono1::varchar, 'LATIN1', 'UTF8');
			v_telefono2=convert(p_telefono2::varchar, 'LATIN1', 'UTF8');
   
			    --cadena para la llamada a la funcion de insercion en la base de datos destino
			      
			        
			          v_consulta = 'select migra.f__on_trig_tpm_institucion_tinstitucion (
			               '''||v_operacion::varchar||''','||COALESCE(''''||v_codigo::varchar||'''','NULL')||','||COALESCE(v_id_institucion::varchar,'NULL')||','||COALESCE(v_id_persona::varchar,'NULL')||','||COALESCE(''''||v_cargo_representante::varchar||'''','NULL')||','||COALESCE(''''||v_casilla::varchar||'''','NULL')||','||COALESCE(''''||v_celular1::varchar||'''','NULL')||','||COALESCE(''''||v_celular2::varchar||'''','NULL')||','||COALESCE(''''||v_codigo_banco::varchar||'''','NULL')||','||COALESCE(''''||v_direccion::varchar||'''','NULL')||','||COALESCE(''''||v_doc_id::varchar||'''','NULL')||','||COALESCE(''''||v_email1::varchar||'''','NULL')||','||COALESCE(''''||v_email2::varchar||'''','NULL')||','||COALESCE(''''||v_es_banco::varchar||'''','NULL')||','||COALESCE(''''||v_estado_reg::varchar||'''','NULL')||','||COALESCE(''''||v_fax::varchar||'''','NULL')||','||COALESCE(''''||v_fecha_mod::varchar||'''','NULL')||','||COALESCE(''''||v_fecha_reg::varchar||'''','NULL')||','||COALESCE(v_id_usuario_mod::varchar,'NULL')||','||COALESCE(v_id_usuario_reg::varchar,'NULL')||','||COALESCE(''''||v_nombre::varchar||'''','NULL')||','||COALESCE(''''||v_observaciones::varchar||'''','NULL')||','||COALESCE(''''||v_pag_web::varchar||'''','NULL')||','||COALESCE(''''||v_telefono1::varchar||'''','NULL')||','||COALESCE(''''||v_telefono2::varchar||'''','NULL')||')';
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
                 v_res_cone=(select dblink_disconnect());
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