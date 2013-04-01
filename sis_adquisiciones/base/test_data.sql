------------------------------
--               APROBADORES (EN PARAMETROS)
--------------------------



/* Data for the 'param.taprobador' table  (Records 1 - 3) */

INSERT INTO param.taprobador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_subsistema", "id_centro_costo", "monto_min", "monto_max", "fecha_ini", "fecha_fin", "id_uo", "obs", "id_ep")
VALUES (1, NULL, E'2013-03-20 13:40:10.761', NULL, E'activo', 2, 6, NULL, '0', NULL, E'2013-01-01', NULL, 2, E'', NULL);

INSERT INTO param.taprobador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_subsistema", "id_centro_costo", "monto_min", "monto_max", "fecha_ini", "fecha_fin", "id_uo", "obs", "id_ep")
VALUES (1, NULL, E'2013-03-20 13:41:13.113', NULL, E'activo', 3, 6, NULL, '0', NULL, E'2012-11-01', NULL, 7, E'', NULL);

INSERT INTO param.taprobador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_subsistema", "id_centro_costo", "monto_min", "monto_max", "fecha_ini", "fecha_fin", "id_uo", "obs", "id_ep")
VALUES (1, NULL, E'2013-03-20 13:41:21.555', NULL, E'activo', 3, 6, NULL, '0', NULL, E'2012-11-01', NULL, 9, E'', NULL);


---------------------------------------------------
-- DEPTOS (EN PARAMETROS)
------------------------------------------------

/* Data for the 'param.tdepto' table  (Records 1 - 2) */

INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, NULL, E'2013-03-20 00:00:00', E'2013-03-20 14:17:22.287', E'activo', 6, E'ADQ', E'Adquisiciones  Central', E'');

INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, NULL, E'2013-03-20 00:00:00', E'2013-03-20 14:17:45.392', E'activo', 6, E'ADQLP', E'Departamento de Adquisiciones La Paz', E'ADQLP');

/* Data for the 'param.tdepto_usuario' table  (Records 1 - 2) */

INSERT INTO param.tdepto_usuario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "id_usuario", "funcion", "cargo")
VALUES (1, NULL, E'2013-03-20 14:17:55.046', NULL, E'activo', 2, 1, NULL, E'');

INSERT INTO param.tdepto_usuario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "id_usuario", "funcion", "cargo")
VALUES (1, NULL, E'2013-03-20 14:18:01.481', NULL, E'activo', 1, 1, NULL, E'');


-------------------------------------------
-- INICIO ROLES 
-- Autor Gonzalo Sarmiento Sejas
------------------------------------------

--roles--

select pxp.f_insert_trol ('solicitante de compra', 'Solicitante de Compra', 'ADQ');
select pxp.f_insert_trol ('visto bueno de solicitud de compra', 'Visto Bueno Solicitud', 'ADQ');
select pxp.f_insert_trol ('proceso de compra', 'Proceso de compra encargado', 'ADQ');

--roles_gui

select pxp.f_insert_tgui_rol ('ADQ.3', 'Solicitante de Compra');
select pxp.f_insert_tgui_rol ('ADQ', 'Solicitante de Compra');
select pxp.f_insert_tgui_rol ('ADQ.3.1', 'Solicitante de Compra');
select pxp.f_insert_tgui_rol ('VBSOL', 'Visto Bueno Solicitud');
select pxp.f_insert_tgui_rol ('ADQ', 'Visto Bueno Solicitud');
select pxp.f_insert_tgui_rol ('VBSOL.1', 'Visto Bueno Solicitud');
select pxp.f_insert_tgui_rol ('PROC', 'Proceso de compra encargado');
select pxp.f_insert_tgui_rol ('ADQ', 'Proceso de compra encargado');
select pxp.f_insert_tgui_rol ('PROC.1', 'Proceso de compra encargado');
select pxp.f_insert_tgui_rol ('PROC.1.1', 'Proceso de compra encargado');
select pxp.f_insert_tgui_rol ('PROC.2', 'Proceso de compra encargado');

--procedimientos_gui

