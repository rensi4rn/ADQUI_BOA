
   
/***********************************I-DEP-RAC-DIR-0-31/12/2012*****************************************/
--------------- SQL ---------------

ALTER TABLE dir.tpersona_comunicacion
  ADD CONSTRAINT tpersona_comunicacion_fk FOREIGN KEY (id_persona)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
  
    

/***********************************F-DEP-RAC-DIR-0-31/12/2012*****************************************/
