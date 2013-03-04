--------------- SQL ---------------

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
    v_where 			varchar;
			    
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
			v_consulta:='SELECT 
                        cta.id_cuenta,
                        cta.id_usuario_reg,
                        cta.id_usuario_mod,
                        cta.fecha_reg,
                        cta.fecha_mod,
                        cta.estado_reg,
                       
                        cta.id_empresa,
                        cta.id_parametro,
                        cta.id_cuenta_padre,
                        cta.nro_cuenta,
                        cta.id_gestion,
                        cta.id_moneda,
                        cta.nombre_cuenta,
                        cta.desc_cuenta,
                        cta.nivel_cuenta,
                        cta.tipo_cuenta,
                        cta.sw_transaccional,
                        cta.sw_auxiliar,
                        cta.tipo_cuenta_pat,
                        usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        mon.codigo as desc_moneda,
                        ges.gestion
                        from conta.tcuenta cta
						inner join segu.tusuario usu1 on usu1.id_usuario = cta.id_usuario_reg
                        inner join param.tmoneda mon on mon.id_moneda = cta.id_moneda
                        inner join param.tgestion ges on ges.id_gestion = cta.id_gestion
						left join segu.tusuario usu2 on usu2.id_usuario = cta.id_usuario_mod
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    /*********************************   
     #TRANSACCION:  'CONTA_CTA_ARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            21-02-2013
    ***********************************/

    elseif(p_transaccion='CONTA_CTA_ARB_SEL')then
                    
        begin       
              if(v_parametros.id_padre = '%') then
                v_where := ' cta.id_cuenta_padre is NULL';   
                     
              else
                v_where := ' cta.id_cuenta_padre = '||v_parametros.id_padre;
              end if;
       
       
            --Sentencia de la consulta
            v_consulta:='select
                        cta.id_cuenta,
                        cta.id_cuenta_padre,
                        cta.nombre_cuenta,
                          case
                          when (cta.id_cuenta_padre is null )then
                               ''raiz''::varchar
                          
                          when (cta.sw_transaccional=''titular'' )then
                               ''hijo''::varchar
                          when (cta.sw_transaccional=''movimiento'' )then
                               ''hoja''::varchar
                          END as tipo_nodo,
                        cta.nro_cuenta,
                        cta.desc_cuenta,
                        cta.id_moneda,
                        mon.codigo as desc_moneda,
                        cta.tipo_cuenta,
                        cta.sw_auxiliar,
                        cta.tipo_cuenta_pat,
                        cta.sw_transaccional,
                        cta.id_gestion                       
                        from conta.tcuenta cta
                        inner join param.tmoneda mon on mon.id_moneda = cta.id_moneda
                        where  '||v_where|| ' 
                           and cta.id_gestion = '||COALESCE(v_parametros.id_gestion,0)||'
                           and cta.estado_reg = ''activo''
                        ORDER BY cta.nro_cuenta';
            raise notice '%',v_consulta;
           
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
                        inner join param.tmoneda mon on mon.id_moneda = cta.id_moneda
                        inner join param.tgestion ges on ges.id_gestion = cta.id_gestion
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