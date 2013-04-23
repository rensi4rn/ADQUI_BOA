CREATE OR REPLACE FUNCTION dir.f_empresa_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Directorio
 FUNCION: 		dir.f_empresa_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dir.tempresa'
 AUTOR: 		 (admin)
 FECHA:	        15-03-2013 21:40:25
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
	v_id_empresa	integer;
			    
BEGIN

    v_nombre_funcion = 'dir.f_empresa_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_EMP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:40:25
	***********************************/

	if(p_transaccion='DIR_EMP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dir.tempresa(
			estado_reg,
			tipo_sociedad,
			actividad,
			actividad_esp,
			nit,
			actividad_gral,
			domicilio,
			matricula,
			--renovado,
			actividad_prim,
			nombre,
			departamento,
			telefono,
			municipio,
			--estado_matricula,
			mail,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.tipo_sociedad,
			v_parametros.actividad,
			v_parametros.actividad_esp,
			v_parametros.nit,
			v_parametros.actividad_gral,
			v_parametros.domicilio,
			v_parametros.matricula,
			--v_parametros.renovado,
			v_parametros.actividad_prim,
			v_parametros.nombre,
			v_parametros.departamento,
			v_parametros.telefono,
			v_parametros.municipio,
			--v_parametros.estado_matricula,
			v_parametros.mail,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_empresa into v_id_empresa;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa almacenado(a) con exito (id_empresa'||v_id_empresa||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_id_empresa::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIR_EMP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:40:25
	***********************************/

	elsif(p_transaccion='DIR_EMP_MOD')then

		begin
			--Sentencia de la modificacion
			update dir.tempresa set
			tipo_sociedad = v_parametros.tipo_sociedad,
			objeto = v_parametros.objeto,
			dir_comercial = v_parametros.dir_comercial,
			nit = v_parametros.nit,
			clase = v_parametros.clase,
			domicilio = v_parametros.domicilio,
			matricula = v_parametros.matricula,
			renovado = v_parametros.renovado,
			domicilio_legal = v_parametros.domicilio_legal,
			nombre = v_parametros.nombre,
			seccion = v_parametros.seccion,
			telefono = v_parametros.telefono,
			divission = v_parametros.divission,
			estado_matricula = v_parametros.estado_matricula,
			mail = v_parametros.mail,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_empresa=v_parametros.id_empresa;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_EMP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:40:25
	***********************************/

	elsif(p_transaccion='DIR_EMP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dir.tempresa
            where id_empresa=v_parametros.id_empresa;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
              
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