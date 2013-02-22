CREATE OR REPLACE FUNCTION "adq"."f_solicitud_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_solicitud_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'adq.tsolicitud'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 12:12:51
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

	v_nombre_funcion = 'adq.f_solicitud_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_SOL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	if(p_transaccion='ADQ_SOL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						sol.id_solicitud,
						sol.estado_reg,
						sol.id_solicitud_ext,
						sol.presu_revertido,
						sol.fecha_apro,
						sol.estado,
						sol.id_funcionario_aprobador,
						sol.id_moneda,
						sol.id_gestion,
						sol.tipo,
						sol.num_tramite,
						sol.justificacion,
						sol.id_depto,
						sol.lugar_entrega,
						sol.extendida,
						sol.numero,
						sol.posibles_proveedores,
						sol.id_proceso_wf,
						sol.comite_calificacion,
						sol.id_categoria_compra,
						sol.id_funcionario,
						sol.id_estado_wf,
						sol.fecha_soli,
						sol.fecha_reg,
						sol.id_usuario_reg,
						sol.fecha_mod,
						sol.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from adq.tsolicitud sol
						inner join segu.tusuario usu1 on usu1.id_usuario = sol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sol.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_SOL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elsif(p_transaccion='ADQ_SOL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_solicitud)
					    from adq.tsolicitud sol
					    inner join segu.tusuario usu1 on usu1.id_usuario = sol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sol.id_usuario_mod
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
ALTER FUNCTION "adq"."f_solicitud_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
