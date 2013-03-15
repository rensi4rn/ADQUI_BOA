
INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg",  "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, NULL, E'2013-02-19 00:00:00', E'2013-02-19 05:33:50.545', E'activo',  6, E'ADQ', E'Adquisicones Central', E'ADQ-CEN');

-- FRH


/* Data for the 'param.tgestion' table */

INSERT INTO param.tgestion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_gestion", "gestion", "estado", "id_moneda_base", "id_empresa")
VALUES (1, NULL, E'2013-03-04 20:38:26', E'2013-03-04 20:38:26', E'activo', 105, 2013, NULL, 1, 1);


INSERT INTO param.tdocumento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_documento", "id_subsistema", "codigo", "descripcion", "periodo_gestion", "tipo", "tipo_numeracion", "formato")
VALUES (1, NULL, E'2013-03-04 00:00:00', E'2013-03-04 20:32:58.442', E'activo', 2, 6, E'SOLB', E'Solicitud de bien', E'gestion', E'', E'depto', NULL);

INSERT INTO adq.tsolicitud ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_solicitud", "id_funcionario", "id_uo", "id_solicitud_ext", "id_categoria_compra", "id_moneda", "id_proceso_macro", "id_gestion", "id_funcionario_aprobador", "id_depto", "id_estado_wf", "id_proceso_wf", "extendida", "tipo", "estado", "fecha_soli", "fecha_apro", "lugar_entrega", "justificacion", "posibles_proveedores", "comite_calificacion", "presu_revertido", "num_tramite")
VALUES (1, NULL, E'2013-03-05 09:10:35', E'2013-03-05 09:10:35', E'activo', 1, 1, 1, 1, 1, 1, 1, 105, 1, 1, 1, 1, NULL, E'1', E'activo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
