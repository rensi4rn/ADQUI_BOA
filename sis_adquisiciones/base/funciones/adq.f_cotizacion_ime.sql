--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_cotizacion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_cotizacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'adq.tcotizacion'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        21-03-2013 14:48:35
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
	v_id_cotizacion	integer;
    
    v_id_proceso_wf_pro integer;
    v_id_estado_wf_pro integer;
    v_num_tramite varchar;
    v_estado_pro varchar;
    
      va_id_tipo_estado_pro integer[];
      va_codigo_estado_pro varchar[];
      va_disparador_pro varchar[];
      va_regla_pro varchar[];
      va_prioridad_pro integer[];
      
      v_id_estado_actual integer;
      
      v_id_depto integer;
      
      
       v_id_proceso_wf integer;
       v_id_estado_wf integer;
       v_codigo_estado varchar;
       
       v_registros record;
       
       v_id_solicitud integer;
       
       v_total_detalle numeric;
       v_tipo_cambio_conv numeric;
       
       v_id_moneda integer;
       
        va_id_tipo_estado integer[];
        va_codigo_estado varchar[];
        va_disparador varchar[];
        va_regla varchar[];
        va_prioridad  integer[];
        
        v_id_proceso_compra integer;
        v_estado_cot varchar;
     
			    
BEGIN

    v_nombre_funcion = 'adq.f_cotizacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_COT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 14:48:35
	***********************************/

	if(p_transaccion='ADQ_COT_INS')then
					
        begin
        
           --obtener datos del proceso de compra
           
           
           select
            pc.num_tramite,
            pc.id_proceso_wf,
            pc.id_estado_wf,
            pc.estado,
            pc.id_depto,
            pc.id_solicitud
           into
            v_num_tramite,
            v_id_proceso_wf_pro,
            v_id_estado_wf_pro,
            v_estado_pro,
            v_id_depto,
            v_id_solicitud
           from adq.tproceso_compra pc
           where pc.id_proceso_compra = v_parametros.id_proceso_compra;
           

          -- raise exception ' xxxxxxxx   % - %', v_estado_pro, v_parametros.id_proceso_compra;

          IF  v_estado_pro = 'pendiente' THEN
                         
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
                       
                      raise exception 'El proceso se encuentra mal parametrizado dentro de Work Flow,  el estado pendiente de proceso solo  admite un estado siguiente,  no admitido (%)',va_codigo_estado_pro[2];
                      
                    END IF;
                      
                  
                  
                    IF  va_codigo_estado_pro[1] != 'proceso'  THEN
                      raise exception 'El proceso se encuentra mal parametrizado dentro de Work Flow, elsiguiente estado para el proceso de compra deberia ser "proceso" y no % ',va_codigo_estado_sol[1];
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
                     update adq.tproceso_compra  p set 
                       id_estado_wf =  v_id_estado_actual,
                       estado = va_codigo_estado_pro[1],
                       id_usuario_mod=p_id_usuario,
                       fecha_mod=now()
                     where id_proceso_compra = v_parametros.id_proceso_compra; 
                  
                    --iniciar el proceso WF
                     
                               
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
                               v_id_estado_actual, 
                               NULL, 
                               v_id_depto);
                  
          
           ELSEIF  v_estado_pro = 'proceso' THEN
          
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
                           v_id_estado_wf_pro, 
                           NULL, 
                           v_id_depto);
          ELSE
        
          
           		 raise exception 'Estado no reconocido % ', v_estado_pro;
          
          END IF;
          
          
          
           
            
        
        
        	--Sentencia de la insercion
        	insert into adq.tcotizacion(
			estado_reg,
			estado,
			lugar_entrega,
			tipo_entrega,
			fecha_coti,
		
			id_proveedor,
			--porc_anticipo,
			--precio_total,
			fecha_entrega,
			id_moneda,
			id_proceso_compra,
			fecha_venc,
			obs,
			fecha_adju,
			nro_contrato,
			--porc_retgar,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            id_estado_wf,
            id_proceso_wf,
            tipo_cambio_conv
          	) values(
			'activo',
			v_codigo_estado,
			v_parametros.lugar_entrega,
			v_parametros.tipo_entrega,
			v_parametros.fecha_coti,
		
			v_parametros.id_proveedor,
			--v_parametros.porc_anticipo,
			--v_parametros.precio_total,
			v_parametros.fecha_entrega,
			v_parametros.id_moneda,
			v_parametros.id_proceso_compra,
			v_parametros.fecha_venc,
			v_parametros.obs,
			v_parametros.fecha_adju,
			v_parametros.nro_contrato,
			--v_parametros.porc_retgar,
			now(),
			p_id_usuario,
			null,
			null,
            v_id_estado_wf,
            v_id_proceso_wf,
            v_parametros.tipo_cambio_conv
							
			)RETURNING id_cotizacion into v_id_cotizacion;
            
            
            --registrar el detalle de la cotizacion con precio 0 y cantidad 0
            
            
            
           FOR v_registros in  SELECT
               sd.id_solicitud_det
            from adq.tsolicitud_det sd
            where sd.id_solicitud =v_id_solicitud and sd.estado_reg = 'activo' LOOP
                  
                  INSERT INTO 
                    adq.tcotizacion_det
                  (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_cotizacion,
                    id_solicitud_det,
                    precio_unitario,
                    cantidad_coti,
                    cantidad_aduj
                   ) 
                  VALUES (
                    p_id_usuario,
                    now(),
                   'activo',
                    v_id_cotizacion,
                    v_registros.id_solicitud_det,-- :id_solicitud_det,
                    0,--:precio_unitario,
                    0,--:cantidad_coti,
                    0   --cantidad_aduj
                    );
            
            END LOOP;
            
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cotizaciones almacenado(a) con exito (id_cotizacion'||v_id_cotizacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion',v_id_cotizacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_COT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 14:48:35
	***********************************/

	elsif(p_transaccion='ADQ_COT_MOD')then

		begin
        
          
             select 
              c.id_moneda,
              c.tipo_cambio_conv
             into
              v_id_moneda,
              v_tipo_cambio_conv
             from
             adq.tcotizacion c
             where c.id_cotizacion = v_parametros.id_cotizacion;
           
           
           IF  v_id_moneda != v_parametros.id_moneda or v_tipo_cambio_conv !=v_parametros.tipo_cambio_conv THEN
           
                --la moneda y el tipo de cambio no pueden cambiar cambiar si tiene detalles registrados
            
                select 
                  sum(COALESCE(cd.precio_unitario,0))
                INTO
                 v_total_detalle  
                 from adq.tcotizacion_det cd 
                where cd.id_cotizacion = v_parametros.id_cotizacion;
            
                IF (v_total_detalle >0  )THEN
                
                	raise exception 'No puede cambiar ni la moneda,  ni el tipo de cambio si existen items cotizados';
                
                END IF;
             
           
           END IF;             
           
        
			--Sentencia de la modificacion
			update adq.tcotizacion set
		
			lugar_entrega = v_parametros.lugar_entrega,
			tipo_entrega = v_parametros.tipo_entrega,
			fecha_coti = v_parametros.fecha_coti,
			id_proveedor = v_parametros.id_proveedor,
			fecha_entrega = v_parametros.fecha_entrega,
			id_moneda = v_parametros.id_moneda,
			id_proceso_compra = v_parametros.id_proceso_compra,
			fecha_venc = v_parametros.fecha_venc,
			obs = v_parametros.obs,
			fecha_adju = v_parametros.fecha_adju,
			nro_contrato = v_parametros.nro_contrato,
			fecha_mod = now(),
            tipo_cambio_conv = v_parametros.tipo_cambio_conv,
			id_usuario_mod = p_id_usuario
			where id_cotizacion=v_parametros.id_cotizacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cotizaciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion',v_parametros.id_cotizacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_COT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 14:48:35
	***********************************/

	elsif(p_transaccion='ADQ_COT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from adq.tcotizacion
            where id_cotizacion=v_parametros.id_cotizacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cotizaciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion',v_parametros.id_cotizacion::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
        
        
	/*********************************    
 	#TRANSACCION:  'ADQ_FINREGC_IME'
 	#DESCRIPCION:	Finaliza el registro de la cotizacion y pasa al siguiente este que es totizado
                    donde estara listo para adjudicar
 	#AUTOR:	Rensi Arteaga Copari	
 	#FECHA:		21-03-2013 14:48:35
	***********************************/

	elsif(p_transaccion = 'ADQ_FINREGC_IME')then

		begin
			--recupera parametros
			
             select 
              c.id_proceso_wf,
              c.id_estado_wf,
              c.id_proceso_compra,
              c.estado
              
             into
              v_id_proceso_wf,
              v_id_estado_wf,
              v_id_proceso_compra,
              v_estado_cot
             from adq.tcotizacion c
             where c.id_cotizacion = v_parametros.id_cotizacion; 
             
             --VALIDACIONES
             
             IF  v_estado_cot != 'borrador' THEN
             
              raise exception 'Solo se admiten cotizaciones en borrador';
             END IF;
             
             
             --validamos que el detalle tenga por lo menos un item con valor
             
             select 
              sum(cd.precio_unitario)
             into
              v_total_detalle
             from adq.tcotizacion_det cd
             where cd.id_cotizacion = v_parametros.id_cotizacion; 
             
             IF v_total_detalle = 0 or v_total_detalle is null THEN
             
                 raise exception 'No hay nada cotizado...';
             
             END IF; 
             
             
             select 
             	pc.id_depto
             into 
             	v_id_depto
             from adq.tproceso_compra pc where pc.id_proceso_compra = v_id_proceso_compra;
             
             
             SELECT 
                 *
              into
                va_id_tipo_estado,
                va_codigo_estado,
                va_disparador,
                va_regla,
                va_prioridad
            
            FROM wf.f_obtener_estado_wf(v_id_proceso_wf, v_id_estado_wf,NULL,'siguiente');
            
            
            
            IF va_codigo_estado[2] is not null THEN
            
             raise exception 'El proceso de WF esta mal parametrizado, el estado borrador de cotizacion solo admite un estado ';
            
            END IF;
            
             IF va_codigo_estado[1] is  null THEN
            
             raise exception 'El proceso de WF esta mal parametrizado, no se encuentra el estado siguiente ';
            
            END IF;
            
            
          
            
            -- hay que recuperar el supervidor que seria el estado inmediato,...
             v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado[1], 
                                                           NULL, 
                                                           v_id_estado_wf, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           v_id_depto);
            
            
             -- actualiza estado en la solicitud
            
             update adq.tcotizacion  c set 
               id_estado_wf =  v_id_estado_actual,
               estado = va_codigo_estado[1],
               id_usuario_mod=p_id_usuario,
               fecha_mod=now()
             where c.id_cotizacion  = v_parametros.id_cotizacion;
            
           
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Finalizacion del registro de la cotizacion'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion',v_parametros.id_cotizacion::varchar);
              
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