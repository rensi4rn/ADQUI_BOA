--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_solicitud_det_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_solicitud_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'adq.tsolicitud_det'
 AUTOR: 		 (admin)
 FECHA:	        05-03-2013 01:28:10
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
	v_id_solicitud_det	integer;
    
    v_id_partida integer;
    v_id_cuenta integer;
    v_id_auxiliar integer;
    
    
			    
BEGIN

    v_nombre_funcion = 'adq.f_solicitud_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_SOLD_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-03-2013 01:28:10
	***********************************/

	if(p_transaccion='ADQ_SOLD_INS')then
					
        begin
            --obtener partida, cuenta auxiliar del concepto de gasto
            
          
            
            SELECT ps_id_partida, 
                   ps_id_cuenta, 
                   ps_id_auxiliar 
             into
                   v_id_partida, 
                   v_id_cuenta, 
                   v_id_auxiliar       
            FROM pre.f_obtener_partida_cuenta_cig(v_parametros.id_concepto_ingas, v_parametros.id_centro_costo);
            
            
            --obetener el precio en la moenda base del sistema
            
            
            
            
        
        
        
        	--Sentencia de la insercion
        	insert into adq.tsolicitud_det(
			id_centro_costo,
			descripcion,
			precio_unitario,
			id_solicitud,
			id_partida,
			id_orden_trabajo,
			precio_sg,
			id_concepto_gasto,
			id_cuenta,
			precio_total,
			cantidad,
			id_auxiliar,
			precio_presupuestado_mb,
			estado_reg,
		
		
			precio_ga,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_centro_costo,
			v_parametros.descripcion,
			v_parametros.precio_unitario,
			v_parametros.id_solicitud,
			v_id_partida,
			v_parametros.id_orden_trabajo,
			v_parametros.precio_sg,
			v_parametros.id_concepto_ingas,
			v_id_cuenta,
			v_parametros.precio_total,
			v_parametros.cantidad,
			v_id_auxiliar,
			0,--v_parametros.precio_presupuestado_mb,
			'activo',
		
		
			0,--v_parametros.precio_ga,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_solicitud_det into v_id_solicitud_det;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle almacenado(a) con exito (id_solicitud_det'||v_id_solicitud_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud_det',v_id_solicitud_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_SOLD_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-03-2013 01:28:10
	***********************************/

	elsif(p_transaccion='ADQ_SOLD_MOD')then

		begin
			--Sentencia de la modificacion
			update adq.tsolicitud_det set
			id_centro_costo = v_parametros.id_centro_costo,
			descripcion = v_parametros.descripcion,
			precio_unitario = v_parametros.precio_unitario,
			id_solicitud = v_parametros.id_solicitud,
			id_partida = v_parametros.id_partida,
			id_orden_trabajo = v_parametros.id_orden_trabajo,
			precio_sg = v_parametros.precio_sg,
			id_concepto_gasto = v_parametros.id_concepto_gasto,
			id_cuenta = v_parametros.id_cuenta,
			precio_total = v_parametros.precio_total,
			cantidad = v_parametros.cantidad,
			id_auxiliar = v_parametros.id_auxiliar,
			precio_presupuestado_mb = v_parametros.precio_presupuestado_mb,
			id_partida_ejecucion = v_parametros.id_partida_ejecucion,
			numero = v_parametros.numero,
			precio_ga = v_parametros.precio_ga,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_solicitud_det=v_parametros.id_solicitud_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud_det',v_parametros.id_solicitud_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_SOLD_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-03-2013 01:28:10
	***********************************/

	elsif(p_transaccion='ADQ_SOLD_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from adq.tsolicitud_det
            where id_solicitud_det=v_parametros.id_solicitud_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_solicitud_det',v_parametros.id_solicitud_det::varchar);
              
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