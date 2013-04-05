/***********************************I-DAT-GSS-TES-45-02/04/2013*****************************************/

/*
*	Author: Gonzalo Sarmiento Sejas GSS
*	Date: 02/04/2013
*	Description: Build the menu definition and the composition
*/
/*

Para  definir la la metadata, menus, roles, etc

1) sincronize ls funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos a archivo SQL (desde la interface de sistema en sis_seguridad), 
    verifique que la codificacion  se mantenga en UTF8 para no distorcionar los caracteres especiales
4)  remplaze los sectores correspondientes en este archivo en su totalidad:  (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos
*/

INSERT INTO segu.tsubsistema ( codigo, nombre, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('TES', 'Sistema de Tesoreria', 'TES', 'activo', 'tesoreria', NULL);

-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------

select pxp.f_insert_tgui ('SISTEMA DE TESORERIA', '', 'TES', 'si', 6, '', 1, '', '', 'TES');
select pxp.f_insert_tgui ('Obligacion Pago', 'Obligaciones de pago', 'OBPG', 'si', 1, 'sis_tesoreria/vista/obligacion_pago/ObligacionPago.php', 2, '', 'ObligacionPago', 'TES');
select pxp.f_insert_tgui ('Detalle', 'Detalle', 'OBPG.1', 'no', 0, 'sis_tesoreria/vista/obligacion_det/ObligacionDet.php', 3, '', '50%', 'TES');

select pxp.f_insert_testructura_gui ('TES', 'SISTEMA');
select pxp.f_insert_testructura_gui ('OBPG', 'TES');
select pxp.f_insert_testructura_gui ('OBPG.1', 'OBPG');
----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------

select pxp.f_insert_tfuncion ('tes.ft_obligacion_pago_ime', 'Funcion para tabla     ', 'TES');
select pxp.f_insert_tfuncion ('tes.ft_obligacion_pago_sel', 'Funcion para tabla     ', 'TES');
select pxp.f_insert_tfuncion ('tes.ft_obligacion_det_ime', 'Funcion para tabla     ', 'TES');
select pxp.f_insert_tfuncion ('tes.ft_obligacion_det_sel', 'Funcion para tabla     ', 'TES');

---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------

select pxp.f_insert_tprocedimiento ('TES_OBPG_INS', 'Insercion de registros', 'si', '', '', 'tes.ft_obligacion_pago_ime');
select pxp.f_insert_tprocedimiento ('TES_OBPG_MOD', 'Modificacion de registros', 'si', '', '', 'tes.ft_obligacion_pago_ime');
select pxp.f_insert_tprocedimiento ('TES_OBPG_ELI', 'Eliminacion de registros', 'si', '', '', 'tes.ft_obligacion_pago_ime');
select pxp.f_insert_tprocedimiento ('TES_OBPG_SEL', 'Consulta de datos', 'si', '', '', 'tes.ft_obligacion_pago_sel');
select pxp.f_insert_tprocedimiento ('TES_OBPG_CONT', 'Conteo de registros', 'si', '', '', 'tes.ft_obligacion_pago_sel');
select pxp.f_insert_tprocedimiento ('TES_OBDET_INS', 'Insercion de registros', 'si', '', '', 'tes.ft_obligacion_det_ime');
select pxp.f_insert_tprocedimiento ('TES_OBDET_MOD', 'Modificacion de registros', 'si', '', '', 'tes.ft_obligacion_det_ime');
select pxp.f_insert_tprocedimiento ('TES_OBDET_ELI', 'Eliminacion de registros', 'si', '', '', 'tes.ft_obligacion_det_ime');
select pxp.f_insert_tprocedimiento ('TES_OBDET_SEL', 'Consulta de datos', 'si', '', '', 'tes.ft_obligacion_det_sel');
select pxp.f_insert_tprocedimiento ('TES_OBDET_CONT', 'Conteo de registros', 'si', '', '', 'tes.ft_obligacion_det_sel');


select pxp.f_insert_tprocedimiento_gui ('TES_OBPG_INS', 'OBPG', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBPG_MOD', 'OBPG', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBPG_ELI', 'OBPG', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBPG_SEL', 'OBPG', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBDET_INS', 'OBPG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBDET_MOD', 'OBPG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBDET_ELI', 'OBPG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('TES_OBDET_SEL', 'OBPG.1', 'no');

/***********************************F-DAT-GSS-TES-45-02/04/2013*****************************************/
