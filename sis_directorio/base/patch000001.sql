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
  
  
/***********************************F-SCP-RAC-DIR-2-08/01/2013****************************************/
  