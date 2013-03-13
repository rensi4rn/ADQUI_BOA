--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_solicitud_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_solicitud_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'adq.tsolicitud'
 AUTOR: 		 (RAC)
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
    
    v_num_sol   varchar;
    v_id_periodo integer;
    v_num_tramite varchar;
    v_id_proceso_wf integer;
    v_id_estado_wf integer;
    v_codigo_estado varchar;
     v_codigo_estado_siguiente varchar;
    v_codigo_tipo_proceso varchar;
    v_total_soli numeric;
    
    va_id_tipo_estado integer [];
    va_codigo_estado varchar [];
    va_disparador varchar [];
    va_regla varchar [];
    va_prioridad integer [];
    
    
    v_id_estado_actual  integer;
    
    v_id_funcionario_aprobador integer;
			    
BEGIN

    v_nombre_funcion = 'adq.f_solicitud_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_SOL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	if(p_transaccion='ADQ_SOL_INS')then
					
        begin
        
        --determina la fecha del periodo
        
         select id_periodo into v_id_periodo from
                        param.tperiodo per 
                       where per.fecha_ini <= v_parametros.fecha_soli 
                         and per.fecha_fin >=  v_parametros.fecha_soli
                         limit 1 offset 0;
        
        
        --obtener correlativo
         v_num_sol =   param.f_obtener_correlativo(
                  'SOLC', 
                   v_id_periodo,-- par_id, 
                   NULL, --id_uo 
                   1,    -- id_depto
                   1, 
                   'ADQ', 
                   NULL);
      
        
        IF (v_num_sol is NULL or v_num_sol ='') THEN
        
          raise exception 'No se pudo obtener un numero correlativo para la solicitud consulte con el administrador';
        
        END IF;
        
        -- obtener el codigo del tipo_proceso
       
        select   tp.codigo 
            into v_codigo_tipo_proceso
        from  wf.ttipo_proceso tp 
        where   tp.id_proceso_macro = v_parametros.id_proceso_macro
                and tp.estado_reg = 'activo' and tp.inicio = 'si';
            
         
        IF v_codigo_tipo_proceso is NULL THEN
        
           raise exception 'No existe un proceso inicial para el proceso macro indicado (Revise la configuración)';
        
        END IF;
        
        -- inciiar el tramite en el sistema de WF
       SELECT 
             ps_num_tramite ,
             ps_id_proceso_wf ,
             ps_id_estado_wf ,
             ps_codigo_estado 
          into
             v_num_tramite,
             v_id_proceso_wf,
             v_id_estado_wf,
             v_codigo_estado   
              
        FROM wf.f_inicia_tramite(
             p_id_usuario, 
             v_parametros.id_gestion, 
             v_codigo_tipo_proceso, 
             v_parametros.id_funcionario, 
             v_parametros.fecha_soli);
        
        -- obtiene el funcionario aprobador
        
        
        	insert into adq.tsolicitud(
			estado_reg,
			--id_solicitud_ext,
			--presu_revertido,
			--fecha_apro,
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
			id_usuario_mod,
            id_uo,
            id_proceso_macro
          	) values(
			'activo',
			--v_parametros.id_solicitud_ext,
			--v_parametros.presu_revertido,
			--v_parametros.fecha_apro,
			v_codigo_estado,
			v_parametros.id_funcionario_aprobador,
			v_parametros.id_moneda,
			v_parametros.id_gestion,
			v_parametros.tipo,
			v_num_tramite,
			v_parametros.justificacion,
			v_parametros.id_depto,
			v_parametros.lugar_entrega,
			'no',
			v_num_sol,--v_parametros.numero,
			v_parametros.posibles_proveedores,
			v_id_proceso_wf,
			v_parametros.comite_calificacion,
			v_parametros.id_categoria_compra,
			v_parametros.id_funcionario,
			v_id_estado_wf,
			v_parametros.fecha_soli,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.id_uo,
            v_parametros.id_proceso_macro
							
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
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elsif(p_transaccion='ADQ_SOL_MOD')then

		begin
			--Sentencia de la modificacion
			update adq.tsolicitud set
			--id_solicitud_ext = v_parametros.id_solicitud_ext,
			--presu_revertido = v_parametros.presu_revertido,
			--fecha_apro = v_parametros.fecha_apro,
			--estado = v_parametros.estado,
			id_funcionario_aprobador = v_parametros.id_funcionario_aprobador,
			id_moneda = v_parametros.id_moneda,
			id_gestion = v_parametros.id_gestion,
			tipo = v_parametros.tipo,
			--num_tramite = v_parametros.num_tramite,
			justificacion = v_parametros.justificacion,
			id_depto = v_parametros.id_depto,
			lugar_entrega = v_parametros.lugar_entrega,
			--extendida = v_parametros.extendida,
			--numero = v_parametros.numero,
			posibles_proveedores = v_parametros.posibles_proveedores,
			--id_proceso_wf = v_parametros.id_proceso_wf,
			comite_calificacion = v_parametros.comite_calificacion,
			id_categoria_compra = v_parametros.id_categoria_compra,
			id_funcionario = v_parametros.id_funcionario,
			--id_estado_wf = v_parametros.id_estado_wf,
			fecha_soli = v_parametros.fecha_soli,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            id_uo = v_parametros.id_uo,
            id_proceso_macro=id_proceso_macro
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
 	#AUTOR:		RAC	
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
        
     /*********************************    
 	#TRANSACCION:  'ADQ_FINSOL_IME'
 	#DESCRIPCION:	Finalizar solicitud de Compras
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elseif(p_transaccion='ADQ_FINSOL_IME')then   
        begin
        
          IF  v_parametros.operacion = 'verificar' THEN
          
              select sum( COALESCE( sd.precio_ga_mb,0)  + COALESCE(sd.precio_sg_mb,0)) into  v_total_soli
              from adq.tsolicitud_det sd
              where sd.id_solicitud = v_parametros.id_solicitud
              and sd.estado_reg = 'activo';
              
              IF  v_total_soli=0  THEN
              	raise exception ' La Solicitud  tiene que ser por un valor mayor a 0';
              END IF;
              
               --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Verificacionde finalizacion)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'total',v_total_soli::varchar);
              
          
          ELSEIF  v_parametros.operacion = 'finalizar' THEN
          
          --obtenermos datos basicos
          
          select
            s.id_proceso_wf,
            s.id_estado_wf,
            s.estado,
            s.id_funcionario_aprobador
          into 
          
            v_id_proceso_wf,
            v_id_estado_wf,
            v_codigo_estado,
            v_id_funcionario_aprobador
            
          from adq.tsolicitud s
          where s.id_solicitud=v_parametros.id_solicitud;
          
                 
          
          
          --buscamos siguiente estado correpondiente al proceso del WF
          
        SELECT 
             ps_id_tipo_estado,
             ps_codigo_estado,
             ps_disparador,
             ps_regla,
             ps_prioridad
          into
            va_id_tipo_estado,
            va_codigo_estado,
            va_disparador,
            va_regla,
            va_prioridad
        
        FROM wf.f_obtener_estado_wf(v_id_proceso_wf, v_id_estado_wf,'siguiente');
          
          --cambiamos estado de la solicitud
          
          
        --     raise exception '% /% /%  /% /%',va_id_tipo_estado[1],va_codigo_estado[1], va_disparador[1], va_regla[1],va_prioridad[1];
          
          
          IF  va_id_tipo_estado[2] is not null  THEN
           
            raise exception 'El proceso se encuentra mal parametrizado dentro de Work Flow,  la finalizacion de solicitud solo admite un estado siguiente';
          
          END IF;
          
          IF  va_id_tipo_estado[1] is  null  THEN
           
            raise exception ' El proceso de Work Flow esta mal parametrizado, no tiene un estado siguiente para la finalizacion';
          
          END IF;
          
            
          IF  va_disparador[1]='si'  THEN
           
            raise exception ' El proceso de Work Flow esta mal parametrizado, antes de iniciar el proceso de compra necesita comprometer el presupuesto';
          
          END IF;
          
          
          --registra estado eactual en el WF
          
          -- hay que recuperar el supervidor que seria el estado inmediato,...
           v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado[1], 
                                                         v_id_funcionario_aprobador, 
                                                         v_id_estado_wf, 
                                                         v_id_proceso_wf);
                                                         
         
        
           -- actualiza estado en la solicitud
          
           update adq.tsolicitud  s set 
             id_estado_wf =  v_id_estado_actual,
             estado = va_codigo_estado[1]
           where id_solicitud = v_parametros.id_solicitud;
        
        
        
        
         ELSE
          
            raise exception 'operacion no identificada %',COALESCE( v_parametros.operacion,'--');
          
          END IF;
        
        
        --Devuelve la respuesta
            return v_resp;
        
        end;   
    
      /*********************************    
 	#TRANSACCION:  'ADQ_SIGESOL_IME'
 	#DESCRIPCION:	funcion que controla el cambio al Siguiente esado de la solicitud, integrado con el WF
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elseif(p_transaccion='ADQ_SIGESOL_IME')then   
        begin
        
        --obtenermos datos basicos
          
          select
            s.id_proceso_wf,
            s.id_estado_wf,
            s.estado
          into 
          
            v_id_proceso_wf,
            v_id_estado_wf,
            v_codigo_estado
            
          from adq.tsolicitud s
          where s.id_solicitud=v_parametros.id_solicitud;
          
         
         
          IF  v_parametros.operacion = 'verificar' THEN
          
              --buscamos siguiente estado correpondiente al proceso del WF
               SELECT 
                 ps_id_tipo_estado,
                 ps_codigo_estado,
                 ps_disparador,
                 ps_regla,
                 ps_prioridad
              into
                va_id_tipo_estado,
                va_codigo_estado,
                va_disparador,
                va_regla,
                va_prioridad
            
            FROM wf.f_obtener_estado_wf(v_id_proceso_wf, v_id_estado_wf,'siguiente');
          
          
            --raise exception '% /% /%  /% /%',va_id_tipo_estado[1],va_codigo_estado[1], va_disparador[1], va_regla[1],va_prioridad[1];
          
            
            -- si hay mas de un estado disponible  preguntamos al usuario
            
            
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Verificacion para el siguiente estado)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'estados', array_to_string(va_id_tipo_estado, ','));
            v_resp = pxp.f_agrega_clave(v_resp,'operacion','preguntar_todo');
            
            
            
            
            --TO DO  si hay un solo estado disponible pero mas de un usario  preguntamos al usuario
            
            
            -- TO DO si hay solo un estado disponible y solo un funcionario para ese estado podemos saltar directamente al  estado
          
             
            
          
          
          END IF;
         
         
         
          
       
        
        
        
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