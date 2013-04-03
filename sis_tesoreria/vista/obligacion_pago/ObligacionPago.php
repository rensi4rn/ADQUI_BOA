<?php
/**
*@package pXP
*@file ObligacionPago.php
*@author  Gonzalo Sarmiento Sejas
*@date 02-04-2013 16:01:32
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ObligacionPago=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ObligacionPago.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_obligacion_pago'
			},
			type:'Field',
			form:true 
		},
		{
		config:{
				name: 'estado',
				fieldLabel: 'estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'obpg.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'tipo_obligacion',
				fieldLabel: 'Tipo Obligacion',
				allowBlank: false,
				anchor: '80%',
				emptyText:'Tipo Obligacion',
				store: ['adquisiciones','caja_chica','viaticos','fondo_en_avance'],
				valueField: 'tipo_obligacion',
				displayField: 'tipo_obligacion',
				forceSelection: true,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'local',
				wisth: 250,
				renderer:function(value, p, record){return String.format('{0}', record.data['tipo_obligacion']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'obpg.tipo_obligacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},		
		{
			config: {
				name: 'id_moneda',
				fieldLabel: 'Moneda',
				anchor: '80%',
				tinit: true,
				allowBlank: false,
				origen: 'MONEDA',
				gdisplayField: 'moneda',
				gwidth: 100,
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'mn.moneda',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_proceso_macro',
				fieldLabel: 'Proceso',
				typeAhead: false,
				forceSelection: false,
				hiddenName: 'id_proceso_macro',
				allowBlank: false,
				anchor:'80%',
				emptyText: 'Lista de Procesos...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/ProcesoMacro/listarProcesoMacro',
					id: 'id_proceso_macro',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_proceso_macro', 'nombre', 'codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'promac.nombre#promac.codigo',codigo_subsistema:'ADQ'}
				}),
				valueField: 'id_proceso_macro',
				displayField: 'nombre',
				gdisplayField: 'desc_proceso_macro',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				listWidth:280,
				minChars: 2,
				gwidth: 170,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_proceso_macro']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'pm.nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},		
		{
			config:{
				name: 'id_depto',
				fieldLabel: 'Depto',
				allowBlank: true,
				anchor: '80%',
				origen: 'DEPTO',
				tinit: true,
				gdisplayField:'nombre_depto',
				gwidth: 100
			},
			type:'ComboRec',
			filters:{pfiltro:'dep.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},	
		{
			config: {
				name: 'id_proveedor',
				fieldLabel: 'Proveedor',
				anchor: '80%',
				tinit: true,
				allowBlank: false,
				origen: 'PROVEEDOR',
				gdisplayField: 'desc_proveedor',
				gwidth: 100,
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'pv.desc_proveedor',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'id_funcionario',
				fieldLabel: 'Funcionario',
				tinit: true,
				allowBlank: true,
				anchor: '80%',
				origen: 'FUNCIONARIO',				
				gdisplayField: 'desc_funcionario1',
				gwidth: 100
			},
			type:'ComboRec',
			filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
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
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'obpg.obs',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_subsistema',
				fieldLabel: 'Subsistema',
				anchor: '80%',
				tinit: true,
				allowBlank: true,
				origen: 'SUBSISTEMA',
				gdisplayField: 'nombre_subsistema',
				gwidth: 180,
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'ss.nombre',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'num_tramite',
				fieldLabel: 'Num. Tramite',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'obpg.num_tramite',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'porc_anticipo',
				fieldLabel: 'Porc. Anticipo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:131074
			},
			type:'NumberField',
			filters:{pfiltro:'obpg.porc_anticipo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'porc_retgar',
				fieldLabel: 'Porc. Retgar',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:131074
			},
			type:'NumberField',
			filters:{pfiltro:'obpg.porc_retgar',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_obligacion_pago'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_estado_wf'
			},
			type:'Field',
			form:true
		},		
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'estado_reg'
			},
			type:'Field',
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
			filters:{pfiltro:'obpg.fecha_reg',type:'date'},
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
			filters:{pfiltro:'obpg.fecha_mod',type:'date'},
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
	
	title:'Obligaciones de Pago',
	ActSave:'../../sis_tesoreria/control/ObligacionPago/insertarObligacionPago',
	ActDel:'../../sis_tesoreria/control/ObligacionPago/eliminarObligacionPago',
	ActList:'../../sis_tesoreria/control/ObligacionPago/listarObligacionPago',
	id_store:'id_obligacion_pago',
	fields: [
		{name:'id_obligacion_pago', type: 'numeric'},
		{name:'id_proveedor', type: 'numeric'},
		{name:'desc_proveedor', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'tipo_obligacion', type: 'string'},
		{name:'id_moneda', type: 'numeric'},
		{name:'moneda', type: 'string'},
		{name:'obs', type: 'string'},
		{name:'porc_retgar', type: 'numeric'},
		{name:'id_subsistema', type: 'numeric'},
		{name:'nombre_subsistema', type: 'string'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'desc_funcionario1', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'porc_anticipo', type: 'numeric'},
		{name:'id_estado_wf', type: 'numeric'},
		{name:'id_depto', type: 'numeric'},
		{name:'nombre_depto', type: 'string'},
		{name:'num_tramite', type: 'string'},
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	south:
          { 
          url:'../../../sis_tesoreria/vista/obligacion_det/ObligacionDet.php',
          title:'Detalle', 
          height:'50%',
          cls:'ObligacionDet'
         },
         
	sortInfo:{
		field: 'id_obligacion_pago',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		