

/***********************************I-DEP-FRH-ADQ-0-15/02/2013*****************************************/


ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_funcionario FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario (id_funcionario);

ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_funcionario_solicitud FOREIGN KEY (id_funcionario_aprobador) REFERENCES orga.tfuncionario (id_funcionario);

ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_depto FOREIGN KEY (id_depto) REFERENCES param.tdepto (id_depto);

ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_gestion FOREIGN KEY (id_gestion) REFERENCES param.tgestion (id_gestion);

ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_categoria_compra FOREIGN KEY (id_categoria_compra) REFERENCES adq.tcategoria_compra (id_categoria_compra);

ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_moneda FOREIGN KEY (id_moneda) REFERENCES param.tmoneda (id_moneda);

ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_estado_wf FOREIGN KEY (id_estado_wf) REFERENCES wf.testado_wf (id_estado_wf);
  
ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_proceso_wf FOREIGN KEY (id_proceso_wf) REFERENCES wf.tproceso_wf (id_proceso_wf);
    
ALTER TABLE adq.tsolicitud ADD CONSTRAINT 
  fk_solicitud__id_solicitud_ext FOREIGN KEY (id_solicitud_ext) REFERENCES adq.tsolicitud (id_solicitud);


/***********************************F-DEP-FRH-ADQ-0-15/02/2013*****************************************/