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
select pxp.f_insert_tgui ('Solicitud de Compra', 'Solicitud de Compra', 'ADQ.3', 'si', 1, 'sis_adquisiciones/vista/solicitud/SolicitudReq.php', 2, '', 'SolicitudReq', 'ADQ');
select pxp.f_insert_tgui ('Visto Bueno', 'Solicitud de Compra', 'VBSOL', 'si', 1, 'sis_adquisiciones/vista/solicitud/SolicitudVb.php', 2, '', 'SolicitudReq', 'ADQ');
select pxp.f_insert_tgui ('Proveedores', 'Proveedores de compra', 'ADQ.4', 'si', 1, 'sis_adquisiciones/vista/proveedor/Proveedor.php', 2, '', 'Proveedor', 'ADQ');

-------------------------------------
select pxp.f_insert_testructura_gui ('ADQ', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ADQ.1', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.1.1', 'ADQ.1');
select pxp.f_insert_testructura_gui ('ADQ.2', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.3', 'ADQ');
select pxp.f_insert_testructura_gui ('VBSOL', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.4', 'ADQ');


----------------------------------------------
--  DEF DE FUNCIONES
----------------------------------------------

select pxp.f_insert_tfuncion ('adq.f_categoria_compra_ime', 'Funcion para tabla     ', 'ADQ');
select pxp.f_insert_tfuncion ('adq.f_categoria_compra_sel', 'Funcion para tabla     ', 'ADQ');
select pxp.f_insert_tfuncion ('adq.f_documento_sol_ime', 'Funcion para tabla     ', 'ADQ');
select pxp.f_insert_tfuncion ('adq.f_documento_sol_sel', 'Funcion para tabla     ', 'ADQ');

/***********************************F-DAT-FRH-ADQ-0-06/02/2013*****************************************/



/***********************************I-DAT-RAC-ADQ-0-25/02/2013*****************************************/
--inserta documentos de adquisiciones

SELECT * FROM param.f_inserta_documento('ADQ', 'SOLC', 'Solicitud de Compra', 'periodo', NULL, 'depto', NULL);

--INSERTAR CATEGORIAS DE COMPRA

INSERT INTO adq.tcategoria_compra ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "min", "max", "obs")
VALUES (1, NULL, E'2013-02-25 09:22:56.914', NULL, E'activo', E'CLOC', E'Compra Local', '0', NULL, E'Para todas las compras Locales');

INSERT INTO adq.tcategoria_compra ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "min", "max", "obs")
VALUES (1, NULL, E'2013-02-25 09:23:20.583', NULL, E'activo', E'CINT', E'Compras Internacionales', '0', NULL, E'Para todas las compras Internacionales');

INSERT INTO adq.tcategoria_compra ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "min", "max", "obs")
VALUES (1, NULL, E'2013-02-25 09:23:51.125', NULL, E'activo', E'CMIM', E'Compra Minima', '1', '20000', E'Prueba con rangode compras');


/***********************************F-DAT-RAC-ADQ-0-25/02/2013*****************************************/



