/***********************************I-SCP-GSS-TES-45-01/04/2013****************************************/

--tabla tes.tobligacion_pago

CREATE TABLE tes.tobligacion_pago (
  id_obligacion_pago SERIAL, 
  id_proveedor INTEGER NOT NULL, 
  id_subsistema INTEGER, 
  id_moneda INTEGER, 
  id_depto INTEGER, 
  id_proceso_wf INTEGER, 
  id_estado_wf INTEGER, 
  estado VARCHAR(255), 
  obs VARCHAR(1000), 
  porc_anticipo NUMERIC(2,2), 
  porc_retgar NUMERIC(2,2), 
  num_tramite VARCHAR(200), 
  tipo_obligacion VARCHAR(30), 
  id_funcionario INTEGER, 
  CONSTRAINT pk_tobligacion_pago__id_obligacion_pago PRIMARY KEY(id_obligacion_pago), 
  CONSTRAINT chk_tobligacion_pago__estado CHECK ((estado)::text = ANY (ARRAY[('borrador'::character varying)::text, ('proceso'::character varying)::text, ('finalizado'::character varying)::text])), 
  CONSTRAINT chk_tobligacion_pago__tipo_obligacion CHECK ((tipo_obligacion)::text = ANY ((ARRAY['adquisiciones'::character varying, 'caja_chica'::character varying, 'viaticos'::character varying, 'fondos_en_avance'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITHOUT OIDS;

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
  id_partida_ejecucion_com INTEGER NOT NULL, 
  monto_pago_mo NUMERIC(19,0), 
  monto_pago_mb INTEGER, 
  factor_porcentual NUMERIC(19,0), 
  CONSTRAINT pk_tobligacion_det__id_obligacion_det PRIMARY KEY(id_obligacion_det)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE tes.tobligacion_det OWNER TO postgres;

--tabla tes.tplan_pago

CREATE TABLE tes.tplan_pago (
  id_plan_pago SERIAL, 
  id_obligacion_pago INTEGER NOT NULL, 
  id_plan_pago_fk INTEGER, 
  id_cuenta_bancaria INTEGER, 
  id_comprobante INTEGER, 
  nro_sol_pago VARCHAR(40), 
  nro_cuota INTEGER, 
  nombre_pago VARCHAR(255), 
  tipo_pago VARCHAR(20), 
  tipo VARCHAR(30), 
  fecha_dev DATE, 
  fecha_pag DATE, 
  tipo_cambio NUMERIC(19,0), 
  monto NUMERIC(19,2), 
  descuento_anticipo NUMERIC(19,2), 
  obs_descuentos_anticipo TEXT, 
  monto_no_pagado NUMERIC(19,2), 
  obs_monto_no_pagado TEXT, 
  otros_descuentos NUMERIC(19,2), 
  obs_otros_descuentos TEXT, 
  estado VARCHAR(255), 
  id_estado_wf INTEGER, 
  id_proceso_wf INTEGER, 
  CONSTRAINT pk_tplan_pago__id_plan_pago PRIMARY KEY(id_plan_pago), 
  CONSTRAINT chk_tplan_pago__estado CHECK ((estado)::text = ANY (ARRAY[('borrador'::character varying)::text, ('pendiente'::character varying)::text, ('devengado'::character varying)::text, ('pagado'::character varying)::text])), 
  CONSTRAINT chk_tplan_pago__tipo CHECK ((tipo)::text = ANY ((ARRAY['devengado'::character varying, 'pago'::character varying, 'devengado_pagado'::character varying])::text[])), 
  CONSTRAINT chk_tplan_pago__tipo_pago CHECK ((tipo_pago)::text = ANY ((ARRAY['anticipo'::character varying, 'adelanto'::character varying, 'normal'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE tes.tplan_pago OWNER TO postgres;

--tabla tprorrateo

CREATE TABLE tes.tprorrateo (
  id_prorrateo SERIAL, 
  id_plan_pago INTEGER NOT NULL, 
  id_obligacion_det INTEGER NOT NULL, 
  id_partida_ejecucion_dev INTEGER NOT NULL, 
  id_partida_ejecucion_pag INTEGER NOT NULL, 
  id_transaccion_dev INTEGER, 
  id_transaccion_pag INTEGER, 
  monto_ejecutar_mo INTEGER, 
  monto_ejecutar_mb INTEGER, 
  CONSTRAINT pk_tprorrateo__id_prorrateo PRIMARY KEY(id_prorrateo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE tes.tprorrateo OWNER TO postgres;

/***********************************F-SCP-GSS-TES-45-01/04/2013****************************************/