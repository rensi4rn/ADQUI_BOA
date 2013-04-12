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
    
    v_otros_descuentos_mb numeric;
    v_monto_no_pagado_mb numeric;
    v_descuento_anticipo_mb numeric;
    
    v_nro_cuota integer;
    
    v_registros record;
    
    
    va_id_tipo_estado_pro integer[];
    va_codigo_estado_pro varchar[];
    va_disparador_pro varchar[];
    va_regla_pro varchar[];
    va_prioridad_pro integer[];
    
    v_id_estado_actual integer;
    
    
    v_id_proceso_wf integer;
    v_id_estado_wf varchar;
    v_codigo_estado varchar;
    
    v_monto_mb numeric;
    v_liquido_pagable numeric;
    
    v_liquido_pagable_mb numeric;
    
    v_monto_ejecutar_total_mo numeric;
    v_monto_ejecutar_total_mb numeric;
    
    v_tipo varchar;
    
    
    
			    
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
           --obtiene datos de la obligacion
           
          select
            op.porc_anticipo,
            op.porc_retgar,
            op.num_tramite,
            op.id_proceso_wf,
            op.id_estado_wf,
            op.estado,
            op.id_depto
            
          into v_registros  
           from tes.tobligacion_pago op
           where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
           
            
          -------------------------------------
          --  Manejo de estados con el WF
          -------------------------------------
            
          --cambia de estado al obligacion
          IF  v_estado_pro = 'registro' THEN
          
                   SELECT 
                     ps_id_tipo_estado,
                     ps_codigo_estado,
                     ps_disparador,
                     ps_regla,
                     ps_prioridad
                  into
                    va_id_tipo_estado_pro,
                    va_codigo_estado_pro,
                    va_disparador_pro,
                    va_regla_pro,
                    va_prioridad_pro
                          
                FROM wf.f_obtener_estado_wf(v_id_proceso_wf_pro, v_id_estado_wf_pro,NULL,'siguiente');   
          
        
                IF  va_id_tipo_estado_pro[2] is not null  THEN
                           
                          raise exception 'La obligacion se encuentra mal parametrizado dentro de Work Flow,  el estado registro  solo  admite un estado siguiente,  no admitido (%)',va_codigo_estado_pro[2];
                           
                END IF;
                          
                     
                IF  va_codigo_estado_pro[1] != 'en_pago'  THEN
                  raise exception 'La obligacion se encuentra mal parametrizado dentro de Work Flow, el siguiente estado para el proceso de compra deberia ser "en_pago" y no % ',va_codigo_estado_sol[1];
                END IF; 
                
                 -- registra estado eactual en el WF para rl procesod e compra
                    
                    
                     v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado_pro[1], 
                                                                   NULL, --id_funcionario
                                                                   v_id_estado_wf_pro, 
                                                                   v_id_proceso_wf_pro,
                                                                   p_id_usuario,
                                                                   v_id_depto);
                     
                    --actualiza el proceso
                    
                    -- actuliaza el stado en la solictud
                     update tes.tobligacion_pago  p set 
                       id_estado_wf =  v_id_estado_actual,
                       estado = va_codigo_estado_pro[1],
                       id_usuario_mod=p_id_usuario,
                       fecha_mod=now()
                     where id_obligacion_pago = v_parametros.id_obligacion_pago; 
                     
                     
                     --dispara estado para plan de pagos 
                    
                     SELECT
                               ps_id_proceso_wf,
                               ps_id_estado_wf,
                               ps_codigo_estado
                         into
                               v_id_proceso_wf,
                               v_id_estado_wf,
                               v_codigo_estado
                      FROM wf.f_registra_proceso_disparado_wf(
                               p_id_usuario,
                               v_id_estado_actual, 
                               NULL, 
                               v_registros.id_depto);
                  
      
      
          ELSEIF  v_estado_pro = 'en_pago' THEN
          
                 --registra estado de cotizacion
          
                 SELECT
                           ps_id_proceso_wf,
                           ps_id_estado_wf,
                           ps_codigo_estado
                     into
                           v_id_proceso_wf,
                           v_id_estado_wf,
                           v_codigo_estado
                  FROM wf.f_registra_proceso_disparado_wf(
                           p_id_usuario,
                           v_registros.id_estado_wf, 
                           NULL, 
                           v_registros.id_depto);
          
          
          ELSE
        
          
           		 raise exception 'Estado no reconocido % ', v_estado_pro;
          
          END IF;
        
        
        
         -------------------------------------
         --  Valifaciones  y conversiones
         ------------------------------------
        
        
        
           --convierte los monsto a moneda base
           
           v_otros_descuentos_mb  = v_parametros.otros_descuentos * v_parametros.tipo_cambio_conv;
           
           v_monto_no_pagado_mb  = v_parametros.monto_no_pagado * v_parametros.tipo_cambio_conv;
           
           v_descuento_anticipo_mb = v_parametros.descuento_anticipo* v_parametros.tipo_cambio_conv;
           
           v_monto_mb = v_parametros.monto * v_parametros.tipo_cambio_conv;
           
           -- calcula el liquido pagable y el monsto a ejecutar presupeustaria mente
           
           v_liquido_pagable = v_parametros.monto - v_parametros.descuento_anticipo - v_parametros.monto_no_pagado - v_parametros.otros_descuentos;
           v_monto_ejecutar_total_mo  = v_parametros.monto -  v_parametros.monto_no_pagado;
           
           v_liquido_pagable_mb = v_liquido_pagable * v_parametros.tipo_cambio_conv;
           v_monto_ejecutar_total_mb = v_monto_ejecutar_total_mo * v_parametros.tipo_cambio_conv;
           
           --  define por defecto el tipo como devengado
           
          
           
           ---------------------------------------------
           -- define numero de cuota
           ------------------------------------
           
           select   
             max(pp.nro_cuota)
           into
             v_nro_cuota
           from tes.tplan_pago pp 
           where 
               pp.id_obligacion_pago = v_parametros.id_obligacion_pago 
           and pp.estado_reg='activo';
            
           v_nro_cuota = floor(COALESCE(v_nro_cuota,0))+1;
           
           --actualiza la cuota vigente en la obligacion
           update tes.tobligacion_pago  p set 
                  nro_cuota_vigente =  v_nro_cuota
           where id_obligacion_pago = v_parametros.id_obligacion_pago; 
        
           
           -------------------------------------------
           -- valida tipo_pago anticipo o adelanto solo en la primera cuota
           ----------------------------------------------
            
            IF  v_parametros.tipo_pago in ('anticipo','adelanto') and  v_nro_cuota!=1 THEN
            
              raise exception 'Los anticipos y andelantos tienen que ser la primera cuota';
            
            ELSIF  v_parametros.tipo_pago in ('anticipo') and  v_nro_cuota=1 THEN
            
            --validamos que la obligacion tenga definido el  porceentaje por descuento de anticipo
               IF v_registros.porc_anticipo = 0 THEN
                 raise exception 'para registrar una ciota de anticipo tiene que definir un porcentaje de retención en la boligación';
               END IF;
            
            END IF;
            
       
            
            
            
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
			id_usuario_mod,
            liquido_pagable,
            liquido_pagable_mb
          	) values(
			'activo',
			v_nro_cuota,
			v_monto_ejecutar_total_mb,
			v_parametros.nro_sol_pago,
			v_parametros.tipo_cambio,
			v_parametros.fecha_pag,
			v_id_proceso_wf,
			v_parametros.fecha_dev,
			v_codigo_estado,
			v_parametros.tipo_pago,
			v_monto_ejecutar_total_mo,
			v_descuento_anticipo_mb,
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
			v_monto_no_pagado_mb,
			v_monto_mb,
			v_id_estado_wf,
			v_parametros.id_cuenta_bancaria,
			v_otros_descuentos_mb,
			v_parametros.forma_pago,
			v_parametros.monto_no_pagado,
			now(),
			p_id_usuario,
			null,
			null,
            v_liquido_pagable,
            v_liquido_pagable_mb
							
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