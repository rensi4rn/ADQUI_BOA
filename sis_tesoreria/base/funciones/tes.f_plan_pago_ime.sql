--------------- SQL ---------------

CREATE OR REPLACE FUNCTION tes.f_plan_pago_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Tesoreria
 FUNCION: 		tes.f_plan_pago_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tes.tplan_pago'
 AUTOR: 		 (admin)
 FECHA:	        10-04-2013 15:43:23
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
	v_id_plan_pago	integer;
			    
BEGIN

    v_nombre_funcion = 'tes.f_plan_pago_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TES_PLAPA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-04-2013 15:43:23
	***********************************/

	if(p_transaccion='TES_PLAPA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into tes.tplan_pago(
			estado_reg,
			nro_cuota,
			monto_ejecutar_total_mb,
			nro_sol_pago,
			tipo_cambio,
			fecha_pag,
			id_proceso_wf,
			fecha_dev,
			estado,
			tipo_pago,
			monto_ejecutar_total_mo,
			descuento_anticipo_mb,
			obs_descuentos_anticipo,
			id_plan_pago_fk,
			id_obligacion_pago,
			id_plantilla,
			descuento_anticipo,
			otros_decuentos,
			tipo,
			obs_monto_no_pagado,
			obs_otros_descuentos,
			monto,
			id_comprobante,
			nombre_pago,
			monto_no_pagado_mb,
			monto_mb,
			id_estado_wf,
			id_cuenta_bancaria,
			otros_descuentos_mb,
			forma_pago,
			monto_no_pagado,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nro_cuota,
			v_parametros.monto_ejecutar_total_mb,
			v_parametros.nro_sol_pago,
			v_parametros.tipo_cambio,
			v_parametros.fecha_pag,
			v_parametros.id_proceso_wf,
			v_parametros.fecha_dev,
			v_parametros.estado,
			v_parametros.tipo_pago,
			v_parametros.monto_ejecutar_total_mo,
			v_parametros.descuento_anticipo_mb,
			v_parametros.obs_descuentos_anticipo,
			v_parametros.id_plan_pago_fk,
			v_parametros.id_obligacion_pago,
			v_parametros.id_plantilla,
			v_parametros.descuento_anticipo,
			v_parametros.otros_decuentos,
			v_parametros.tipo,
			v_parametros.obs_monto_no_pagado,
			v_parametros.obs_otros_descuentos,
			v_parametros.monto,
			v_parametros.id_comprobante,
			v_parametros.nombre_pago,
			v_parametros.monto_no_pagado_mb,
			v_parametros.monto_mb,
			v_parametros.id_estado_wf,
			v_parametros.id_cuenta_bancaria,
			v_parametros.otros_descuentos_mb,
			v_parametros.forma_pago,
			v_parametros.monto_no_pagado,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_plan_pago into v_id_plan_pago;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plan Pago almacenado(a) con exito (id_plan_pago'||v_id_plan_pago||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plan_pago',v_id_plan_pago::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TES_PLAPA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-04-2013 15:43:23
	***********************************/

	elsif(p_transaccion='TES_PLAPA_MOD')then

		begin
			--Sentencia de la modificacion
			update tes.tplan_pago set
			nro_cuota = v_parametros.nro_cuota,
			monto_ejecutar_total_mb = v_parametros.monto_ejecutar_total_mb,
			nro_sol_pago = v_parametros.nro_sol_pago,
			tipo_cambio = v_parametros.tipo_cambio,
			fecha_pag = v_parametros.fecha_pag,
			id_proceso_wf = v_parametros.id_proceso_wf,
			fecha_dev = v_parametros.fecha_dev,
			estado = v_parametros.estado,
			tipo_pago = v_parametros.tipo_pago,
			monto_ejecutar_total_mo = v_parametros.monto_ejecutar_total_mo,
			descuento_anticipo_mb = v_parametros.descuento_anticipo_mb,
			obs_descuentos_anticipo = v_parametros.obs_descuentos_anticipo,
			id_plan_pago_fk = v_parametros.id_plan_pago_fk,
			id_obligacion_pago = v_parametros.id_obligacion_pago,
			id_plantilla = v_parametros.id_plantilla,
			descuento_anticipo = v_parametros.descuento_anticipo,
			otros_decuentos = v_parametros.otros_decuentos,
			tipo = v_parametros.tipo,
			obs_monto_no_pagado = v_parametros.obs_monto_no_pagado,
			obs_otros_descuentos = v_parametros.obs_otros_descuentos,
			monto = v_parametros.monto,
			id_comprobante = v_parametros.id_comprobante,
			nombre_pago = v_parametros.nombre_pago,
			monto_no_pagado_mb = v_parametros.monto_no_pagado_mb,
			monto_mb = v_parametros.monto_mb,
			id_estado_wf = v_parametros.id_estado_wf,
			id_cuenta_bancaria = v_parametros.id_cuenta_bancaria,
			otros_descuentos_mb = v_parametros.otros_descuentos_mb,
			forma_pago = v_parametros.forma_pago,
			monto_no_pagado = v_parametros.monto_no_pagado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_plan_pago=v_parametros.id_plan_pago;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plan Pago modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plan_pago',v_parametros.id_plan_pago::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TES_PLAPA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-04-2013 15:43:23
	***********************************/

	elsif(p_transaccion='TES_PLAPA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from tes.tplan_pago
            where id_plan_pago=v_parametros.id_plan_pago;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plan Pago eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plan_pago',v_parametros.id_plan_pago::varchar);
              
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