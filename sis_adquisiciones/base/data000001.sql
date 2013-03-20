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
select pxp.f_insert_tgui ('Visto Bueno', 'Solicitud de Compra', 'VBSOL', 'si', 1, 'sis_adquisiciones/vista/solicitud/SolicitudVb.php', 2, '', 'SolicitudVb', 'ADQ');
select pxp.f_insert_tgui ('Proveedores', 'Proveedores de compra', 'ADQ.4', 'si', 1, 'sis_adquisiciones/vista/proveedor/Proveedor.php', 2, '', 'Proveedor', 'ADQ');
select pxp.f_insert_tgui ('Proceso Compra', 'Proceso de Compra', 'PROC', 'si', 4, 'sis_adquisiciones/vista/proceso_compra/ProcesoCompra.php', 2, '', 'ProcesoCompra', 'ADQ');


-------------------------------------
select pxp.f_insert_testructura_gui ('ADQ', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ADQ.1', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.1.1', 'ADQ.1');
select pxp.f_insert_testructura_gui ('ADQ.2', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.3', 'ADQ');
select pxp.f_insert_testructura_gui ('VBSOL', 'ADQ');
select pxp.f_insert_testructura_gui ('ADQ.4', 'ADQ');
select pxp.f_insert_testructura_gui ('PROC', 'ADQ');


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


select wf.f_insert_tproceso_macro ('COMINT', 'Compra internacional', 'SI', 'activo', 'Adquisiciones');
select wf.f_insert_ttipo_proceso ('Solicitud de compra', 'SOLCO', 'adq.tsolicitud', 'id_solicitud', 'activo', 'si', 'COMINT');
select wf.f_insert_ttipo_proceso ('Adjudicacion de compra', 'ADJCO', '', '', 'activo', 'no', 'COMINT');
select wf.f_insert_ttipo_proceso ('aa', 'aa', 'xx', 'xx', 'activo', 'no', 'COMINT');
select wf.f_insert_ttipo_proceso ('Proceso de Compra', 'PROC', 'adq.tproceso_compra', 'id_proceso_compra', 'activo', 'no', 'COMINT');
select wf.f_insert_ttipo_estado ('borrador', 'Borrador', 'si', 'no', '', 'listado', '', 'ninguno', '', '', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('proceso', 'En_Proceso', 'no', 'si', '', 'todos', '', 'ninguno', '', '', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('finalizado', 'Finalizado', 'no', 'no', '', '', '', 'ninguno', '', '', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('', 'Elaboracion_Informe_Comision', 'si', 'no', '', '', 'f5', 'ninguno', '', '', 'activo', 'ADJCO');
select wf.f_insert_ttipo_estado ('', 'Elaboracion_Contrato', 'no', 'no', '', '', 'f4', 'ninguno', '', '', 'activo', 'ADJCO');
select wf.f_insert_ttipo_estado ('pendiente', 'Aprobación Supervisor', 'no', 'no', 'no', 'funcion_listado', 'ADQ_APR_SOL_COMPRA', 'ninguno', '', '', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('', 'Firma_GG', 'no', 'no', '', 'listado', '', 'ninguno', '', '', 'activo', 'ADJCO');
select wf.f_insert_ttipo_estado ('vbrpc', 'Visto Bueno RPC', 'no', 'no', 'no', 'funcion_listado', 'ADQ_RPC_SOL_COMPRA', 'ninguno', '', '', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('vbactif', 'Visto Bueno Activos Fijos', 'no', 'no', 'no', 'listado', '', 'ninguno', '', '43120,43100,aaa,bb,1', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('aprobado', 'Solicitud de Aprobada', 'no', 'no', 'no', 'anterior', '', 'depto_func_list', 'ADQ_DEPTO_SOL', '', 'activo', 'SOLCO');
select wf.f_insert_ttipo_estado ('pendiente', 'Proceso pendiente', 'si', 'no', 'no', 'ninguno', '', 'depto_func_list', 'ADQ_DEPT_PROC', '', 'activo', 'PROC');
select wf.f_insert_ttipo_estado ('proceso', 'Inicio de Proceso de COmpra', 'no', 'si', 'no', 'ninguno', '', 'anterior', '', 'cuando el proceso se inicia', 'activo', 'PROC');
select wf.f_insert_ttipo_estado ('finalizado', 'Proceso Finalizado', 'no', 'no', 'si', 'ninguno', '', 'anterior', '', 'El proceso esta finalizado  cuando, se declara decierto o cuando se finalizaron todas las solcitudes', 'activo', 'PROC');
select wf.f_insert_ttipo_estado ('desierto', 'Proceso Desierto', 'no', 'no', 'si', 'ninguno', '', 'anterior', '', '', 'activo', 'PROC');
select wf.f_insert_testructura_estado ('En_Proceso', 'Finalizado', '2', 'ff2', 'activo');
select wf.f_insert_testructura_estado ('Elaboracion_Informe_Comision', 'Elaboracion_Contrato', '5', 'ff3', 'activo');
select wf.f_insert_testructura_estado ('Aprobación Supervisor', 'Visto Bueno Activos Fijos', '3', '', 'activo');
select wf.f_insert_testructura_estado ('Elaboracion_Contrato', 'Firma_GG', '1', '', 'activo');
select wf.f_insert_testructura_estado ('Borrador', 'Aprobación Supervisor', '0', '', 'activo');
select wf.f_insert_testructura_estado ('Visto Bueno Activos Fijos', 'Visto Bueno RPC', '1', '', 'activo');
select wf.f_insert_testructura_estado ('Visto Bueno RPC', 'Solicitud de Aprobada', '1', '', 'activo');
select wf.f_insert_testructura_estado ('Solicitud de Aprobada', 'En_Proceso', '1', '', 'activo');
select wf.f_insert_testructura_estado ('Proceso pendiente', 'Inicio de Proceso de COmpra', '1', '', 'activo');
select wf.f_insert_testructura_estado ('Inicio de Proceso de COmpra', 'Inicio de Proceso de COmpra', '1', '', 'activo');
select wf.f_insert_testructura_estado ('Inicio de Proceso de COmpra', 'Proceso Desierto', '1', '', 'activo');




/***********************************F-DAT-RAC-ADQ-0-07/03/2013*****************************************/



