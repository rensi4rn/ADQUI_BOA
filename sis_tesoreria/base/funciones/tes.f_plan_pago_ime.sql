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
    v_monto_total numeric;
    
    v_nro_cuota numeric;
    
    v_registros record;
     va_id_tipo_estado_pro integer[];
    va_codigo_estado_pro varchar[];
    va_disparador_pro varchar[];
    va_regla_pro varchar[];
    va_prioridad_pro integer[];
    
    v_id_estado_actual integer;
    
    
    v_id_proceso_wf integer;
    v_id_estado_wf integer;
    v_codigo_estado varchar;
    
    v_monto_mb numeric;
    v_liquido_pagable numeric;
    
    v_liquido_pagable_mb numeric;
    
    v_monto_ejecutar_total_mo numeric;
    v_monto_ejecutar_total_mb numeric;
    
    v_tipo varchar;
    v_id_tipo_estado integer;
    v_fecha_tentativa date;
    v_monto numeric;
    v_cont integer;  
    v_id_prorrateo integer;
  
    
    
			    
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
        
           --validamos que el monto a pagar sea mayor que cero
           
           IF  v_parametros.monto = 0 THEN
           
              raise exception 'El monto a pagar no puede ser 0';
           
           END IF;
           
           
           --obtiene datos de la obligacion
           
          select
            op.porc_anticipo,
            op.porc_retgar,
            op.num_tramite,
            op.id_proceso_wf,
            op.id_estado_wf,
            op.estado,
            op.id_depto,
            op.pago_variable
            
          into v_registros  
           from tes.tobligacion_pago op
           where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
           
           
           select   
             max(pp.nro_cuota),
             max(pp.fecha_tentativa)
           into
             v_nro_cuota,
             v_fecha_tentativa
           from tes.tplan_pago pp 
           where 
               pp.id_obligacion_pago = v_parametros.id_obligacion_pago 
           and pp.estado_reg='activo';
           
           
           
            --si es un proceso variable, verifica que el registro no sobrepase el total a pagar
           
           IF v_registros.pago_variable='no' THEN
              v_monto_total= tes.f_determinar_total_faltante(v_parametros.id_obligacion_pago, 'registrado');
           
              IF v_monto_total <  v_parametros.monto  THEN
              
                  raise exception 'No puede exceder el total a pagar en obligaciones no variables';
              
              END IF;
           
           END IF;
           
         
          IF  v_parametros.monto < 0 or v_parametros.monto_no_pagado < 0 or v_parametros.otros_descuentos  < 0 THEN
          
             raise exception 'No se admiten cifras negativas'; 
          END IF;
        
           
          -- calcula el liquido pagable y el monsto a ejecutar presupeustaria mente
           
           v_liquido_pagable = COALESCE(v_parametros.monto,0) - COALESCE(v_parametros.monto_no_pagado,0) - COALESCE(v_parametros.otros_descuentos,0); -- - COALESCE(v_parametros.descuento_anticipo,0);
           v_monto_ejecutar_total_mo  = COALESCE(v_parametros.monto,0) -  COALESCE(v_parametros.monto_no_pagado,0);
          
          
          
          IF   v_liquido_pagable  < 0  or v_monto_ejecutar_total_mo < 0  THEN
              raise exception ' Ni  el monto a ejecutar   ni el liquido pagable  puede ser menor a cero';
          END IF;  
           
            
         -- raise exception 'xxx %',v_registros;
           
          -------------------------------------
          --  Manejo de estados con el WF
          -------------------------------------
            
          --cambia de estado al obligacion
          IF  v_registros.estado = 'registrado' THEN
          
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
                          
                FROM wf.f_obtener_estado_wf( v_registros.id_proceso_wf,  v_registros.id_estado_wf,NULL,'siguiente');   
          
        
                IF  va_id_tipo_estado_pro[2] is not null  THEN
                           
                          raise exception 'La obligacion se encuentra mal parametrizado dentro de Work Flow,  el estado registro  solo  admite un estado siguiente,  no admitido (%)',va_codigo_estado_pro[2];
                           
                END IF;
                          
                     
                IF  va_codigo_estado_pro[1] != 'en_pago'  THEN
                  raise exception 'La obligacion se encuentra mal parametrizado dentro de Work Flow, el siguiente estado para el proceso de compra deberia ser "en_pago" y no % ',va_codigo_estado_sol[1];
                END IF; 
                
                 -- registra estado eactual en el WF para rl procesod e compra
                     
                     v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado_pro[1], 
                                                                   NULL, --id_funcionario
                                                                    v_registros.id_estado_wf, 
                                                                    v_registros.id_proceso_wf,
                                                                    p_id_usuario,
                                                                    v_registros.id_depto);
                    
                    --actualiza el proceso
                    
                    -- actuliaza el stado en la solictud
                     update tes.tobligacion_pago  p set 
                       id_estado_wf =  v_id_estado_actual,
                       estado = va_codigo_estado_pro[1],
                       id_usuario_mod=p_id_usuario,
                       fecha_mod=now()
                     where id_obligacion_pago = v_parametros.id_obligacion_pago; 
                     
                      -- raise exception 'xxxxxxxxxxxxx  %', v_id_estado_actual ;
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
                  
      
                    
      
          ELSEIF   v_registros.estado = 'en_pago' THEN
          
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
        
          
           		 raise exception 'Estado no reconocido % ',  v_registros.estado;
          
          END IF;
        
        
        
         
           
           -- define numero de cuota
          
           v_nro_cuota = floor(COALESCE(v_nro_cuota,0))+1;
           
           --actualiza la cuota vigente en la obligacion
           update tes.tobligacion_pago  p set 
                  nro_cuota_vigente =  v_nro_cuota
           where id_obligacion_pago = v_parametros.id_obligacion_pago; 
        
          
          --valida que la fecha tentativa
          
          IF v_fecha_tentativa > v_parametros.fecha_tentativa THEN
          
            raise exception 'La fecha tentativa no puede ser inferior a la fecha tentativa de la ultima cuota registrada';
          
          END IF;
        
           
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
		    nro_sol_pago,
            id_proceso_wf,
		    estado,
			tipo_pago,
			monto_ejecutar_total_mo,
			--obs_descuentos_anticipo,
			id_plan_pago_fk,
			id_obligacion_pago,
			id_plantilla,
			--descuento_anticipo,
			otros_descuentos,
			tipo,
			obs_monto_no_pagado,
			obs_otros_descuentos,
			monto,
		    nombre_pago,
            id_estado_wf,
		    id_cuenta_bancaria,
			forma_pago,
			monto_no_pagado,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            liquido_pagable,
            fecha_tentativa
          	) values(
			'activo',
			v_nro_cuota,
			'---',--'v_parametros.nro_sol_pago',
			v_id_proceso_wf,
			v_codigo_estado,
			v_parametros.tipo_pago,
			v_monto_ejecutar_total_mo,
			--v_parametros.obs_descuentos_anticipo,
			v_parametros.id_plan_pago_fk,
			v_parametros.id_obligacion_pago,
			v_parametros.id_plantilla,
			--v_parametros.descuento_anticipo,
			v_parametros.otros_descuentos,
			v_parametros.tipo,
			v_parametros.obs_monto_no_pagado,
			v_parametros.obs_otros_descuentos,
			v_parametros.monto,
			v_parametros.nombre_pago,
		    v_id_estado_wf,
			v_parametros.id_cuenta_bancaria,
			v_parametros.forma_pago,
			v_parametros.monto_no_pagado,
			now(),
			p_id_usuario,
			null,
			null,
            v_liquido_pagable,
            v_parametros.fecha_tentativa
							
			)RETURNING id_plan_pago into v_id_plan_pago;
            
            
            --------------------------------------------------
            -- Inserta prorrateo automatico
            ------------------------------------------------
            v_monto_total=0; 
            IF v_registros.pago_variable = 'no' THEN
            
            --si los pagos no son variable puede hacerce un prorrateo automatico
            
                      v_cont = 0;
                     
                      FOR  v_registros in (
                                           select
                                            od.id_obligacion_det,
                                            od.factor_porcentual
                                           from tes.tobligacion_det od
                                           where  od.id_obligacion_pago = v_parametros.id_obligacion_pago) LOOP
                      
                        v_cont = v_cont +v_cont;
                        
                        --calcula el importe prorrateado segun factor
                        v_monto= round(v_monto_ejecutar_total_mo * v_registros.factor_porcentual,2);
                        v_monto_total=v_monto_total+v_monto;
                        
                        INSERT INTO 
                              tes.tprorrateo
                            (
                              id_usuario_reg,
                              fecha_reg,
                              estado_reg,
                              id_plan_pago,
                              id_obligacion_det,
                              monto_ejecutar_mo
                            ) 
                            VALUES (
                              p_id_usuario,
                              now(),
                              'activo',
                              v_id_plan_pago,
                              v_registros.id_obligacion_det,
                             v_monto
                            
                            )RETURNING id_prorrateo into v_id_prorrateo;
                        
                       
                      END LOOP;
                      
                      IF v_monto_total!=v_monto_ejecutar_total_mo  THEN
                        
                         update tes.tprorrateo p set
                         monto_ejecutar_mo =   v_monto_ejecutar_total_mo-(v_monto-monto_ejecutar_mo)
                         where p.id_prorrateo = v_id_prorrateo;
                      
                      END IF;
                     
            
                       --actualiza el monto prorrateado para alerta en la interface cuando no cuadre
                      update  tes.tplan_pago pp set
                      total_prorrateado=v_monto_ejecutar_total_mo
                      where pp.id_plan_pago = v_id_plan_pago;
                      
                     
            
                      
              ELSE
              --si los pagos no son automatico solo insertamos la base del prorrateo con valor cero
                
                    FOR  v_registros in (
                                               select
                                                od.id_obligacion_det,
                                                od.factor_porcentual
                                               from tes.tobligacion_det od
                                               where  od.id_obligacion_pago = v_parametros.id_obligacion_pago) LOOP
                          
                            INSERT INTO 
                                  tes.tprorrateo
                                (
                                  id_usuario_reg,
                                  fecha_reg,
                                  estado_reg,
                                  id_plan_pago,
                                  id_obligacion_det,
                                  monto_ejecutar_mo
                                ) 
                                VALUES (
                                  p_id_usuario,
                                  now(),
                                  'activo',
                                  v_id_plan_pago,
                                  v_registros.id_obligacion_det,
                                  0
                                )RETURNING id_prorrateo into v_id_prorrateo;
                  
                    
                    
                     END LOOP;
                   
                     
                     
              END IF;
			
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
        
        
            --validamos que el monto a pagar sea mayor que cero
           
           IF  v_parametros.monto = 0 THEN
           
              raise exception 'El monto a pagar no puede ser 0';
           
           END IF;
           
           
           --obtiene datos de la obligacion
           
          select
            op.porc_anticipo,
            op.porc_retgar,
            op.num_tramite,
            op.id_proceso_wf,
            op.id_estado_wf,
            op.estado,
            op.id_depto,
            op.pago_variable
            
          into v_registros  
           from tes.tobligacion_pago op
           where op.id_obligacion_pago = v_parametros.id_obligacion_pago;
           
           
           select   
            pp.monto,
            pp.estado
           into
             v_monto,
             v_codigo_estado
           from tes.tplan_pago pp 
           where pp.estado_reg='activo'
           and  pp.id_plan_pago= v_parametros.id_plan_pago ;
           
           
           IF v_codigo_estado != 'borrador' THEN
           
             raise exception 'Solo puede modificar pagos en estado borrador';  
           
           END IF;
           
           
           
            --si es un proceso variable, verifica que el registro no sobrepase el total a pagar
           
           IF v_registros.pago_variable='no' THEN
              v_monto_total= tes.f_determinar_total_faltante(v_parametros.id_obligacion_pago, 'registrado');
           
              IF (v_monto_total + v_monto)  <  v_parametros.monto  THEN
              
                  raise exception 'No puede exceder el total a pagar en obligaciones no variables';
              
              END IF;
           
           END IF;
        
        
            -- calcula el liquido pagable y el monsto a ejecutar presupeustaria mente
           
           IF  v_parametros.monto <0 or v_parametros.monto_no_pagado <0 or v_parametros.otros_descuentos  <0 THEN
          
               raise exception 'No se admiten cifras negativas'; 
           END IF;
           
           v_liquido_pagable = COALESCE(v_parametros.monto,0) - COALESCE(v_parametros.monto_no_pagado,0) - COALESCE(v_parametros.otros_descuentos,0);-- - COALESCE(v_parametros.descuento_anticipo,0);
           v_monto_ejecutar_total_mo  = COALESCE(v_parametros.monto,0) -  COALESCE(v_parametros.monto_no_pagado,0);
           
           IF   v_liquido_pagable  < 0  or v_monto_ejecutar_total_mo < 0  THEN
                raise exception ' Ni el  monto a ejecutar   ni el liquido pagable  puede ser menor a cero';
           END IF;
           
           
        
        
			--Sentencia de la modificacion
			update tes.tplan_pago set
			monto_ejecutar_total_mo = v_monto_ejecutar_total_mo,
			--obs_descuentos_anticipo = v_parametros.obs_descuentos_anticipo,
			id_plantilla = v_parametros.id_plantilla,
			--descuento_anticipo = COALESCE(v_parametros.descuento_anticipo,0),
			otros_descuentos = COALESCE( v_parametros.otros_descuentos,0),
			obs_monto_no_pagado = v_parametros.obs_monto_no_pagado,
			obs_otros_descuentos = v_parametros.obs_otros_descuentos,
			monto = v_parametros.monto,
			nombre_pago = v_parametros.nombre_pago,
			id_cuenta_bancaria = v_parametros.id_cuenta_bancaria,
			forma_pago = v_parametros.forma_pago,
			monto_no_pagado = v_parametros.monto_no_pagado,
            liquido_pagable=v_liquido_pagable,
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
			
            --obtiene datos de plan de pago
            
             --obtiene datos de la obligacion
           
          
           
          select
            pp.estado,
            pp.nro_cuota,
            pp.tipo_pago ,
            pp.tipo,
            pp.id_proceso_wf,
            pp.id_obligacion_pago,
            op.id_depto,
            pp.id_estado_wf
          into v_registros  
           from tes.tplan_pago pp
           inner join tes.tobligacion_pago op on op.id_obligacion_pago = pp.id_obligacion_pago
           where pp.id_plan_pago = v_parametros.id_plan_pago;
           
          
          
           
           IF  v_registros.estado != 'borrador' THEN
           
             raise exception 'No puede elimiar cuotas  que no esten en estado borrador';
           
           END IF;
           
           
           --si es una cuota de devengao_pago o devengado validamos que elimine
           --primero la ultima cuota
           
          
           IF  v_registros.tipo in  ('devengado_pagado','devengado')   THEN
               select 
                max(pp.nro_cuota)
               into
                v_nro_cuota
               from tes.tplan_pago pp 
               where 
                  pp.id_obligacion_pago = v_registros.id_obligacion_pago 
                   and   pp.estado_reg = 'activo';
               
               v_nro_cuota = floor(COALESCE(v_nro_cuota,0));
               
               IF v_nro_cuota != v_registros.nro_cuota THEN
               
                 raise exception 'Elimine primero la ultima cuota';
               
                END IF;
                
             
           
            
               
               
               --recuperamos el id_tipo_proceso en el WF para el estado anulado
               --ya que este es un estado especial que no tiene padres definidos
               
               
               select 
               	te.id_tipo_estado
               into
               	v_id_tipo_estado
               from wf.tproceso_wf pw 
               inner join wf.ttipo_proceso tp on pw.id_tipo_proceso = tp.id_tipo_proceso
               inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.codigo = 'anulado'               
               where pw.id_proceso_wf = v_registros.id_proceso_wf;
               
              
              
               -- pasamos la cotizacion al siguiente estado
           
               v_id_estado_actual =  wf.f_registra_estado_wf(v_id_tipo_estado, 
                                                           NULL, 
                                                           v_registros.id_estado_wf, 
                                                           v_registros.id_proceso_wf,
                                                           p_id_usuario,
                                                           v_registros.id_depto);
            
            
               -- actualiza estado en la cotizacion
              
               update tes.tplan_pago  pp set 
                 id_estado_wf =  v_id_estado_actual,
                 estado = 'anulado',
                 id_usuario_mod=p_id_usuario,
                 fecha_mod=now(),
                 estado_reg='inactivo'
               where pp.id_plan_pago  = v_parametros.id_plan_pago;
          
              --actulizamos el nro_cuota actual actual en obligacion_pago
          
          
              update tes.tobligacion_pago op set
                 nro_cuota_vigente = v_nro_cuota - 1
               where   op.id_obligacion_pago = v_registros.id_obligacion_pago;
               
               
             --elimina los prorrateos
              update  tes.tprorrateo pro  set 
               estado_reg='inactivo'
              where pro.id_plan_pago =  v_parametros.id_plan_pago; 
               
          
           
            ELSIF  v_registros.tipo in ('pagado')   THEN
             --TO DO, por implemtar eliminacion de cuotas de pago
             
                 raise exception 'No implementado eliminacion de tipo_pago = pago';
             
            
            ELSE
            
                raise exception 'Tipo no reconocido';
            
            END IF;
           
            
            
            
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