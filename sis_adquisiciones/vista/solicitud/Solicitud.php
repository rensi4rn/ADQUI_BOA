<?php
/**
*@package pXP
*@file gen-Solicitud.php
*@author  (admin)
*@date 19-02-2013 12:12:51
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Solicitud=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Solicitud.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_solicitud'
			},
			type:'Field',
			form:true 
		},
	       	{
	       		config:{
	       			name:'tipo',
	       			fieldLabel:'Tipo',
	       			allowBlank:false,
	       			emptyText:'Tipo...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    valueField: 'estilo',
	       		    store:['Bien','Servicio']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['Bien','Servicio'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},		
		   {
			config:{
				name: 'id_gestion',
				origen:'GESTION',
	   			tinit:false,
				fieldLabel: 'Gestion',
				gdisplayField:'desc_gestion',//mapea al store del grid
				allowBlank:false,
				anchor: '80%',
				gwidth: 200,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_gestion']);}
			},
			type:'ComboRec',
			filters:{pfiltro:'ges.gestion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
   			config:{
   				name:'id_depto',
	   				origen:'DEPTO',
	   				allowBlank:false,
	   				fieldLabel: 'Depto',
	   				gdisplayField:'desc_depto',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
	   				width:250,
   			        gwidth:200,
	   				baseParams:{estado:'activo',codigo_subsistema:'ADQ'},//parametros adicionales que se le pasan al store
	      			renderer:function (value, p, record){return String.format('{0}', record.data['desc_depto']);}
   			},
   			//type:'TrigguerCombo',
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'depto.nombre',type:'string'},
   		    grid:false,
   			form:true
       	},
		{
			config:{
				name: 'numero',
				fieldLabel: 'numero',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'sol.numero',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		 {
   			config:{
       		    name:'id_funcionario',
   				origen:'FUNCIONARIO',
   				fieldLabel:'Funcionario',
   				allowBlank:false,
                gwidth:200,
   				valueField: 'id_funcionario',
   			    gdisplayField: 'desc_funcionario',
      			renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario']);}
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'funcio.desc_funcionario1',type:'string'},
   		    grid:true,
   			form:true
		 },
      	   {
   			config:{
       		    name:'id_uo',
          		origen:'UO',
   				fieldLabel:'UO',
   				gdisplayField:'desc_uo',//mapea al store del grid
   			    gwidth:200,
   			     renderer:function (value, p, record){return String.format('{0}', record.data['desc_uo']);}
       	     },
   			type:'ComboRec',
   			id_grupo:1,
   			filters:{	
		        pfiltro:'desc_uo',
				type:'string'
			},
   		     grid:true,
   			form:true
   	      },		
		 {
   			config:{
       		    name:'id_moneda',
          		origen:'MONEDA',
   				fieldLabel:'Moneda',
   				gdisplayField:'desc_moneda',//mapea al store del grid
   			    gwidth:200,
   			     renderer:function (value, p, record){return String.format('{0}', record.data['desc_moneda']);}
       	     },
   			type:'ComboRec',
   			id_grupo:1,
   			filters:{	
		        pfiltro:'desc_moneda',
				type:'string'
			},
   		    grid:true,
   			form:true
   	      },
		{
			config:{
				name: 'fecha_soli',
				fieldLabel: 'Fecha Sol.',
				allowBlank: true,
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'sol.fecha_soli',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		}
		,
		{
			config:{
				name: 'id_funcionario_aprobador',
				fieldLabel: 'id_funcionario_aprobador',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'sol.id_funcionario_aprobador',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_apro',
				fieldLabel: 'Fecha Aprobación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'sol.fecha_apro',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'lugar_entrega',
				fieldLabel: 'Lug. Entrega',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextArea',
			filters:{pfiltro:'sol.lugar_entrega',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'justificacion',
				fieldLabel: 'Justificacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'sol.justificacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'posibles_proveedores',
				fieldLabel: 'Proveedores',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'sol.posibles_proveedores',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'comite_calificacion',
				fieldLabel: 'Comite Calificación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'sol.comite_calificacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_categoria_compra',
				fieldLabel: 'Categoria de Compra',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'sol.id_categoria_compra',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'num_tramite',
				fieldLabel: 'Tramite',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'sol.num_tramite',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'extendida',
				fieldLabel: 'extendida',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'sol.extendida',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},{
			config:{
				name: 'estado',
				fieldLabel: 'estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'sol.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
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
			filters:{pfiltro:'sol.estado_reg',type:'string'},
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
			filters:{pfiltro:'sol.fecha_reg',type:'date'},
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
			filters:{pfiltro:'sol.fecha_mod',type:'date'},
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
	
	title:'Solicitud de Compras',
	ActSave:'../../sis_adquisiciones/control/Solicitud/insertarSolicitud',
	ActDel:'../../sis_adquisiciones/control/Solicitud/eliminarSolicitud',
	ActList:'../../sis_adquisiciones/control/Solicitud/listarSolicitud',
	id_store:'id_solicitud',
	fields: [
		{name:'id_solicitud', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_solicitud_ext', type: 'numeric'},
		{name:'presu_revertido', type: 'string'},
		{name:'fecha_apro', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado', type: 'string'},
		{name:'id_funcionario_aprobador', type: 'numeric'},
		{name:'id_moneda', type: 'numeric'},
		{name:'id_gestion', type: 'numeric'},
		{name:'tipo', type: 'string'},
		{name:'num_tramite', type: 'string'},
		{name:'justificacion', type: 'string'},
		{name:'id_depto', type: 'numeric'},
		{name:'lugar_entrega', type: 'string'},
		{name:'extendida', type: 'string'},
		{name:'numero', type: 'string'},
		{name:'posibles_proveedores', type: 'string'},
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'comite_calificacion', type: 'string'},
		{name:'id_categoria_compra', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_estado_wf', type: 'numeric'},
		{name:'fecha_soli', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'id_uo', type: 'string'},
		'desc_funcionario',
		'desc_funcionario_apro',
		'desc_uo',
		'desc_gestion',
		'desc_moneda',
		'desc_depto'
		
	],
	sortInfo:{
		field: 'id_solicitud',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		