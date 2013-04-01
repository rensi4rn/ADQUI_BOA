CREATE OR REPLACE FUNCTION "conta"."f_plantilla_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Contabilidad
 FUNCION: 		conta.f_plantilla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'conta.tplantilla'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        01-04-2013 21:49:11
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
	v_id_plantilla	integer;
			    
BEGIN

    v_nombre_funcion = 'conta.f_plantilla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'CONTA_PLT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	if(p_transaccion='CONTA_PLT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into conta.tplantilla(
			estado_reg,
			desc_plantilla,
			sw_tesoro,
			sw_compro,
			nro_linea,
			tipo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.desc_plantilla,
			v_parametros.sw_tesoro,
			v_parametros.sw_compro,
			v_parametros.nro_linea,
			v_parametros.tipo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_plantilla into v_id_plantilla;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Documento almacenado(a) con exito (id_plantilla'||v_id_plantilla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla',v_id_plantilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'CONTA_PLT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	elsif(p_transaccion='CONTA_PLT_MOD')then

		begin
			--Sentencia de la modificacion
			update conta.tplantilla set
			desc_plantilla = v_parametros.desc_plantilla,
			sw_tesoro = v_parametros.sw_tesoro,
			sw_compro = v_parametros.sw_compro,
			nro_linea = v_parametros.nro_linea,
			tipo = v_parametros.tipo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_plantilla=v_parametros.id_plantilla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Documento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla',v_parametros.id_plantilla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'CONTA_PLT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	elsif(p_transaccion='CONTA_PLT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from conta.tplantilla
            where id_plantilla=v_parametros.id_plantilla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla Documento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla',v_parametros.id_plantilla::varchar);
              
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
ALTER FUNCTION "conta"."f_plantilla_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
