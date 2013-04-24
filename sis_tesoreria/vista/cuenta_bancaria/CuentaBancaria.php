<?php
/**
*@package pXP
*@file CuentaBancaria.php
*@author  Gonzalo Sarmiento Sejas
*@date 24-04-2013 15:19:30
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CuentaBancaria=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CuentaBancaria.superclass.constructor.call(this,config);
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
					name: 'id_cuenta_bancaria'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_institucion',
				fieldLabel: 'Institucion',
				anchor: '80%',
				tinit: true,
				allowBlank: false,
				origen: 'INSTITUCION',
				gdisplayField: 'nombre_institucion',
				gwidth: 200,
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_institucion']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'inst.nombre',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name:'id_cuenta',
				fieldLabel:'Cuenta',
				anchor: '80%',
				allowBlank:false,
				emptyText:'Cuenta...',
				store: new Ext.data.JsonStore({

				url: '../../sis_contabilidad/control/Cuenta/listarCuenta',
				id: 'id_cuenta',
				root: 'datos',
				sortInfo:{
				field: 'nombre_cuenta',
				direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_cuenta','nro_cuenta','nombre_cuenta','desc_cuenta'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'nro_cuenta#nombre_cuenta'}
				}),
				valueField: 'id_cuenta',
				displayField: 'nombre_cuenta',
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_cuenta}</p><p>NumeroCta:{nro_cuenta}</p> </div></tpl>',
				gdisplayField: 'nombre_cuenta',
				hiddenName: 'id_cuenta',
				forceSelection:true,
				typeAhead: true,
    triggerAction: 'all',
    lazyRender:true,
				mode:'remote',
				pageSize:10,
				queryDelay:1000,
				width:250,
				minChars:2,
			
				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_cuenta']);}

			},
			type:'ComboBox',
			id_grupo:0,
			filters:{   pfiltro:'cta.nombre_cuenta',
						type:'string'
					},
			grid:true,
			form:true
		},		
		{
			config:{
				name:'id_auxiliar',
				fieldLabel:'Auxiliar',
				allowBlank:true,
				emptyText:'Auxiliar...',
				anchor: '80%',
				store: new Ext.data.JsonStore({

				url: '../../sis_contabilidad/control/Auxiliar/listarAuxiliar',
				id: 'id_auxiliar',
				root: 'datos',
				sortInfo:{
				field: 'nombre',
				direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['id_auxiliar','nombre','codigo_auxiliar','nombre_auxiliar'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'codigo_auxiliar#nombre_auxiliar'}
				}),
				valueField: 'id_auxiliar',
				displayField: 'nombre_auxiliar',
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Codigo:{codigo_auxiliar}</p><p>{nombre_auxiliar}</p> </div></tpl>',
				gdisplayField: 'nombre_auxiliar',
				hiddenName: 'id_auxiliar',
				forceSelection:true,
				typeAhead: true,
    triggerAction: 'all',
    lazyRender:true,
				mode:'remote',
				pageSize:10,
				queryDelay:1000,
				width:250,
				minChars:2,
			
				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_auxiliar']);}

			},
			type:'ComboBox',
			id_grupo:0,
			filters:{   pfiltro:'aux.nombre_auxiliar',
						type:'string'
					},
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
				maxLength:5
			},
			type:'TextField',
			filters:{pfiltro:'ctaban.nro_cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_alta',
				fieldLabel: 'Fecha Alta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ctaban.fecha_alta',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_baja',
				fieldLabel: 'Fecha Baja',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ctaban.fecha_baja',type:'date'},
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
			filters:{pfiltro:'ctaban.estado_reg',type:'string'},
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
			filters:{pfiltro:'ctaban.fecha_reg',type:'date'},
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
			filters:{pfiltro:'ctaban.fecha_mod',type:'date'},
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
	
	title:'Cuenta Bancaria',
	ActSave:'../../sis_tesoreria/control/CuentaBancaria/insertarCuentaBancaria',
	ActDel:'../../sis_tesoreria/control/CuentaBancaria/eliminarCuentaBancaria',
	ActList:'../../sis_tesoreria/control/CuentaBancaria/listarCuentaBancaria',
	id_store:'id_cuenta_bancaria',
	fields: [
		{name:'id_cuenta_bancaria', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_cuenta', type: 'numeric'},
		{name:'nombre_cuenta', type: 'string'},
		{name:'fecha_baja', type: 'date',dateFormat:'Y-m-d'},
		{name:'nro_cuenta', type: 'string'},
		{name:'fecha_alta', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_auxiliar', type: 'numeric'},
		{name:'nombre_auxiliar', type: 'string'},
		{name:'id_institucion', type: 'numeric'},
		{name:'nombre_institucion', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_cuenta_bancaria',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,	
	south:{	   
        url:'../../../sis_tesoreria/vista/chequera/Chequera.php',
        title:'Chequeras', 
        height : '50%',
        cls:'Chequera'}
	}	
)
</script>
		
		