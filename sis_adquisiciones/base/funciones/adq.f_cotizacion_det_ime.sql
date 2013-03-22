CREATE OR REPLACE FUNCTION "adq"."f_cotizacion_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_cotizacion_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'adq.tcotizacion_det'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        21-03-2013 21:44:43
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
	v_id_cotizacion_det	integer;
			    
BEGIN

    v_nombre_funcion = 'adq.f_cotizacion_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_CTD_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 21:44:43
	***********************************/

	if(p_transaccion='ADQ_CTD_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into adq.tcotizacion_det(
			estado_reg,
			id_cotizacion,
			precio_unitario,
			cantidad_aduj,
			cantidad_coti,
			obs,
			id_solicitud_det,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_cotizacion,
			v_parametros.precio_unitario,
			v_parametros.cantidad_aduj,
			v_parametros.cantidad_coti,
			v_parametros.obs,
			v_parametros.id_solicitud_det,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_cotizacion_det into v_id_cotizacion_det;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle cotizacion almacenado(a) con exito (id_cotizacion_det'||v_id_cotizacion_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion_det',v_id_cotizacion_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_CTD_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 21:44:43
	***********************************/

	elsif(p_transaccion='ADQ_CTD_MOD')then

		begin
			--Sentencia de la modificacion
			update adq.tcotizacion_det set
			id_cotizacion = v_parametros.id_cotizacion,
			precio_unitario = v_parametros.precio_unitario,
			cantidad_aduj = v_parametros.cantidad_aduj,
			cantidad_coti = v_parametros.cantidad_coti,
			obs = v_parametros.obs,
			id_solicitud_det = v_parametros.id_solicitud_det,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_cotizacion_det=v_parametros.id_cotizacion_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle cotizacion modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion_det',v_parametros.id_cotizacion_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_CTD_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 21:44:43
	***********************************/

	elsif(p_transaccion='ADQ_CTD_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from adq.tcotizacion_det
            where id_cotizacion_det=v_parametros.id_cotizacion_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle cotizacion eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cotizacion_det',v_parametros.id_cotizacion_det::varchar);
              
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
ALTER FUNCTION "adq"."f_cotizacion_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
