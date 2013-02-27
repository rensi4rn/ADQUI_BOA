<?php
/**
 *@package pXP
 *@file gen-ConfigTipoCuenta.php
 *@author  (admin)
 *@date 26-02-2013 19:19:24
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.ConfigTipoCuenta = Ext.extend(Phx.gridInterfaz, {

		constructor : function(config) {
			this.maestro = config.maestro;
			//llama al constructor de la clase padre
			Phx.vista.ConfigTipoCuenta.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			})
		},
		Atributos : [{
			//configuracion del componente
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_cofig_tipo_cuenta'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'nro_base',
				fieldLabel : 'Nro',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'ctc.nro_base',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'tipo_cuenta',
				fieldLabel : 'Tipo',
				allowBlank : false,
				emptyText : 'Tipo...',
				typeAhead : true,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'local',
				gwidth : 100,
				store : ['activo', 'pasivo', 'patrimonio', 'gasto', 'ingreso']
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				type : 'list',
				pfiltro : 'tipo_cuenta',
				options : ['activo', 'pasivo', 'patrimonio', 'gasto', 'ingreso']
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'estado_reg',
				fieldLabel : 'Estado Reg.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'ctc.estado_reg',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_reg',
				fieldLabel : 'Creado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu1.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y H:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'ctc.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y H:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'ctc.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_mod',
				fieldLabel : 'Modificado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu2.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],

		title : 'Config. Tipo Cuenta',
		ActSave : '../../sis_contabilidad/control/ConfigTipoCuenta/insertarConfigTipoCuenta',
		ActDel : '../../sis_contabilidad/control/ConfigTipoCuenta/eliminarConfigTipoCuenta',
		ActList : '../../sis_contabilidad/control/ConfigTipoCuenta/listarConfigTipoCuenta',
		id_store : 'id_cofig_tipo_cuenta',
		fields : [{
			name : 'id_cofig_tipo_cuenta',
			type : 'numeric'
		}, {
			name : 'nro_base',
			type : 'numeric'
		}, {
			name : 'tipo_cuenta',
			type : 'numeric'
		}, {
			name : 'estado_reg',
			type : 'string'
		}, {
			name : 'id_usuario_reg',
			type : 'numeric'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'id_usuario_mod',
			type : 'numeric'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'usr_mod',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_cofig_tipo_cuenta',
			direction : 'ASC'
		},
		bdel : true,
		bsave : true
	})
</script>