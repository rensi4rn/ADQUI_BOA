CREATE OR REPLACE FUNCTION conta.f_cuenta_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Contabilidad
 FUNCION: 		conta.f_cuenta_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'conta.tcuenta'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'conta.f_cuenta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'CONTA_CTA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-02-2013 15:04:03
	***********************************/

	if(p_transaccion='CONTA_CTA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						cta.id_cuenta,
						cta.estado_reg,
						cta.vigente,
						cta.nombre_cuenta,
						cta.sw_oec,
						cta.sw_auxiliar,
						cta.nivel_cuenta,
						cta.tipo_cuenta,
						cta.id_empresa,
						cta.id_cuenta_padre,
                        ctap.nombre_cuenta as nombre_cuenta_padre,
						cta.descripcion,
						cta.id_auxiliar_dif,
						cta.tipo_plantilla,
						cta.desc_cuenta,
						cta.sw_sigma,
						cta.cuenta_sigma,
						cta.tipo_cuenta_pat,
						cta.obs,
						cta.sw_sistema_actualizacion,
						cta.id_cuenta_actualizacion,
						cta.id_parametro,
						cta.id_auxliar_actualizacion,
						cta.plantilla,
						cta.nro_cuenta,
						cta.id_moneda,
						cta.cuenta_flujo_sigma,
						cta.id_cuenta_dif,
						cta.id_cuenta_sigma,
						cta.sw_transaccional,
						cta.id_gestion,
						cta.fecha_reg,
						cta.id_usuario_reg,
						cta.fecha_mod,
						cta.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from conta.tcuenta cta
						inner join segu.tusuario usu1 on usu1.id_usuario = cta.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cta.id_usuario_mod
						left join conta.tcuenta ctap on ctap.id_cuenta=cta.id_cuenta_padre
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'CONTA_CTA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-02-2013 15:04:03
	***********************************/

	elsif(p_transaccion='CONTA_CTA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cuenta)
					    from conta.tcuenta cta
					    inner join segu.tusuario usu1 on usu1.id_usuario = cta.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cta.id_usuario_mod
                        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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