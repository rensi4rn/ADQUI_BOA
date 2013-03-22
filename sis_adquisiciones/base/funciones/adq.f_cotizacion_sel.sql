CREATE OR REPLACE FUNCTION adq.f_cotizacion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Adquisiciones
 FUNCION: 		adq.f_cotizacion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'adq.tcotizacion'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'adq.f_cotizacion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'ADQ_COT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 14:48:35
	***********************************/

	if(p_transaccion='ADQ_COT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						cot.id_cotizacion,
						cot.estado_reg,
						cot.estado,
						cot.lugar_entrega,
						cot.tipo_entrega,
						cot.fecha_coti,
						cot.numero_oc,
						cot.id_proveedor,
                        pro.desc_proveedor,
						cot.porc_anticipo,
						cot.precio_total,
						cot.fecha_entrega,
						cot.id_moneda,
                        mon.moneda,
						cot.id_proceso_compra,
						cot.fecha_venc,
						cot.obs,
						cot.fecha_adju,
						cot.nro_contrato,
						cot.porc_retgar,
						cot.fecha_reg,
						cot.id_usuario_reg,
						cot.fecha_mod,
						cot.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from adq.tcotizacion cot
						inner join segu.tusuario usu1 on usu1.id_usuario = cot.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cot.id_usuario_mod
				        inner join param.tmoneda mon on mon.id_moneda = cot.id_moneda
                        inner join param.vproveedor pro on pro.id_proveedor = cot.id_proveedor
                        where cot.id_proceso_compra='||v_parametros.id_proceso_compra||' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'ADQ_COT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		21-03-2013 14:48:35
	***********************************/

	elsif(p_transaccion='ADQ_COT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cotizacion)
					    from adq.tcotizacion cot
						inner join segu.tusuario usu1 on usu1.id_usuario = cot.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cot.id_usuario_mod
				        inner join param.tmoneda mon on mon.id_moneda = cot.id_moneda
                        inner join param.vproveedor pro on pro.id_proveedor = cot.id_proveedor
                        where cot.id_proceso_compra='||v_parametros.id_proceso_compra||' and ';
			
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