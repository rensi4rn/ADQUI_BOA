<?php
/**
*@package pXP
*@file Cuenta.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-02-2013 15:04:03
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Cuenta=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Cuenta.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_cuenta'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'vigente',
				fieldLabel: 'Vigente',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'cta.vigente',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_cuenta',
				fieldLabel: 'Nombre Cuenta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'cta.nombre_cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'sw_oec',
				fieldLabel: 'Sw Oec',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.sw_oec',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'sw_auxiliar',
				fieldLabel: 'Sw Auxiliar',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.sw_auxiliar',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nivel_cuenta',
				fieldLabel: 'Nivel Cuenta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.nivel_cuenta',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_cuenta',
				fieldLabel: 'Tipo Cuenta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'cta.tipo_cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},/*
		{
			config:{
				name: 'id_empresa',
				fieldLabel: 'Id Empresa',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_empresa',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
		{
 			config:{
 				name:'id_empresa',
 				fieldLabel:'Empresa',
 				allowBlank:false,
 				emptyText:'Empresa...',
 				store: new Ext.data.JsonStore({

			url: '../../sis_parametros/control/Empresa/listarEmpresa',
			id: 'id_empresa',
			root: 'datos',
			sortInfo:{
				field: 'id_empresa',
				direction: 'ASC'
			},
			totalProperty: 'total',
			fields: ['id_empresa','nombre'],
			// turn on remote sorting
			remoteSort: true,
			baseParams:{par_filtro:'nombre'}
		}),
 				valueField: 'id_empresa',
 				displayField: 'nombre',
 				gdisplayField: 'nombre',
 				hiddenName: 'id_empresa',
 				forceSelection:true,
 				typeAhead: true,
  			triggerAction: 'all',
  			lazyRender:true,
 				mode:'remote',
 				pageSize:10,
 				queryDelay:1000,
 				width:250,
 				minChars:2,
 			
 				renderer:function(value, p, record){return String.format('{0}', record.data['nombre']);}

 			},
 			type:'ComboBox',
 			id_grupo:0,
 			filters:{   pfiltro:'nombre',
 						type:'string'
 					},
 			grid:true,
 			form:true
	 },/*
		{
			config:{
				name: 'id_cuenta_padre',
				fieldLabel: 'Id Cuenta Padre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_cuenta_padre',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
		{
   			config:{
   				name:'id_cuenta_padre',
   				fieldLabel:'Cuenta Padre',
   				allowBlank:true,
   				emptyText:'Cuenta Padre...',
   				store: new Ext.data.JsonStore({
									url: '../../sis_contabilidad/control/Cuenta/listarCuenta',
									id: 'id_cuenta_padre',
									root: 'datos',
									sortInfo:{
										field: 'id_cuenta',
										direction: 'ASC'
									},
									totalProperty: 'total',
									fields: ['id_cuenta_padre','nombre_cuenta'],
									// turn on remote sorting
									remoteSort: true,
									baseParams:{par_filtro:'nombre_cuenta'}
							}),
   				valueField: 'id_cuenta_padre',
   				displayField: 'nombre_cuenta',
   				gdisplayField: 'nombre_cuenta',
   				hiddenName: 'id_cuenta_padre',
   				forceSelection:false,
   				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				minChars:2,
   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_cuenta_padre']);}

   			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{   pfiltro:'ctap.nombre_cuenta',
   						type:'string'
   					},
   			grid:true,
   			form:true
  },
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'cta.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_auxiliar_dif',
				fieldLabel: 'Id Auxiliar Dif',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_auxiliar_dif',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_plantilla',
				fieldLabel: 'Tipo Plantilla',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'cta.tipo_plantilla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'desc_cuenta',
				fieldLabel: 'Desc Cuenta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'cta.desc_cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'sw_sigma',
				fieldLabel: 'Sw Sigma',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'cta.sw_sigma',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cuenta_sigma',
				fieldLabel: 'Cuenta Sigma',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'cta.cuenta_sigma',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_cuenta_pat',
				fieldLabel: 'Tipo Cuenta Pat',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'cta.tipo_cuenta_pat',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Obs',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'cta.obs',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'sw_sistema_actualizacion',
				fieldLabel: 'Sw Sistema Actualizacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'cta.sw_sistema_actualizacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_cuenta_actualizacion',
				fieldLabel: 'Id Cuenta Actualizacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_cuenta_actualizacion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_parametro',
				fieldLabel: 'Id Parametro',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_parametro',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_auxliar_actualizacion',
				fieldLabel: 'Id Auxliar Actualizacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_auxliar_actualizacion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'plantilla',
				fieldLabel: 'Plantilla',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'cta.plantilla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nro_cuenta',
				fieldLabel: 'Nro Cuenta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'cta.nro_cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_moneda',
				fieldLabel: 'Id Moneda',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_moneda',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cuenta_flujo_sigma',
				fieldLabel: 'Cuenta Flujo Sigma',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'cta.cuenta_flujo_sigma',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_cuenta_dif',
				fieldLabel: 'Id Cuenta Dif',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_cuenta_dif',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_cuenta_sigma',
				fieldLabel: 'Id Cuenta Sigma',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_cuenta_sigma',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'sw_transaccional',
				fieldLabel: 'Sw Transaccional',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'cta.sw_transaccional',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_gestion',
				fieldLabel: 'Id Gestion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cta.id_gestion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'cta.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cta.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cta.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Cuenta',
	ActSave:'../../sis_contabilidad/control/Cuenta/insertarCuenta',
	ActDel:'../../sis_contabilidad/control/Cuenta/eliminarCuenta',
	ActList:'../../sis_contabilidad/control/Cuenta/listarCuenta',
	id_store:'id_cuenta',
	fields: [
		{name:'id_cuenta', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'vigente', type: 'string'},
		{name:'nombre_cuenta', type: 'string'},
		{name:'sw_oec', type: 'numeric'},
		{name:'sw_auxiliar', type: 'numeric'},
		{name:'nivel_cuenta', type: 'numeric'},
		{name:'tipo_cuenta', type: 'string'},
		{name:'id_empresa', type: 'numeric'},
		{name:'id_cuenta_padre', type: 'numeric'},
		{name:'nombre_cuenta_padre', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'id_auxiliar_dif', type: 'numeric'},
		{name:'tipo_plantilla', type: 'string'},
		{name:'desc_cuenta', type: 'string'},
		{name:'sw_sigma', type: 'string'},
		{name:'cuenta_sigma', type: 'string'},
		{name:'tipo_cuenta_pat', type: 'string'},
		{name:'obs', type: 'string'},
		{name:'sw_sistema_actualizacion', type: 'string'},
		{name:'id_cuenta_actualizacion', type: 'numeric'},
		{name:'id_parametro', type: 'numeric'},
		{name:'id_auxliar_actualizacion', type: 'numeric'},
		{name:'plantilla', type: 'string'},
		{name:'nro_cuenta', type: 'string'},
		{name:'id_moneda', type: 'numeric'},
		{name:'cuenta_flujo_sigma', type: 'string'},
		{name:'id_cuenta_dif', type: 'numeric'},
		{name:'id_cuenta_sigma', type: 'numeric'},
		{name:'sw_transaccional', type: 'string'},
		{name:'id_gestion', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_cuenta',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		