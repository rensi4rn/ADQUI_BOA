CREATE OR REPLACE FUNCTION migra.f__on_trig_tkp_empleado_tfuncionario (
  v_operacion varchar,
  p_id_funcionario integer,
  p_id_persona integer,
  p_id_usuario_mod integer,
  p_id_usuario_reg integer,
  p_codigo varchar,
  p_email_empresa varchar,
  p_estado_reg varchar,
  p_fecha_ingreso date,
  p_fecha_mod timestamp,
  p_fecha_reg timestamp,
  p_interno varchar
)
RETURNS text AS
$body$
/*
						Function:  Para migracion de la tabla param.tgestion
						Fecha Creacion:  February 7, 2013, 6:59 pm
						Autor: autogenerado (ADMINISTRADOR DEL SISTEMA )
						
						*/
						
						DECLARE
						
						BEGIN
						
						    if(v_operacion = 'INSERT') THEN
						
						          INSERT INTO 
						            ORGA.tfuncionario (
						id_funcionario,
						id_persona,
						id_usuario_mod,
						id_usuario_reg,
						codigo,
						email_empresa,
						estado_reg,
						fecha_ingreso,
						fecha_mod,
						fecha_reg,
						interno)
				VALUES (
						p_id_funcionario,
						p_id_persona,
						p_id_usuario_mod,
						p_id_usuario_reg,
						p_codigo,
						p_email_empresa,
						p_estado_reg,
						p_fecha_ingreso,
						p_fecha_mod,
						p_fecha_reg,
						p_interno);

						       
							    ELSEIF  v_operacion = 'UPDATE' THEN
						               UPDATE 
						                  ORGA.tfuncionario  
						                SET						 id_persona=p_id_persona
						 ,id_usuario_mod=p_id_usuario_mod
						 ,id_usuario_reg=p_id_usuario_reg
						 ,codigo=p_codigo
						 ,email_empresa=p_email_empresa
						 ,estado_reg=p_estado_reg
						 ,fecha_ingreso=p_fecha_ingreso
						 ,fecha_mod=p_fecha_mod
						 ,fecha_reg=p_fecha_reg
						 ,interno=p_interno
						 WHERE id_funcionario=p_id_funcionario;

						       
						       ELSEIF  v_operacion = 'DELETE' THEN
						       
						         DELETE FROM 
						              ORGA.tfuncionario
 
						              						 WHERE id_funcionario=p_id_funcionario;

						       
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