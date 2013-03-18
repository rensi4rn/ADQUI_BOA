<?php
/**
*@package pXP
*@file gen-DocumentoSol.php
*@author  (admin)
*@date 08-02-2013 19:01:00
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DocumentoSol=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DocumentoSol.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_documento_sol'
			},
			type:'Field',
			form:true 
		},
		{
            config: {
                name: 'id_solicitud',
                fieldLabel: 'Solicitud de compra',
                typeAhead: false,
                forceSelection: false,
                allowBlank: false,
                emptyText: 'Solicitud de compra...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_adquisiciones/control/Solicitud/listarSolicitud',
                    id: 'id_solicitud',
                    root: 'datos',
                    sortInfo: {
                        field: 'id_solicitud',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_solicitud', 'tipo', 'desc_proceso_macro', 'desc_gestion', 'desc_depto', 'desc_funcionario'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'depto.nombre'}
                }),
                valueField: 'id_solicitud',
                displayField: 'desc_proceso_macro',
                gdisplayField: 'desc_proceso_macro',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                anchor: '80%',
                minChars: 2,
                gwidth: 200,
                renderer: function(value, p, record) {
                    return String.format('{0}', record.data['desc_proceso_macro']+'-'+
                                                record.data['desc_gestion']+'-'+
                                                record.data['desc_depto']);
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_proceso_macro}-{desc_gestion}-{desc_depto}</p>Funcionario: <strong>{desc_funcionario}</strong> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'depto.nombre',
                type: 'string'
            },
            grid: true,
            form: true
        },
		{
			config: {
				name: 'id_categoria_compra',
				fieldLabel: 'Categoria',
				typeAhead: false,
				forceSelection: false,
				allowBlank: false,
				emptyText: 'Categorias...',
				store: new Ext.data.JsonStore({
					url: '../../sis_adquisiciones/control/CategoriaCompra/listarCategoriaCompra',
					id: 'id_categoria_compra',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_categoria_compra', 'codigo', 'nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'catcomp.codigo#catcomp.nombre'}
				}),
				valueField: 'id_categoria_compra',
				displayField: 'nombre',
				gdisplayField: 'desc_categoria_compra',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '80%',
				minChars: 2,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_categoria_compra']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p><p>{codigo}</p> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'codigo#nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'nombre_doc',
				fieldLabel: 'Nombre documento',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'docsol.nombre_doc',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_arch_doc',
				fieldLabel: 'Ruta archivo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength:300
			},
			type:'TextField',
			filters:{pfiltro:'docsol.nombre_arch_doc',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_tipo_doc',
				fieldLabel: 'Nombre tipo documento',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'docsol.nombre_tipo_doc',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'chequeado',
				fieldLabel: 'Chequeado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
			type:'Checkbox',
			filters:{pfiltro:'docsol.chequeado',type:'string'},
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
			filters:{pfiltro:'docsol.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
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
			grid:false,
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
			filters:{pfiltro:'docsol.fecha_reg',type:'date'},
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
			grid:false,
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
			filters:{pfiltro:'docsol.fecha_mod',type:'date'},
			id_grupo:1,
			grid:false,
			form:false
		}
	],
	
	title:'Documento de Solicitud',
	ActSave:'../../sis_adquisiciones/control/DocumentoSol/insertarDocumentoSol',
	ActDel:'../../sis_adquisiciones/control/DocumentoSol/eliminarDocumentoSol',
	ActList:'../../sis_adquisiciones/control/DocumentoSol/listarDocumentoSol',
	id_store:'id_documento_sol',
	fields: [
		{name:'id_documento_sol', type: 'numeric'},
		{name:'id_solicitud', type: 'numeric'},
		{name:'id_categoria_compra', type: 'numeric'},
		{name:'nombre_doc', type: 'string'},
		{name:'nombre_arch_doc', type: 'string'},
		{name:'nombre_tipo_doc', type: 'string'},
		{name:'chequeado', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_categoria_compra', type: 'string'},
		{name:'desc_gestion', type: 'string'},
		{name:'desc_depto', type: 'string'},
		{name:'desc_proceso_macro', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_documento_sol',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		