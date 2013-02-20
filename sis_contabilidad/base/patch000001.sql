/***********************************I-SCP-RAC-CONTA-1-04/02/2013****************************************/

    
     

/***********************************F-SCP-RAC-CONTA-1-04/02/2013****************************************/

/***********************************I-SCP-GSS-CONTA-48-20/02/2013****************************************/

--tabla conta.tcuenta

CREATE TABLE conta.tcuenta (
  id_cuenta SERIAL NOT NULL, 
  id_empresa INTEGER NOT NULL, 
  id_parametro INTEGER, 
  id_cuenta_padre INTEGER, 
  nro_cuenta VARCHAR(20), 
  id_gestion INTEGER, 
  id_moneda INTEGER, 
  nombre_cuenta VARCHAR(100), 
  desc_cuenta VARCHAR(500), 
  nivel_cuenta INTEGER, 
  tipo_cuenta VARCHAR(30), 
  sw_transaccional VARCHAR(2), 
  plantilla VARCHAR(255), 
  tipo_plantilla VARCHAR(100), 
  obs VARCHAR(255), 
  vigente VARCHAR(2), 
  sw_oec INTEGER, 
  sw_auxiliar INTEGER, 
  descripcion VARCHAR(500), 
  tipo_cuenta_pat VARCHAR(20), 
  cuenta_sigma VARCHAR(100), 
  sw_sigma VARCHAR(2), 
  id_cuenta_actualizacion INTEGER, 
  id_auxliar_actualizacion INTEGER, 
  sw_sistema_actualizacion VARCHAR(2), 
  id_cuenta_dif INTEGER, 
  id_auxiliar_dif INTEGER, 
  id_cuenta_sigma INTEGER, 
  cuenta_flujo_sigma VARCHAR(50), 
  CONSTRAINT pk_tcuenta__id_cuenta PRIMARY KEY(id_cuenta),
  CONSTRAINT chk_tcuenta__tipo_cuenta CHECK (((tipo_cuenta)::text = ANY ((ARRAY['activo'::character varying, 'pasivo'::character varying,'patrimonio'::character varying, 'ingreso'::character varying, 'gasto'::character varying])::text[]))),
  CONSTRAINT chk_tcuenta__tipo_cuenta_pat CHECK ((tipo_cuenta_pat)::text = ANY ((ARRAY['capital'::character varying, 'reserva'::character varying])::text[]))
) INHERITS (pxp.tbase)
WITHOUT OIDS;
    
ALTER TABLE conta.tcuenta OWNER TO postgres;  

--tabla conta.tauxiliar

CREATE TABLE conta.tauxiliar (
  id_auxiliar SERIAL NOT NULL, 
  id_empresa INTEGER NOT NULL, 
  codigo_auxiliar VARCHAR(15), 
  nombre_auxiliar VARCHAR(300), 
  CONSTRAINT pk_tauxiliar__id_auxiliar PRIMARY KEY(id_auxiliar)
) INHERITS (pxp.tbase)
WITHOUT OIDS; 

ALTER TABLE conta.tauxiliar OWNER TO postgres;

--tabla conta.tauxiliar

CREATE TABLE conta.torden_trabajo (
  id_orden_trabajo SERIAL NOT NULL, 
  desc_orden VARCHAR(100), 
  motivo_orden VARCHAR(500), 
  fecha_inicio DATE, 
  fecha_final DATE, 
  CONSTRAINT pk_torden_trabajo__id_orden_trabajo PRIMARY KEY(id_orden_trabajo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE conta.tauxiliar OWNER TO postgres;

/***********************************F-SCP-GSS-CONTA-48-20/02/2013****************************************/
