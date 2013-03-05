--------------- SQL ---------------

CREATE OR REPLACE FUNCTION adq.f_solicitud_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_solicitud_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'adq.tsolicitud_det'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'adq.f_solicitud_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_SOLD_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		05-03-2013 01:28:10
	***********************************/

	if(p_transaccion='ADQ_SOLD_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						sold.id_solicitud_det,
						sold.id_centro_costo,
						sold.descripcion,
						sold.precio_unitario,
						sold.id_solicitud,
						sold.id_partida,
						sold.id_orden_trabajo,
						sold.precio_sg,
						sold.id_concepto_gasto,
						sold.id_cuenta,
						sold.precio_total,
						sold.cantidad,
						sold.id_auxiliar,
						sold.precio_presupuestado_mb,
						sold.estado_reg,
						sold.id_partida_ejecucion,
						
						sold.precio_ga,
						sold.id_usuario_reg,
						sold.fecha_reg,
						sold.fecha_mod,
						sold.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from adq.tsolicitud_det sold
						inner join segu.tusuario usu1 on usu1.id_usuario = sold.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sold.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_SOLD_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		05-03-2013 01:28:10
	***********************************/

	elsif(p_transaccion='ADQ_SOLD_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_solicitud_det)
					    from adq.tsolicitud_det sold
					    inner join segu.tusuario usu1 on usu1.id_usuario = sold.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sold.id_usuario_mod
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