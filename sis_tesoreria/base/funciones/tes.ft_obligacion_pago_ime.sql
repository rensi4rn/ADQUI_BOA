CREATE OR REPLACE FUNCTION "tes"."ft_obligacion_pago_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Tesoreria
 FUNCION: 		tes.ft_obligacion_pago_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tes.tobligacion_pago'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        02-04-2013 16:01:32
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
	v_id_obligacion_pago	integer;
			    
BEGIN

    v_nombre_funcion = 'tes.ft_obligacion_pago_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TES_OBPG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	if(p_transaccion='TES_OBPG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into tes.tobligacion_pago(
			id_proveedor,
			estado,
			tipo_obligacion,
			id_moneda,
			obs,
			porc_retgar,
			id_subsistema,
			id_funcionario,
			estado_reg,
			porc_anticipo,
			id_estado_wf,
			id_depto,
			num_tramite,
			id_proceso_wf,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_proveedor,
			v_parametros.estado,
			v_parametros.tipo_obligacion,
			v_parametros.id_moneda,
			v_parametros.obs,
			v_parametros.porc_retgar,
			v_parametros.id_subsistema,
			v_parametros.id_funcionario,
			'activo',
			v_parametros.porc_anticipo,
			v_parametros.id_estado_wf,
			v_parametros.id_depto,
			v_parametros.num_tramite,
			v_parametros.id_proceso_wf,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_obligacion_pago into v_id_obligacion_pago;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obligaciones de Pago almacenado(a) con exito (id_obligacion_pago'||v_id_obligacion_pago||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_id_obligacion_pago::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TES_OBPG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_OBPG_MOD')then

		begin
			--Sentencia de la modificacion
			update tes.tobligacion_pago set
			id_proveedor = v_parametros.id_proveedor,
			estado = v_parametros.estado,
			tipo_obligacion = v_parametros.tipo_obligacion,
			id_moneda = v_parametros.id_moneda,
			obs = v_parametros.obs,
			porc_retgar = v_parametros.porc_retgar,
			id_subsistema = v_parametros.id_subsistema,
			id_funcionario = v_parametros.id_funcionario,
			porc_anticipo = v_parametros.porc_anticipo,
			id_estado_wf = v_parametros.id_estado_wf,
			id_depto = v_parametros.id_depto,
			num_tramite = v_parametros.num_tramite,
			id_proceso_wf = v_parametros.id_proceso_wf,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_obligacion_pago=v_parametros.id_obligacion_pago;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obligaciones de Pago modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TES_OBPG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 16:01:32
	***********************************/

	elsif(p_transaccion='TES_OBPG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from tes.tobligacion_pago
            where id_obligacion_pago=v_parametros.id_obligacion_pago;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Obligaciones de Pago eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_pago',v_parametros.id_obligacion_pago::varchar);
              
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
ALTER FUNCTION "tes"."ft_obligacion_pago_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
