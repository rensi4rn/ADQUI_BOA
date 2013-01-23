<?php
/**
*@package pXP
*@file gen-PersonaComunicacion.php
*@author  (admin)
*@date 08-01-2013 19:45:03
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PersonaComunicacion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
		
		this.bloquearMenus();
    	//llama al constructor de la clase padre
		Phx.vista.PersonaComunicacion.superclass.constructor.call(this,config);
		this.init();
		this.getComponente('id_tipo_comunicacion').on('select',function (combo, record, id) {
			//console.log(record.data.id_tiipo_comunicacion);
			if (record.data.id_tiipo_comunicacion == '1') {
				this.getComponente('valor').vtype = 'alphanum';
			} else {
				this.getComponente('valor').vtype = 'email';
			}
			
		}, this);
		//this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_persona_comunicacion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_persona',
				inputType:'hidden'
				
			},
			type:'Field',
			form:true
		},
		{
			config:{
				
				name: 'id_tipo_comunicacion',
				fieldLabel: 'Tipo Com',
				allowBlank: false,
				emptyText:'Tipo Comunicacion...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_directorio/control/TipoComunicacion/listarTipoComunicacion',
					id: 'id_tiipo_comunicacion',
					root: 'datos',
					sortInfo:{
						field: 'id_tiipo_comunicacion',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tiipo_comunicacion','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tiipo_comunicacion',
				displayField: 'nombre',
				gdisplayField:'nombre',
				hiddenName: 'id_tipo_comunicacion',
				groupable:true,//rpueba rac
				forceSelection:true,
				typeAhead: true,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,				
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'tic.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		
		{
			config:{
				name: 'valor',
				fieldLabel: 'valor',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255,
				vtype:'email'
			},
			type:'TextField',
			
			filters:{pfiltro:'percom.valor',type:'string'},
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
			filters:{pfiltro:'percom.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'percom.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'percom.fecha_mod',type:'date'},
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
	
	title:'Persona Comunicacion',
	ActSave:'../../sis_directorio/control/PersonaComunicacion/insertarPersonaComunicacion',
	ActDel:'../../sis_directorio/control/PersonaComunicacion/eliminarPersonaComunicacion',
	ActList:'../../sis_directorio/control/PersonaComunicacion/listarPersonaComunicacion',
	id_store:'id_persona_comunicacion',
	fields: [
		{name:'id_persona_comunicacion', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_tipo_comunicacion', type: 'numeric'},
		{name:'valor', type: 'string'},
		{name:'id_persona', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'nombre'
		
	],
	sortInfo:{
		field: 'id_persona_comunicacion',
		direction: 'ASC'
	},
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={id_persona:this.maestro.id_persona};
		this.load({params:{start:0, limit:50}});			
	},
	loadValoresIniciales:function()
	{
		Phx.vista.PersonaComunicacion.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_persona').setValue(this.maestro.id_persona);		
	},	
	bdel:true,
	bsave:true
	}
)
</script>
		
		