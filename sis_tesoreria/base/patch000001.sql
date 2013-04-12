/***********************************I-SCP-GSS-TES-45-01/04/2013****************************************/

--tabla tes.tobligacion_pago

CREATE TABLE tes.tobligacion_pago (
  id_obligacion_pago SERIAL, 
  id_proveedor INTEGER NOT NULL, 
  id_funcionario INTEGER, 
  id_subsistema INTEGER, 
  id_moneda INTEGER, 
  id_depto INTEGER, 
  id_proceso_wf INTEGER, 
  id_estado_wf INTEGER, 
  id_gestion integer not NULL,
  fecha DATE,
  numero VARCHAR(50),
  estado VARCHAR(255), 
  obs VARCHAR(1000), 
  porc_anticipo NUMERIC(2,2), 
  porc_retgar NUMERIC(2,2),
  tipo_cambio NUMERIC(19,2), 
  num_tramite VARCHAR(200), 
  tipo_obligacion VARCHAR(30), 
  comprometido VARCHAR(2) DEFAULT 'no'::character varying, 
  CONSTRAINT pk_tobligacion_pago__id_obligacion_pago PRIMARY KEY(id_obligacion_pago), 
  CONSTRAINT chk_tobligacion_pago__estado CHECK ((estado)::text = ANY (ARRAY[('borrador'::character varying)::text, ('proceso'::character varying)::text, ('finalizado'::character varying)::text])), 
  CONSTRAINT chk_tobligacion_pago__tipo_obligacion CHECK ((tipo_obligacion)::text = ANY ((ARRAY['adquisiciones'::character varying, 'caja_chica'::character varying, 'viaticos'::character varying, 'fondos_en_avance'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITHOUT OIDS;

--------------- SQL ---------------

 -- object recreation
ALTER TABLE tes.tobligacion_pago
  DROP CONSTRAINT chk_tobligacion_pago__tipo_obligacion RESTRICT;

ALTER TABLE tes.tobligacion_pago
  ADD CONSTRAINT chk_tobligacion_pago__tipo_obligacion CHECK ((tipo_obligacion)::text = ANY (ARRAY[('adquisiciones'::character varying)::text, ('caja_chica'::character varying)::text, ('viaticos'::character varying)::text, ('fondos_en_avance'::character varying)::text, ('pago_directo'::character varying)::text]));


ALTER TABLE tes.tobligacion_pago OWNER TO postgres;

--tabla tes.tobligacion_det

CREATE TABLE tes.tobligacion_det (
  id_obligacion_det SERIAL, 
  id_obligacion_pago INTEGER NOT NULL, 
  id_concepto_ingas INTEGER NOT NULL, 
  id_centro_costo INTEGER, 
  id_partida INTEGER, 
  id_cuenta INTEGER, 
  id_auxiliar INTEGER, 
  id_partida_ejecucion_com INTEGER,
  descripcion TEXT, 
  monto_pago_mo NUMERIC(19,2), 
  monto_pago_mb NUMERIC(19,2), 
  factor_porcentual NUMERIC(19,2),
 
  CONSTRAINT pk_tobligacion_det__id_obligacion_det PRIMARY KEY(id_obligacion_det)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE tes.tobligacion_det OWNER TO postgres;

--tabla tes.tplan_pago

CREATE TABLE tes.tplan_pago(
    id_plan_pago SERIAL NOT NULL,
    id_obligacion_pago int4 NOT NULL,
    id_plantilla int4 NOT NULL,
    id_plan_pago_fk int4,
    id_cuenta_bancaria int4,
    id_comprobante int4,
    id_estado_wf int4,
    id_proceso_wf int4,
    estado varchar(60),
    nro_sol_pago varchar(60),
    nro_cuota int4,
    nombre_pago varchar(255),
    forma_pago varchar(25),
    tipo_pago varchar(20),
    tipo varchar(30),
    fecha_dev date,
    fecha_pag date,
    tipo_cambio numeric(19, 2),
    obs_descuentos_anticipo text,
    obs_monto_no_pagado text,
    obs_otros_descuentos text,
    monto numeric(19, 2),
    descuento_anticipo numeric(19, 2),
    monto_no_pagado numeric(19, 2),
    otros_decuentos numeric(19, 2),
    monto_mb numeric(19, 2),
    descuento_anticipo_mb numeric(19, 2),
    monto_no_pagado_mb numeric(19, 2),
    otros_descuentos_mb numeric(19, 2),
    monto_ejecutar_total_mo numeric(19, 2),
    monto_ejecutar_total_mb numeric(19, 2),
    PRIMARY KEY (id_plan_pago)) INHERITS (pxp.tbase);
    
    

/***********************************F-SCP-GSS-TES-45-01/04/2013****************************************/