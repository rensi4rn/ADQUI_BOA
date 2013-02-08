
   
/***********************************I-DEP-RAC-ADQ-0-31/12/2012*****************************************/
ALTER TABLE adq.tsolicitud ADD CONSTRAINT fk_solicitud__id_solicitud FOREIGN KEY(
    id_solicitud_ext) REFERENCES adq.tsolicitud(
    id_solicitud);
    
    
ALTER TABLE adq.tplan_pago ADD CONSTRAINT fk_tpllan_pago_id_pla_pago_dev FOREIGN KEY(
    id_plan_pago_dev) REFERENCES adq.tplan_pago(
    id_plan_pago);
    

/***********************************F-DEP-RAC-ADQ-0-04/01/2013*****************************************/
