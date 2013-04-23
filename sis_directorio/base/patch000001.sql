/***********************************I-SCP-RAC-DIR-1-08/01/2013****************************************/


CREATE TABLE dir.ttipo_comunicacion (
  id_tiipo_comunicacion SERIAL, 
  nombre VARCHAR(100), 
  CONSTRAINT ttipo_comunicacion_pkey PRIMARY KEY(id_tiipo_comunicacion)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
  
    

/***********************************F-SCP-RAC-DIR-1-08/01/2013****************************************/



/***********************************I-SCP-RAC-DIR-2-08/01/2013****************************************/


ALTER TABLE dir.ttipo_comunicacion
  ADD COLUMN obs TEXT;
  
  
--------------- SQL ---------------

CREATE TABLE dir.tpersona_comunicacion (
  id_persona_comunicacion SERIAL, 
  id_tipo_comunicacion INTEGER, 
  id_persona INTEGER, 
  valor VARCHAR(255), 
  PRIMARY KEY(id_persona_comunicacion)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE dir.tpersona_comunicacion
  OWNER TO postgres;  
  
  
CREATE TABLE dir.tempresa(
    id_empresa SERIAL NOT NULL,
    matricula int8,
    nombre varchar(500),
    renovado int4,
    estado_matricula varchar(255),
    telefono varchar(500),
    mail varchar(255),
    nit varchar(200),
    domicilio text,
    tipo_sociedad varchar(50),
    actividad text,
    departamento varchar(100),
    municipio varchar(100),
    actividad_gral varchar(255),
    actividad_prim varchar(255),
    actividad_esp varchar(255),
    PRIMARY KEY (id_empresa)
    )  INHERITS (pxp.tbase);  
  
  
/***********************************F-SCP-RAC-DIR-2-08/01/2013****************************************/
  