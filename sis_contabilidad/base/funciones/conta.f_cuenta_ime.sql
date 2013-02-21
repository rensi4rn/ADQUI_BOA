CREATE OR REPLACE FUNCTION "conta"."f_cuenta_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Contabilidad
 FUNCION: 		conta.f_cuenta_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'conta.tcuenta'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        21-02-2013 15:04:03
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
	v_id_cuenta	integer;
			    
BEGIN

    v_nombre_funcion = 'conta.f_cuenta_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'CONTA_CTA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-02-2013 15:04:03
	***********************************/

	if(p_transaccion='CONTA_CTA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into conta.tcuenta(
			estado_reg,
			vigente,
			nombre_cuenta,
			sw_oec,
			sw_auxiliar,
			nivel_cuenta,
			tipo_cuenta,
			id_empresa,
			id_cuenta_padre,
			descripcion,
			id_auxiliar_dif,
			tipo_plantilla,
			desc_cuenta,
			sw_sigma,
			cuenta_sigma,
			tipo_cuenta_pat,
			obs,
			sw_sistema_actualizacion,
			id_cuenta_actualizacion,
			id_parametro,
			id_auxliar_actualizacion,
			plantilla,
			nro_cuenta,
			id_moneda,
			cuenta_flujo_sigma,
			id_cuenta_dif,
			id_cuenta_sigma,
			sw_transaccional,
			id_gestion,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.vigente,
			v_parametros.nombre_cuenta,
			v_parametros.sw_oec,
			v_parametros.sw_auxiliar,
			v_parametros.nivel_cuenta,
			v_parametros.tipo_cuenta,
			v_parametros.id_empresa,
			v_parametros.id_cuenta_padre,
			v_parametros.descripcion,
			v_parametros.id_auxiliar_dif,
			v_parametros.tipo_plantilla,
			v_parametros.desc_cuenta,
			v_parametros.sw_sigma,
			v_parametros.cuenta_sigma,
			v_parametros.tipo_cuenta_pat,
			v_parametros.obs,
			v_parametros.sw_sistema_actualizacion,
			v_parametros.id_cuenta_actualizacion,
			v_parametros.id_parametro,
			v_parametros.id_auxliar_actualizacion,
			v_parametros.plantilla,
			v_parametros.nro_cuenta,
			v_parametros.id_moneda,
			v_parametros.cuenta_flujo_sigma,
			v_parametros.id_cuenta_dif,
			v_parametros.id_cuenta_sigma,
			v_parametros.sw_transaccional,
			v_parametros.id_gestion,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_cuenta into v_id_cuenta;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta almacenado(a) con exito (id_cuenta'||v_id_cuenta||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cuenta',v_id_cuenta::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'CONTA_CTA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-02-2013 15:04:03
	***********************************/

	elsif(p_transaccion='CONTA_CTA_MOD')then

		begin
			--Sentencia de la modificacion
			update conta.tcuenta set
			vigente = v_parametros.vigente,
			nombre_cuenta = v_parametros.nombre_cuenta,
			sw_oec = v_parametros.sw_oec,
			sw_auxiliar = v_parametros.sw_auxiliar,
			nivel_cuenta = v_parametros.nivel_cuenta,
			tipo_cuenta = v_parametros.tipo_cuenta,
			id_empresa = v_parametros.id_empresa,
			id_cuenta_padre = v_parametros.id_cuenta_padre,
			descripcion = v_parametros.descripcion,
			id_auxiliar_dif = v_parametros.id_auxiliar_dif,
			tipo_plantilla = v_parametros.tipo_plantilla,
			desc_cuenta = v_parametros.desc_cuenta,
			sw_sigma = v_parametros.sw_sigma,
			cuenta_sigma = v_parametros.cuenta_sigma,
			tipo_cuenta_pat = v_parametros.tipo_cuenta_pat,
			obs = v_parametros.obs,
			sw_sistema_actualizacion = v_parametros.sw_sistema_actualizacion,
			id_cuenta_actualizacion = v_parametros.id_cuenta_actualizacion,
			id_parametro = v_parametros.id_parametro,
			id_auxliar_actualizacion = v_parametros.id_auxliar_actualizacion,
			plantilla = v_parametros.plantilla,
			nro_cuenta = v_parametros.nro_cuenta,
			id_moneda = v_parametros.id_moneda,
			cuenta_flujo_sigma = v_parametros.cuenta_flujo_sigma,
			id_cuenta_dif = v_parametros.id_cuenta_dif,
			id_cuenta_sigma = v_parametros.id_cuenta_sigma,
			sw_transaccional = v_parametros.sw_transaccional,
			id_gestion = v_parametros.id_gestion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_cuenta=v_parametros.id_cuenta;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cuenta',v_parametros.id_cuenta::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'CONTA_CTA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-02-2013 15:04:03
	***********************************/

	elsif(p_transaccion='CONTA_CTA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from conta.tcuenta
            where id_cuenta=v_parametros.id_cuenta;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cuenta',v_parametros.id_cuenta::varchar);
              
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
ALTER FUNCTION "conta"."f_cuenta_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
