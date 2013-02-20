/***********************************I-SCP-RAC-ADQ-1-01/01/2013****************************************/
CREATE TABLE adq.tcategoria_compra(
    id_categoria_compra SERIAL NOT NULL,
    codigo varchar(15),
    nombre varchar(255),
    min numeric(19, 0),
    max numeric(19, 0),
    obs varchar(255),
    PRIMARY KEY (id_categoria_compra))INHERITS (pxp.tbase);

   
CREATE TABLE adq.tdocumento_sol(
    id_documento_sol SERIAL NOT NULL,
    id_solicitud int4,
    id_categoria_compra int4 NOT NULL,
    nombre_tipo_doc varchar(255),
    nombre_doc varchar(255),
    nombre_arch_doc varchar(150),
    chequeado varchar(5),
    PRIMARY KEY (id_documento_sol))INHERITS (pxp.tbase);   

CREATE TABLE adq.tsolicitud (
  id_solicitud              SERIAL NOT NULL, 
  id_funcionario           int4 NOT NULL, 
  id_solicitud_ext         int4 NOT NULL, 
  id_categoria_compra      int4 NOT NULL, 
  id_moneda                int4 NOT NULL, 
  id_gestion               int4 NOT NULL, 
  id_funcionario_aprobador int4 NOT NULL, 
  id_depto                 int4 NOT NULL, 
  id_estado                int4, 
  numero                   varchar(50), 
  extendida                varchar(2), 
  tipo                     varchar(50), 
  estado                   varchar(50), 
  fecha_soli               date, 
  fecha_apro               date, 
  lugar_entrega            varchar(255), 
  justificacion            text, 
  posibles_proveedores     text, 
  comite_calificacion      text, 
  codigo_proceso           varchar(50), 
  num_cotizacion           varchar(30), 
  num_convocatoria         varchar(30), 
  presu_revertido          varchar(2), 
  obs_proceso              varchar(500), 
  facha_ini_proc           date, 
  num_tramite              varchar(200), 
  PRIMARY KEY (id_solicitud)) INHERITS (pxp.tbase);

CREATE TABLE adq.tsolicitud_det(
    id_solicitud_det SERIAL NOT NULL,
    id_solicitud int4 NOT NULL,
    id_centro_costo int4 NOT NULL,
    id_partida int4 NOT NULL,
    id_cuenta int4 NOT NULL,
    id_auxiliar int4 NOT NULL,
    id_concepto_gasto int4 NOT NULL,
    id_partida_ejecucion int4,
    id_orden_trabajo int4,
    numero varchar(30),
    precio_unitario numeric(19, 2),
    cantidad int4,
    precio_total numeric(19, 2),
    precio_ga numeric(19, 2),
    precio_sg numeric(19, 2),
    precio_presupuestado_mb numeric(19, 2),
    descripcion text,
    PRIMARY KEY (id_solicitud_det))INHERITS (pxp.tbase);
    
 CREATE TABLE adq.tcotizacion(
    id_cotizacion SERIAL NOT NULL,
    id_solicitud int4 NOT NULL,
    id_proveedor int4 NOT NULL,
    id_moneda int4 NOT NULL,
    numero_cot varchar(30),
    numero_oc int4,
    estado varchar(255),
    fecha_coti date,
    fecha_adju int4,
    obs text,
    fecha_venc date,
    lugar_entrega varchar(500),
    fecha_entrega date,
    tipo_entrega varchar(255),
    precio_total numeric(19, 2),
    porc_anticipo numeric(2, 2),
    porc_retgar numeric(2, 2),
    nro_contrato varchar(50),
    PRIMARY KEY (id_cotizacion))INHERITS (pxp.tbase);
    
   
CREATE TABLE adq.tplan_pago(
    id_plan_pago SERIAL NOT NULL,
    id_cotizacion int4 NOT NULL,
    id_moneda int4 NOT NULL,
    id_plan_pago_dev int4,
    id_plantilla int4,
    id_gestion int4,
    id_comprobante int4,
    numero varchar(30),
    cuota int4,
    monto numeric(19, 2),
    estado varchar(255),
    tipo varchar(30),
    fecha_dev date,
    fecha_pag date,
    boleta_garantia varchar(255),
    obs_descuentos text,
    descuento_anticipo numeric(19, 2),
    PRIMARY KEY (id_plan_pago))INHERITS (pxp.tbase);


CREATE TABLE adq.tcotizacion_det(
    id_cotizacion_det SERIAL NOT NULL,
    id_cotizacion int4 NOT NULL,
    id_solicitud_det int4 NOT NULL,
    precio_unitario numeric(19, 2),
    cantidad_coti numeric(19, 0),
    cantidad_aduj numeric(19, 0),
    obs varchar(500),
    PRIMARY KEY (id_cotizacion_det))INHERITS (pxp.tbase);
    
     
CREATE TABLE adq.tplan_pago_det(
    id_plan_pago_det SERIAL NOT NULL,
    id_plan_pago int4 NOT NULL,
    id_cotizacion_det int4 NOT NULL,
    id_partida_ejecucion int4,
    id_partida_ejecucion_pago int4,
    id_transaccion int4,
    monto_ejecutar_mc numeric(19, 2),
    monto_ejecutar_mb numeric(19, 2),
    PRIMARY KEY (id_plan_pago_det))INHERITS (pxp.tbase);
    
    
     

/***********************************F-SCP-RAC-ADQ-1-01/01/2013****************************************/
