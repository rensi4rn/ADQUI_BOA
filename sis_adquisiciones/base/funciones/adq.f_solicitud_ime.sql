CREATE OR REPLACE FUNCTION "adq"."f_solicitud_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_solicitud_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'adq.tsolicitud'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 12:12:51
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
	v_id_solicitud	integer;
			    
BEGIN

    v_nombre_funcion = 'adq.f_solicitud_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_SOL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	if(p_transaccion='ADQ_SOL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into adq.tsolicitud(
			estado_reg,
			id_solicitud_ext,
			presu_revertido,
			fecha_apro,
			estado,
			id_funcionario_aprobador,
			id_moneda,
			id_gestion,
			tipo,
			num_tramite,
			justificacion,
			id_depto,
			lugar_entrega,
			extendida,
			numero,
			posibles_proveedores,
			id_proceso_wf,
			comite_calificacion,
			id_categoria_compra,
			id_funcionario,
			id_estado_wf,
			fecha_soli,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_solicitud_ext,
			v_parametros.presu_revertido,
			v_parametros.fecha_apro,
			v_parametros.estado,
			v_parametros.id_funcionario_aprobador,
			v_parametros.id_moneda,
			v_parametros.id_gestion,
			v_parametros.tipo,
			v_parametros.num_tramite,
			v_parametros.justificacion,
			v_parametros.id_depto,
			v_parametros.lugar_entrega,
			v_parametros.extendida,
			v_parametros.numero,
			v_parametros.posibles_proveedores,
			v_parametros.id_proceso_wf,
			v_parametros.comite_calificacion,
			v_parametros.id_categoria_compra,
			v_parametros.id_funcionario,
			v_parametros.id_estado_wf,
			v_parametros.fecha_soli,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_solicitud into v_id_solicitud;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Compras almacenado(a) con exito (id_solicitud'||v_id_solicitud||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud',v_id_solicitud::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_SOL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elsif(p_transaccion='ADQ_SOL_MOD')then

		begin
			--Sentencia de la modificacion
			update adq.tsolicitud set
			id_solicitud_ext = v_parametros.id_solicitud_ext,
			presu_revertido = v_parametros.presu_revertido,
			fecha_apro = v_parametros.fecha_apro,
			estado = v_parametros.estado,
			id_funcionario_aprobador = v_parametros.id_funcionario_aprobador,
			id_moneda = v_parametros.id_moneda,
			id_gestion = v_parametros.id_gestion,
			tipo = v_parametros.tipo,
			num_tramite = v_parametros.num_tramite,
			justificacion = v_parametros.justificacion,
			id_depto = v_parametros.id_depto,
			lugar_entrega = v_parametros.lugar_entrega,
			extendida = v_parametros.extendida,
			numero = v_parametros.numero,
			posibles_proveedores = v_parametros.posibles_proveedores,
			id_proceso_wf = v_parametros.id_proceso_wf,
			comite_calificacion = v_parametros.comite_calificacion,
			id_categoria_compra = v_parametros.id_categoria_compra,
			id_funcionario = v_parametros.id_funcionario,
			id_estado_wf = v_parametros.id_estado_wf,
			fecha_soli = v_parametros.fecha_soli,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_solicitud=v_parametros.id_solicitud;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Compras modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud',v_parametros.id_solicitud::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_SOL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elsif(p_transaccion='ADQ_SOL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from adq.tsolicitud
            where id_solicitud=v_parametros.id_solicitud;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud de Compras eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud',v_parametros.id_solicitud::varchar);
              
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
ALTER FUNCTION "adq"."f_solicitud_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
