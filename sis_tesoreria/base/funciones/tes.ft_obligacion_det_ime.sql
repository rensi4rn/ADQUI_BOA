CREATE OR REPLACE FUNCTION "tes"."ft_obligacion_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Tesoreria
 FUNCION: 		tes.ft_obligacion_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tes.tobligacion_det'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        02-04-2013 20:27:35
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
	v_id_obligacion_det	integer;
			    
BEGIN

    v_nombre_funcion = 'tes.ft_obligacion_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TES_OBDET_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 20:27:35
	***********************************/

	if(p_transaccion='TES_OBDET_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into tes.tobligacion_det(
			estado_reg,
			id_cuenta,
			id_partida,
			id_auxiliar,
			id_concepto_ingas,
			monto_pago_mo,
			id_obligacion_pago,
			id_centro_costo,
			monto_pago_mb,
			factor_porcentual,
			id_partida_ejecucion_com,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_cuenta,
			v_parametros.id_partida,
			v_parametros.id_auxiliar,
			v_parametros.id_concepto_ingas,
			v_parametros.monto_pago_mo,
			v_parametros.id_obligacion_pago,
			v_parametros.id_centro_costo,
			v_parametros.monto_pago_mb,
			v_parametros.factor_porcentual,
			v_parametros.id_partida_ejecucion_com,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_obligacion_det into v_id_obligacion_det;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle almacenado(a) con exito (id_obligacion_det'||v_id_obligacion_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_det',v_id_obligacion_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TES_OBDET_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-04-2013 20:27:35
	***********************************/

	elsif(p_transaccion='TES_OBDET_MOD')then

		begin
			--Sentencia de la modificacion
			update tes.tobligacion_det set
			id_cuenta = v_parametros.id_cuenta,
			id_partida = v_parametros.id_partida,
			id_auxiliar = v_parametros.id_auxiliar,
			id_concepto_ingas = v_parametros.id_concepto_ingas,
			monto_pago_mo = v_parametros.monto_pago_mo,
			id_obligacion_pago = v_parametros.id_obligacion_pago,
			id_centro_costo = v_parametros.id_centro_costo,
			monto_pago_mb = v_parametros.monto_pago_mb,
			factor_porcentual = v_parametros.factor_porcentual,
			id_partida_ejecucion_com = v_parametros.id_partida_ejecucion_com,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_obligacion_det=v_parametros.id_obligacion_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_det',v_parametros.id_obligacion_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TES_OBDET_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-04-2013 20:27:35
	***********************************/

	elsif(p_transaccion='TES_OBDET_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from tes.tobligacion_det
            where id_obligacion_det=v_parametros.id_obligacion_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obligacion_det',v_parametros.id_obligacion_det::varchar);
              
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
ALTER FUNCTION "tes"."ft_obligacion_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