select pxp.f_insert_tprocedimiento_gui ('ADQ_CATCOMP_INS', 'ADQ.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CATCOMP_MOD', 'ADQ.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CATCOMP_ELI', 'ADQ.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CATCOMP_SEL', 'ADQ.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_INS', 'ADQ.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_MOD', 'ADQ.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_ELI', 'ADQ.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_SEL', 'ADQ.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOLAR_SEL', 'ADQ.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_FINSOL_IME', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SIGESOL_IME', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_ANTESOL_IME', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_SEL', 'ADQ.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_ARB_SEL', 'ADQ.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROVEE_INS', 'ADQ.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROVEE_MOD', 'ADQ.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROVEE_ELI', 'ADQ.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROVEE_SEL', 'ADQ.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOL_SEL', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROC_INS', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROC_MOD', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROC_ELI', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_PROC_SEL', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEEV_SEL', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_COT_INS', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_COT_MOD', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_COT_ELI', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_COT_SEL', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_COTREP_SEL', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLDETCOT_SEL', 'PROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CTD_INS', 'PROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CTD_MOD', 'PROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CTD_ELI', 'PROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CTD_SEL', 'PROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOL_SEL', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOL_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLD_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CTD_SEL', 'PROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GETGES_ELI', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_CATCOMP_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOLAR_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_INS', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOL_INS', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOL_MOD', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOL_ELI', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLREP_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_MOD', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOL_ELI', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_OBTARPOBA_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('CONTA_ODT_SEL', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLD_INS', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLD_MOD', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLD_ELI', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOLAR_MOD', 'ADQ.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLD_SEL', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLREP_SEL', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_DOCSOLAR_SEL', 'VBSOL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_SOLD_SEL', 'PROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('ADQ_FINREGC_IME', 'PROC', 'no');

--rol_procedimiento_gui

select pxp.f_insert_trol_procedimiento_gui ('Responsable Visto Bueno', 'ADQ_SIGESOL_IME', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Responsable Visto Bueno', 'ADQ_ANTESOL_IME', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Responsable Visto Bueno', 'ADQ_SOL_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_FINSOL_IME', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOL_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOLD_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'PM_MONEDA_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'WF_PROMAC_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'PM_GETGES_ELI', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'PM_DEPPTO_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'RH_FUNCIO_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'RH_UO_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'RH_FUNCIOCAR_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_CATCOMP_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_DOCSOLAR_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_DOCSOL_INS', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOL_INS', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOL_MOD', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOL_ELI', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOLREP_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_DOCSOL_MOD', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_DOCSOL_ELI', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'PM_OBTARPOBA_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'PM_CEC_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'PM_CONIG_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'CONTA_ODT_SEL', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOLD_INS', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOLD_MOD', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_SOLD_ELI', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Solicitante de Compra', 'ADQ_DOCSOLAR_MOD', 'ADQ.3');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'ADQ_SIGESOL_IME', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'ADQ_ANTESOL_IME', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'ADQ_SOL_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'WF_TIPES_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'WF_FUNTIPES_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'ADQ_SOLD_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'ADQ_SOLREP_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Visto Bueno Solicitud', 'ADQ_DOCSOLAR_SEL', 'VBSOL');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_SOL_SEL', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_PROC_INS', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_PROC_MOD', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_PROC_ELI', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_PROC_SEL', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'PM_PROVEEV_SEL', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'PM_MONEDA_SEL', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_COT_INS', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_COT_MOD', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_COT_ELI', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_COT_SEL', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_COTREP_SEL', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_CTD_SEL', 'PROC.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_SOLDETCOT_SEL', 'PROC.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_CTD_INS', 'PROC.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_CTD_MOD', 'PROC.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_CTD_ELI', 'PROC.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_CTD_SEL', 'PROC.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'PM_DEPPTO_SEL', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_SOLD_SEL', 'PROC');
select pxp.f_insert_trol_procedimiento_gui ('Proceso de compra encargado', 'ADQ_FINREGC_IME', 'PROC');

-------------------------------------------
-- FIN ROLES 
-- Autor Gonzalo Sarmiento Sejas
------------------------------------------