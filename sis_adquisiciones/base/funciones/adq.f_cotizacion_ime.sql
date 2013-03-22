CREATE OR REPLACE FUNCTION "adq"."f_cotizacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

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
        	--Sentencia de la insercion
        	insert into adq.tcotizacion(
			estado_reg,
			estado,
			lugar_entrega,
			tipo_entrega,
			fecha_coti,
			numero_oc,
			id_proveedor,
			porc_anticipo,
			precio_total,
			fecha_entrega,
			id_moneda,
			id_proceso_compra,
			fecha_venc,
			obs,
			fecha_adju,
			nro_contrato,
			porc_retgar,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.estado,
			v_parametros.lugar_entrega,
			v_parametros.tipo_entrega,
			v_parametros.fecha_coti,
			v_parametros.numero_oc,
			v_parametros.id_proveedor,
			v_parametros.porc_anticipo,
			v_parametros.precio_total,
			v_parametros.fecha_entrega,
			v_parametros.id_moneda,
			v_parametros.id_proceso_compra,
			v_parametros.fecha_venc,
			v_parametros.obs,
			v_parametros.fecha_adju,
			v_parametros.nro_contrato,
			v_parametros.porc_retgar,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_cotizacion into v_id_cotizacion;
			
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
			--Sentencia de la modificacion
			update adq.tcotizacion set
			estado = v_parametros.estado,
			lugar_entrega = v_parametros.lugar_entrega,
			tipo_entrega = v_parametros.tipo_entrega,
			fecha_coti = v_parametros.fecha_coti,
			numero_oc = v_parametros.numero_oc,
			id_proveedor = v_parametros.id_proveedor,
			porc_anticipo = v_parametros.porc_anticipo,
			precio_total = v_parametros.precio_total,
			fecha_entrega = v_parametros.fecha_entrega,
			id_moneda = v_parametros.id_moneda,
			id_proceso_compra = v_parametros.id_proceso_compra,
			fecha_venc = v_parametros.fecha_venc,
			obs = v_parametros.obs,
			fecha_adju = v_parametros.fecha_adju,
			nro_contrato = v_parametros.nro_contrato,
			porc_retgar = v_parametros.porc_retgar,
			fecha_mod = now(),
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
ALTER FUNCTION "adq"."f_cotizacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
