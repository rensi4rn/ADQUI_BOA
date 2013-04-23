/***********************************I-DAT-RAC-DIR-0-06/02/2013*****************************************/

INSERT INTO segu.tsubsistema ( "codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES ( E'DIR', E'Directorio', E'2013-03-15', E'DIR', E'activo', E'directorio', NULL);

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('DIRECTORIO', '', 'DIR', 'si',1 , '', 1, '', '', 'DIR');
select pxp.f_insert_tgui ('empresa', 'empresa', 'emp', 'si', 1, 'sis_directorio/vista/empresa/Empresa.php', 2, '', 'Empresa', 'DIR');
----------------------------------
--COPY LINES TO dependencies.sql FILE 
---------------------------------
select pxp.f_insert_testructura_gui ('DIR', 'SISTEMA');
select pxp.f_insert_testructura_gui ('emp', 'DIR');



/***********************************F-DAT-RAC-DIR-0-06/02/2013*****************************************/



