CREATE OR REPLACE FUNCTION "dir"."f_persona_comunicacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		directorio
 FUNCION: 		dir.f_persona_comunicacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tpersona_comunicacion'
 AUTOR: 		 (admin)
 FECHA:	        08-01-2013 19:45:03
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_persona_comunicacion	integer;
			    
BEGIN

    v_nombre_funcion = 'dir.f_persona_comunicacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_PERCOM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 19:45:03
	***********************************/

	if(p_transaccion='DIR_PERCOM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dir.tpersona_comunicacion(
			estado_reg,
			id_tipo_comunicacion,
			valor,
			id_persona,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_tipo_comunicacion,
			v_parametros.valor,
			v_parametros.id_persona,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_persona_comunicacion into v_id_persona_comunicacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona Comunicacion almacenado(a) con exito (id_persona_comunicacion'||v_id_persona_comunicacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona_comunicacion',v_id_persona_comunicacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_PERCOM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 19:45:03
	***********************************/

	elsif(p_transaccion='DIR_PERCOM_MOD')then

		begin
			--Sentencia de la modificacion
			update dir.tpersona_comunicacion set
			id_tipo_comunicacion = v_parametros.id_tipo_comunicacion,
			valor = v_parametros.valor,
			id_persona = v_parametros.id_persona,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_persona_comunicacion=v_parametros.id_persona_comunicacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona Comunicacion modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona_comunicacion',v_parametros.id_persona_comunicacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_PERCOM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 19:45:03
	***********************************/

	elsif(p_transaccion='DIR_PERCOM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tpersona_comunicacion
            where id_persona_comunicacion=v_parametros.id_persona_comunicacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona Comunicacion eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona_comunicacion',v_parametros.id_persona_comunicacion::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "dir"."f_persona_comunicacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
