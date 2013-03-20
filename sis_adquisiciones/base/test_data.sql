------------------------------
--               APROBADORES (EN PARAMETROS)
--------------------------



/* Data for the 'param.taprobador' table  (Records 1 - 3) */

INSERT INTO param.taprobador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_subsistema", "id_centro_costo", "monto_min", "monto_max", "fecha_ini", "fecha_fin", "id_uo", "obs", "id_ep")
VALUES (1, NULL, E'2013-03-20 13:40:10.761', NULL, E'activo', 2, 6, NULL, '0', NULL, E'2013-01-01', NULL, 2, E'', NULL);

INSERT INTO param.taprobador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_subsistema", "id_centro_costo", "monto_min", "monto_max", "fecha_ini", "fecha_fin", "id_uo", "obs", "id_ep")
VALUES (1, NULL, E'2013-03-20 13:41:13.113', NULL, E'activo', 3, 6, NULL, '0', NULL, E'2012-11-01', NULL, 7, E'', NULL);

INSERT INTO param.taprobador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_subsistema", "id_centro_costo", "monto_min", "monto_max", "fecha_ini", "fecha_fin", "id_uo", "obs", "id_ep")
VALUES (1, NULL, E'2013-03-20 13:41:21.555', NULL, E'activo', 3, 6, NULL, '0', NULL, E'2012-11-01', NULL, 9, E'', NULL);


---------------------------------------------------
-- DEPTOS (EN PARAMETROS)
------------------------------------------------

/* Data for the 'param.tdepto' table  (Records 1 - 2) */

INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, NULL, E'2013-03-20 00:00:00', E'2013-03-20 14:17:22.287', E'activo', 6, E'ADQ', E'Adquisiciones  Central', E'');

INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, NULL, E'2013-03-20 00:00:00', E'2013-03-20 14:17:45.392', E'activo', 6, E'ADQLP', E'Departamento de Adquisiciones La Paz', E'ADQLP');

/* Data for the 'param.tdepto_usuario' table  (Records 1 - 2) */

INSERT INTO param.tdepto_usuario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "id_usuario", "funcion", "cargo")
VALUES (1, NULL, E'2013-03-20 14:17:55.046', NULL, E'activo', 2, 1, NULL, E'');

INSERT INTO param.tdepto_usuario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "id_usuario", "funcion", "cargo")
VALUES (1, NULL, E'2013-03-20 14:18:01.481', NULL, E'activo', 1, 1, NULL, E'');
