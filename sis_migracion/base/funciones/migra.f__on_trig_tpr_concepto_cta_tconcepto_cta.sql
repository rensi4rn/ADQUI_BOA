CREATE OR REPLACE FUNCTION migra.f__on_trig_tpr_concepto_cta_tconcepto_cta (
  v_operacion varchar,
  p_id_concepto_cta integer,
  p_estado_reg varchar,
  p_fecha_mod timestamp,
  p_fecha_reg timestamp,
  p_id_auxiliar integer,
  p_id_centro_costo integer,
  p_id_concepto_ingas integer,
  p_id_cuenta integer,
  p_id_partida integer,
  p_id_usuario_mod integer,
  p_id_usuario_reg integer
)
RETURNS text AS
$body$
/*
						Function:  Para migracion de la tabla param.tgestion
						Fecha Creacion:  February 18, 2013, 6:03 pm
						Autor: autogenerado (ADMINISTRADOR DEL SISTEMA )
						
						*/
						
						DECLARE
						
						BEGIN
						
						    if(v_operacion = 'INSERT') THEN
						
						          INSERT INTO 
						            PRE.tconcepto_cta (
						id_concepto_cta,
						estado_reg,
						fecha_mod,
						fecha_reg,
						id_auxiliar,
						id_centro_costo,
						id_concepto_ingas,
						id_cuenta,
						id_partida,
						id_usuario_mod,
						id_usuario_reg)
				VALUES (
						p_id_concepto_cta,
						p_estado_reg,
						p_fecha_mod,
						p_fecha_reg,
						p_id_auxiliar,
						p_id_centro_costo,
						p_id_concepto_ingas,
						p_id_cuenta,
						p_id_partida,
						p_id_usuario_mod,
						p_id_usuario_reg);

						       
							    ELSEIF  v_operacion = 'UPDATE' THEN
						               UPDATE 
						                  PRE.tconcepto_cta  
						                SET						 estado_reg=p_estado_reg
						 ,fecha_mod=p_fecha_mod
						 ,fecha_reg=p_fecha_reg
						 ,id_auxiliar=p_id_auxiliar
						 ,id_centro_costo=p_id_centro_costo
						 ,id_concepto_ingas=p_id_concepto_ingas
						 ,id_cuenta=p_id_cuenta
						 ,id_partida=p_id_partida
						 ,id_usuario_mod=p_id_usuario_mod
						 ,id_usuario_reg=p_id_usuario_reg
						 WHERE id_concepto_cta=p_id_concepto_cta;

						       
						       ELSEIF  v_operacion = 'DELETE' THEN
						       
						         DELETE FROM 
						              PRE.tconcepto_cta
 
						              						 WHERE id_concepto_cta=p_id_concepto_cta;

						       
						       END IF;  
						  
						 return 'true';
						
						-- statements;
						--EXCEPTION
						--WHEN exception_name THEN
						--  statements;
						END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;