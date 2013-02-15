/***********************************I-DAT-FRH-ADQ-0-06/02/2013*****************************************/

/*
*	Author: Freddy Rojas FRH
*	Date: 06/02/2013
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

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('ADQ', 'Adquisiciones', '2013-02-06', 'ADQ', 'activo', 'adquisiciones', NULL);

-------------------------------------
--DEFINICION DE INTERFACES
-------------------------------------

select pxp.f_insert_tgui ('ADQUISICIONES', '', 'ADQ', 'si', 1, '', 1, '', '', 'ADQ');
select pxp.f_insert_tgui ('Configuración', 'Configuración varios', 'ADQ.1', 'si', 1, '', 2, '', '', 'ADQ');
select pxp.f_insert_tgui ('Categorías de Compra', 'Categorías de Compra', 'ADQ.1.1', 'si', 1, 'sis_adquisiciones/vista/categoria_compra/CategoriaCompra.php', 3, '', 'CategoriaCompra', 'ADQ');
select pxp.f_insert_tgui ('Documento de Solicitud', 'Documento de Solicitud', 'ADQ.2', 'si', 1, 'sis_adquisiciones/vista/documento_sol/DocumentoSol.php', 2, '', 'DocumentoSol', 'ADQ');
select pxp.f_insert_tgui ('Solicitud de Compra', 'Solicitud de Compra', 'ADQ.3', 'si', 1, 'sis_adquisiciones/vista/documento_sol/DocumentoSol.php', 2, '', 'Solicitud', 'ADQ');


-------------------------------------
select pxp.f_insert_testructura_gui ('ADQ', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ADQ.1', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.1.1', 'ADQ.1');
select pxp.f_insert_testructura_gui ('ADQ.2', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.3', 'ADQ');



----------------------------------------------
--  DEF DE FUNCIONES
----------------------------------------------

select pxp.f_insert_tfuncion ('adq.f_categoria_compra_ime', 'Funcion para tabla     ', 'ADQ');
select pxp.f_insert_tfuncion ('adq.f_categoria_compra_sel', 'Funcion para tabla     ', 'ADQ');
select pxp.f_insert_tfuncion ('adq.f_documento_sol_ime', 'Funcion para tabla     ', 'ADQ');
select pxp.f_insert_tfuncion ('adq.f_documento_sol_sel', 'Funcion para tabla     ', 'ADQ');

/***********************************F-DAT-FRH-ADQ-0-06/02/2013*****************************************/
