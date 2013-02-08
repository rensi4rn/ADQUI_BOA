
   
/***********************************I-DATA-RAC-ADQ-0-31/12/2012*****************************************/

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('ADQ', 'ADquisiciones', '2009-11-02', 'ADQ', 'activo', 'adquisiciones', NULL);



----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('ADQUISICIONES', '', 'ADQ', 'si', , '', 1, '', '', 'ADQ');
----------------------------------
--COPY LINES TO dependencies.sql FILE 
---------------------------------

select pxp.f_insert_testructura_gui ('ADQ', 'SISTEMA');

   
/***********************************F-DEP-RAC-ADQ-0-31/12/2012*****************************************/
