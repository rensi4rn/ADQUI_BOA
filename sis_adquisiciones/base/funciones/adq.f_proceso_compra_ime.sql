--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_proceso_compra_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_proceso_compra_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'adq.tproceso_compra'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2013 12:55:29
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
	v_id_proceso_compra	integer;
    
    
    v_num_cot varchar;
    v_id_periodo integer;
    v_estado_sol varchar;
    v_id_estado_wf_sol integer;
    v_id_proceso_wf_sol integer;

    
    va_id_tipo_estado_sol integer[];
    va_codigo_estado_sol varchar[];
    va_disparador_sol varchar[];
    va_regla_sol varchar[];
    va_prioridad_sol integer[];
    
    v_id_funcionario integer;
    v_id_estado_actual integer;
    
    v_id_proceso_wf integer;
    v_id_estado_wf integer;
    v_codigo_estado varchar;
    v_id_depto integer;
    v_coun_num_cot integer;
    v_estado  varchar;
    v_id_tipo_estado integer;
    v_id_solicitud integer;
    v_id_usuario_reg integer;
    v_id_estado_wf_ant  integer;
			    
BEGIN

    v_nombre_funcion = 'adq.f_proceso_compra_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_PROC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 12:55:29
	***********************************/

	if(p_transaccion='ADQ_PROC_INS')then
					
        begin
        
          --recupera datos de la solictud
          
          
          select
            s.id_estado_wf,
            s.id_proceso_wf,
            s.estado,
            s.id_funcionario
          into
           v_id_estado_wf_sol,
           v_id_proceso_wf_sol,
           v_estado_sol,
           v_id_funcionario
          from adq.tsolicitud s
          where s.id_solicitud = v_parametros.id_solicitud;
        
           --recupera el periodo
           
           select 
             id_periodo 
           into 
             v_id_periodo 
           from
            param.tperiodo per 
           where per.fecha_ini <= v_parametros.fecha_ini_proc 
             and per.fecha_fin >=  v_parametros.fecha_ini_proc
             limit 1 offset 0;
        
        
        
           --obtener el numero de cotizacion
           
            v_num_cot =   param.f_obtener_correlativo(
                  'COT', 
             v_id_periodo,-- par_id, 
             NULL, --id_uo 
             v_parametros.id_depto,    -- id_depto
             p_id_usuario, 
             'ADQ', 
             NULL);
           
           --pasa al siguiente estado la solcitud
           
           
             SELECT 
               ps_id_tipo_estado,
               ps_codigo_estado,
               ps_disparador,
               ps_regla,
               ps_prioridad
            into
              va_id_tipo_estado_sol,
              va_codigo_estado_sol,
              va_disparador_sol,
              va_regla_sol,
              va_prioridad_sol
          
          FROM wf.f_obtener_estado_wf(v_id_proceso_wf_sol, v_id_estado_wf_sol,NULL,'siguiente');
          
         
          
       
          
           
           IF  va_id_tipo_estado_sol[2] is not null  THEN
           
            raise exception 'El proceso se encuentra mal parametrizado dentro de Work Flow,  la finalizacion de solicitud solo admite un estado siguiente';
          
          END IF;
          
          
          
          IF  va_codigo_estado_sol[1] != 'proceso'  THEN
            raise exception 'El proceso se encuentra mal parametrizado dentro de Work Flow, elsiguiente estado para la solicitud deberia ser "proceso" y no % ',va_codigo_estado_sol[1];
          END IF;
          
          
          -- registra estado eactual en el WF para la solicitud
          
          
           v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado_sol[1], 
                                                         v_id_funcionario, 
                                                         v_id_estado_wf_sol, 
                                                         v_id_proceso_wf_sol,
                                                         p_id_usuario,
                                                         v_parametros.id_depto);
           
           
           -- actuliaza el stado en la solictud
           update adq.tsolicitud  s set 
             id_estado_wf =  v_id_estado_actual,
             estado = va_codigo_estado_sol[1],
             id_usuario_mod=p_id_usuario,
             fecha_mod=now()
           where id_solicitud = v_parametros.id_solicitud; 
           
           
           --iniciar el proceso WF
           
             raise notice '>>>>>>              registra proceso disparado % %',v_id_estado_wf_sol,v_parametros.id_depto;
           
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
                     v_parametros.id_depto);
            
            
           --registra el estado del WF para el proceso
           
           
           
           --cambiar de estado a la solicitud y registrar en log del WF
        
        
        	--Sentencia de la insercion
        	insert into adq.tproceso_compra(
			id_depto,
			num_convocatoria,
			id_solicitud,
			id_estado_wf,
			fecha_ini_proc,
			obs_proceso,
			id_proceso_wf,
			num_tramite,
			codigo_proceso,
			estado_reg,
			estado,
			num_cotizacion,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_depto,
			'1',
			v_parametros.id_solicitud,
			v_id_estado_wf,
			v_parametros.fecha_ini_proc,
			v_parametros.obs_proceso,
			v_id_proceso_wf,
			v_parametros.num_tramite,
			v_parametros.codigo_proceso,
			'activo',
			v_codigo_estado,
			v_num_cot,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_proceso_compra into v_id_proceso_compra;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso de Compra almacenado(a) con exito (id_proceso_compra'||v_id_proceso_compra||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_compra',v_id_proceso_compra::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_PROC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 12:55:29
	***********************************/

	elsif(p_transaccion='ADQ_PROC_MOD')then

		begin
			--Sentencia de la modificacion
			update adq.tproceso_compra set
			id_depto = v_parametros.id_depto,
			num_convocatoria = v_parametros.num_convocatoria,
			id_solicitud = v_parametros.id_solicitud,
			id_estado_wf = v_parametros.id_estado_wf,
			fache_ini_proc = v_parametros.fache_ini_proc,
			obs_proceso = v_parametros.obs_proceso,
			id_proceso_wf = v_parametros.id_proceso_wf,
			num_tramite = v_parametros.num_tramite,
			codigo_proceso = v_parametros.codigo_proceso,
			estado = v_parametros.estado,
			num_cotizacion = v_parametros.num_cotizacion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_proceso_compra=v_parametros.id_proceso_compra;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso de Compra modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_compra',v_parametros.id_proceso_compra::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_PROC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 12:55:29
	***********************************/

	elsif(p_transaccion='ADQ_PROC_ELI')then

		begin
			
           
            
            --obtenemos datos bascios
            select 
            	p.id_estado_wf,
            	p.id_proceso_wf,
            	p.estado,
            	p.id_depto,
                p.id_solicitud
            into
            	v_id_estado_wf,
                v_id_proceso_wf,
                v_codigo_estado,
                v_id_depto,
                v_id_solicitud
            
            from adq.tproceso_compra p 
            where p.id_proceso_compra = v_parametros.id_proceso_compra;
            
             -- verificamos si tiene cotizacion
             
             select 
              count(c.id_cotizacion)
             into
              v_coun_num_cot 
             from adq.tcotizacion c
             where c.id_proceso_compra = v_parametros.id_proceso_compra; 
            
             IF v_coun_num_cot > 0 THEN 
             
             	v_estado = 'anulado';
             
             ELSE
             	 -- sino tiene cotizacion se declara desierto
             	v_estado = 'desierto';
             
             END IF;
            
            
            -- si tiene cotizacion verificamos que todas estan a nuladas
            IF v_estado = 'anulado' THEN
              select 
                count(c.id_cotizacion)
               into
                v_coun_num_cot 
               from adq.tcotizacion c
               where c.id_proceso_compra = v_parametros.id_proceso_compra and c.estado !='anulado'; 
            
            
                 IF v_coun_num_cot >0 THEN
                 
                   raise exception 'Todas las cotizaciones tienen que estar anuladas primero';
                 
                 END IF;
            
            
            END IF;
            
            -- si todas las cotizaciones estan anuladas anulamos el proceso
            
             select 
              te.id_tipo_estado
             into
              v_id_tipo_estado
             from wf.tproceso_wf pw 
             inner join wf.ttipo_proceso tp on pw.id_tipo_proceso = tp.id_tipo_proceso
             inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.codigo = v_estado               
             where pw.id_proceso_wf = v_id_proceso_wf;
               
              
              
               -- pasamos la cotizacion al siguiente estado
           
               v_id_estado_actual =  wf.f_registra_estado_wf(v_id_tipo_estado, 
                                                           NULL, 
                                                           v_id_estado_wf, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           v_id_depto);
            
            
               -- actualiza estado en la cotizacion
              
               update adq.tproceso_compra  set 
                 id_estado_wf =  v_id_estado_actual,
                 estado = v_estado,
                 id_usuario_mod=p_id_usuario,
                 fecha_mod=now()
               where id_proceso_compra  = v_parametros.id_proceso_compra;
           
             -------------------------------------------------
              --liberamos la solicitud de compra
             --------------------------------------------------
             
             --recuperamos datos de la solicitud
             
             select 
             s.id_estado_wf,
             s.id_proceso_wf
             into
             v_id_estado_wf,
             v_id_proceso_wf
             from adq.tsolicitud s
             where s.id_solicitud = v_id_solicitud;
             
             --recuperaq estado anterior segun Log del WF
              SELECT  
                 ps_id_tipo_estado,
                 ps_id_funcionario,
                 ps_id_usuario_reg,
                 ps_id_depto,
                 ps_codigo_estado,
                 ps_id_estado_wf_ant
              into
                 v_id_tipo_estado,
                 v_id_funcionario,
                 v_id_usuario_reg,
                 v_id_depto,
                 v_codigo_estado,
                 v_id_estado_wf_ant 
              FROM wf.f_obtener_estado_ant_log_wf(v_id_estado_wf);
             
             -- registra nuevo estado
             
            
                      
              v_id_estado_actual = wf.f_registra_estado_wf(
                  v_id_tipo_estado, 
                  v_id_funcionario, 
                  v_id_estado_wf, 
                  v_id_proceso_wf, 
                  p_id_usuario,
                  v_id_depto);
                      
                    
                      
              -- actualiza estado en la solicitud
                update adq.tsolicitud  s set 
                   id_estado_wf =  v_id_estado_actual,
                   estado = v_codigo_estado,
                   id_usuario_mod=p_id_usuario,
                   fecha_mod=now()
                 where id_solicitud =v_id_solicitud;
             
             
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso de Compra '||v_estado); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_compra',v_parametros.id_proceso_compra::varchar);
              
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