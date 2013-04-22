CREATE OR REPLACE FUNCTION dir.f_empresa_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Directorio
 FUNCION: 		dir.f_empresa_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dir.tempresa'
 AUTOR: 		 (admin)
 FECHA:	        15-03-2013 21:40:25
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

	v_nombre_funcion = 'dir.f_empresa_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIR_EMP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:40:25
	***********************************/

	if(p_transaccion='DIR_EMP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						emp.id_empresa,
						emp.estado_reg,
						emp.tipo_sociedad,
						emp.actividad,
						emp.actividad_esp,
						emp.nit,
						emp.actividad_gral,
						emp.domicilio,
						emp.matricula,
						emp.renovado,
						emp.actividad_prim,
						emp.nombre,
						emp.departamento,
						emp.telefono,
						emp.municipio,
						emp.estado_matricula,
						emp.mail,
						emp.fecha_reg,
						emp.id_usuario_reg,
						emp.fecha_mod,
						emp.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dir.tempresa emp
						inner join segu.tusuario usu1 on usu1.id_usuario = emp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = emp.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DIR_EMP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:40:25
	***********************************/

	elsif(p_transaccion='DIR_EMP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_empresa)
					    from dir.tempresa emp
					    inner join segu.tusuario usu1 on usu1.id_usuario = emp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = emp.id_usuario_mod
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