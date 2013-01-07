/***********************************I-SCP-RAC-CONTA-1-01/01/2013****************************************/

CREATE TABLE conta.torden_trabajo(
id_orden_trabajo SERIAL NOT NULL, 
desc_orden varchar(100), 
    motivo_orden varchar(500), 
    fecha_inicio date, 
    fecha_final date, PRIMARY KEY(
    id_orden_trabajo))INHERITS (pxp.tbase);



CREATE TABLE conta.tauxiliar(
id_auxiliar SERIAL NOT NULL, 
id_empresa int4 NOT NULL, 
codigo_auxiliar varchar(15), 
nombre_auxiliar int4, 
PRIMARY KEY(id_auxiliar))INHERITS (pxp.tbase);

/***********************************F-SCP-RAC-CONTA-1-01/01/2013****************************************/
