/***********************************I-DAT-GSS-CONTA-48-20/02/2013*****************************************/

/*
*	Author: Gonzalo Sarmiento Sejas GSS
*	Date: 20/02/2013
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
VALUES ('CONTA', 'Sistema de Contabilidad', 'CONTA', 'activo', 'contabilidad', NULL);

-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------

select pxp.f_insert_tgui ('SISTEMA DE CONTABILIDAD', '', 'CONTA', 'si', 1, '', 1, '', '', 'CONTA');
select pxp.f_insert_tgui ('Plan de Cuentas', 'Cuentas', 'CTA', 'si', 1, 'sis_contabilidad/vista/cuenta/Cuenta.php', 2, '', 'Cuenta', 'CONTA');
select pxp.f_insert_tgui ('Auxiliares de Cuentas', 'Auxiliares de cuenta', 'AUXCTA', 'si', 2, 'sis_contabilidad/vista/auxiliar/Auxiliar.php', 2, '', 'Auxiliar', 'CONTA');
select pxp.f_insert_tgui ('Ordenes de Trabajo', 'ordenes de trabajo', 'ODT', 'si', 3, 'sis_contabilidad/vista/orden_trabajo/OrdenTrabajo.php', 2, '', 'OrdenTrabajo', 'CONTA');

select pxp.f_insert_testructura_gui ('CONTA', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CTA', 'CONTA');
select pxp.f_insert_testructura_gui ('AUXCTA', 'CONTA');
select pxp.f_insert_testructura_gui ('ODT', 'CONTA'); 

----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------

select pxp.f_insert_tfuncion ('conta.f_cuenta_ime', 'Funcion para tabla     ', 'CONTA');
select pxp.f_insert_tfuncion ('conta.f_cuenta_sel', 'Funcion para tabla     ', 'CONTA');
select pxp.f_insert_tfuncion ('conta.f_auxiliar_sel', 'Funcion para tabla     ', 'CONTA');
select pxp.f_insert_tfuncion ('conta.f_auxiliar_ime', 'Funcion para tabla     ', 'CONTA');
select pxp.f_insert_tfuncion ('conta.f_orden_trabajo_sel', 'Funcion para tabla     ', 'CONTA');
select pxp.f_insert_tfuncion ('conta.f_orden_trabajo_ime', 'Funcion para tabla     ', 'CONTA');

---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------

select pxp.f_insert_tprocedimiento ('CONTA_CTA_INS', 'Insercion de registros', 'si', '', '', 'conta.f_cuenta_ime');
select pxp.f_insert_tprocedimiento ('CONTA_CTA_MOD', 'Modificacion de registros', 'si', '', '', 'conta.f_cuenta_ime');
select pxp.f_insert_tprocedimiento ('CONTA_CTA_ELI', 'Eliminacion de registros', 'si', '', '', 'conta.f_cuenta_ime');
select pxp.f_insert_tprocedimiento ('CONTA_CTA_SEL', 'Consulta de datos', 'si', '', '', 'conta.f_cuenta_sel');
select pxp.f_insert_tprocedimiento ('CONTA_CTA_CONT', 'Conteo de registros', 'si', '', '', 'conta.f_cuenta_sel');
select pxp.f_insert_tprocedimiento ('CONTA_CTA_ARB_SEL', 'Consulta de datos', 'si', '', '', 'conta.f_cuenta_sel');
select pxp.f_insert_tprocedimiento ('CONTA_AUXCTA_SEL', 'Consulta de datos', 'si', '', '', 'conta.f_auxiliar_sel');
select pxp.f_insert_tprocedimiento ('CONTA_AUXCTA_CONT', 'Conteo de registros', 'si', '', '', 'conta.f_auxiliar_sel');
select pxp.f_insert_tprocedimiento ('CONTA_AUXCTA_INS', 'Insercion de registros', 'si', '', '', 'conta.f_auxiliar_ime');
select pxp.f_insert_tprocedimiento ('CONTA_AUXCTA_MOD', 'Modificacion de registros', 'si', '', '', 'conta.f_auxiliar_ime');
select pxp.f_insert_tprocedimiento ('CONTA_AUXCTA_ELI', 'Eliminacion de registros', 'si', '', '', 'conta.f_auxiliar_ime');
select pxp.f_insert_tprocedimiento ('CONTA_ODT_SEL', 'Consulta de datos', 'si', '', '', 'conta.f_orden_trabajo_sel');
select pxp.f_insert_tprocedimiento ('CONTA_ODT_CONT', 'Conteo de registros', 'si', '', '', 'conta.f_orden_trabajo_sel');
select pxp.f_insert_tprocedimiento ('CONTA_ODT_INS', 'Insercion de registros', 'si', '', '', 'conta.f_orden_trabajo_ime');
select pxp.f_insert_tprocedimiento ('CONTA_ODT_MOD', 'Modificacion de registros', 'si', '', '', 'conta.f_orden_trabajo_ime');
select pxp.f_insert_tprocedimiento ('CONTA_ODT_ELI', 'Eliminacion de registros', 'si', '', '', 'conta.f_orden_trabajo_ime');

/***********************************F-DAT-GSS-CONTA-48-20/02/2013*****************************************/
