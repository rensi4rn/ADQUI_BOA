CREATE OR REPLACE FUNCTION "conta"."f_plantilla_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Contabilidad
 FUNCION: 		conta.f_plantilla_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'conta.tplantilla'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'conta.f_plantilla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'CONTA_PLT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	if(p_transaccion='CONTA_PLT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						plt.id_plantilla,
						plt.estado_reg,
						plt.desc_plantilla,
						plt.sw_tesoro,
						plt.sw_compro,
						plt.nro_linea,
						plt.tipo,
						plt.fecha_reg,
						plt.id_usuario_reg,
						plt.fecha_mod,
						plt.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from conta.tplantilla plt
						inner join segu.tusuario usu1 on usu1.id_usuario = plt.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plt.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'CONTA_PLT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	elsif(p_transaccion='CONTA_PLT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plantilla)
					    from conta.tplantilla plt
					    inner join segu.tusuario usu1 on usu1.id_usuario = plt.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plt.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "conta"."f_plantilla_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
