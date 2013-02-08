CREATE OR REPLACE FUNCTION migra.f__on_trig_tpm_moneda_tmoneda (
						  v_operacion varchar,p_id_moneda int4,p_codigo varchar,p_estado_reg varchar,p_fecha_mod timestamp,p_fecha_reg timestamp,p_id_usuario_mod int4,p_id_usuario_reg int4,p_moneda varchar,p_origen varchar,p_prioridad int4,p_tipo_actualizacion varchar,p_tipo_moneda varchar)
						RETURNS text AS
						$BODY$

/*
						Function:  Para migracion de la tabla param.tgestion
						Fecha Creacion:  February 5, 2013, 7:49 am
						Autor: autogenerado (ADMINISTRADOR DEL SISTEMA )
						
						*/
						
						DECLARE
						
						BEGIN
						
						    if(v_operacion = 'INSERT') THEN
						
						          INSERT INTO 
						            PARAM.tmoneda (
						id_moneda,
						codigo,
						estado_reg,
						fecha_mod,
						fecha_reg,
						id_usuario_mod,
						id_usuario_reg,
						moneda,
						origen,
						prioridad,
						tipo_actualizacion,
						tipo_moneda)
				VALUES (
						p_id_moneda,
						p_codigo,
						p_estado_reg,
						p_fecha_mod,
						p_fecha_reg,
						p_id_usuario_mod,
						p_id_usuario_reg,
						p_moneda,
						p_origen,
						p_prioridad,
						p_tipo_actualizacion,
						p_tipo_moneda);

						       
							    ELSEIF  v_operacion = 'UPDATE' THEN
						               UPDATE 
						                  PARAM.tmoneda  
						                SET						 codigo=p_codigo
						 ,estado_reg=p_estado_reg
						 ,fecha_mod=p_fecha_mod
						 ,fecha_reg=p_fecha_reg
						 ,id_usuario_mod=p_id_usuario_mod
						 ,id_usuario_reg=p_id_usuario_reg
						 ,moneda=p_moneda
						 ,origen=p_origen
						 ,prioridad=p_prioridad
						 ,tipo_actualizacion=p_tipo_actualizacion
						 ,tipo_moneda=p_tipo_moneda
						 WHERE id_moneda=p_id_moneda;

						       
						       ELSEIF  v_operacion = 'DELETE' THEN
						       
						         DELETE FROM 
						              PARAM.tmoneda
 
						              						 WHERE id_moneda=p_id_moneda;

						       
						       END IF;  
						  
						 return 'true';
						
						-- statements;
						--EXCEPTION
						--WHEN exception_name THEN
						--  statements;
						END;
						$BODY$


						LANGUAGE 'plpgsql'
						VOLATILE
						CALLED ON NULL INPUT
						SECURITY INVOKER
						COST 100;