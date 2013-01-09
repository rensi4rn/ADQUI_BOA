--------------- SQL ---------------

CREATE OR REPLACE FUNCTION dir.f_tipo_comunicacion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		directorio
 FUNCION: 		dir.f_tipo_comunicacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.ttipo_comunicacion'
 AUTOR: 		 (admin)
 FECHA:	        08-01-2013 19:18:16
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
	v_id_tiipo_comunicacion	integer;
			    
BEGIN

    v_nombre_funcion = 'dir.f_tipo_comunicacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_TIC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 19:18:16
	***********************************/

	if(p_transaccion='DIR_TIC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dir.ttipo_comunicacion(
			estado_reg,
			nombre,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            obs
          	) values(
			'activo',
			v_parametros.nombre,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.obs
							
			)RETURNING id_tiipo_comunicacion into v_id_tiipo_comunicacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo  Comunicacion almacenado(a) con exito (id_tiipo_comunicacion'||v_id_tiipo_comunicacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tiipo_comunicacion',v_id_tiipo_comunicacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_TIC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 19:18:16
	***********************************/

	elsif(p_transaccion='DIR_TIC_MOD')then

		begin
			--Sentencia de la modificacion
			update dir.ttipo_comunicacion set
			nombre = v_parametros.nombre,
            obs=v_parametros.obs,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tiipo_comunicacion=v_parametros.id_tiipo_comunicacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo  Comunicacion modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tiipo_comunicacion',v_parametros.id_tiipo_comunicacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_TIC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 19:18:16
	***********************************/

	elsif(p_transaccion='DIR_TIC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.ttipo_comunicacion
            where id_tiipo_comunicacion=v_parametros.id_tiipo_comunicacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo  Comunicacion eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tiipo_comunicacion',v_parametros.id_tiipo_comunicacion::varchar);
              
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;