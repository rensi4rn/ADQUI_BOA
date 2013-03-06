<?php
/**
*@package pXP
*@file Proveedor.php
*@author  Gonzalo Sarmiento Sejas
*@date 01-03-2013 10:44:58
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Proveedor=Ext.extend(Phx.gridInterfaz,{

	register:'',
	
	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
  this.initButtons=[this.cmbProveedor];  	
  Phx.vista.Proveedor.superclass.constructor.call(this,config);
		this.init();
  
		//this.load({params:{tipo:this.cmbProveedor.getValue(),start:0, limit:50}});
		this.cmbProveedor.on('select',this.capturaFiltros,this);
		this.iniciarEventos();
	},
	
	capturaFiltros:function(combo, record, index){
		this.store.baseParams={tipo:this.cmbProveedor.getValue()};
		this.load({params:
			{start:0,
				limit:50}
				});
	},
	agregarArgsExtraSubmit: function(){
		//Inicializa el objeto de los argumentos extra
		this.argumentExtraSubmit={};
		this.argumentExtraSubmit.register=this.register;
		
	},		
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proveedor'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:25,
				typeAhead:true,
				triggerAction:'all',
				mode:'local',
				store:['persona natural','persona juridica']
			},
			valorInicial:'',
			type:'ComboBox',
			filters:{pfiltro:'provee.tipo',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},				
	  {
	   		config:{
	   				name:'id_persona',
	   				fieldLabel: 'Persona',
	   				anchor: '100%',
	   				tinit:true,
	   				allowBlank:true,
	   				origen:'PERSONA',
	   				gdisplayField:'nombre_completo1',
	   			    gwidth:200,	
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['nombre_completo1']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'person.nombre_completo1',type:'string'},
   		 grid:false,
   			form:true
	   	},{
	   		config:{
	   				name:'id_institucion',
	   				fieldLabel: 'Institucion',
	   				anchor: '100%',
	   				tinit:true,
	   				allowBlank:true,
	   				origen:'INSTITUCION',
	   				gdisplayField:'nombre',
	   			    gwidth:200,	
	   			   	renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'instit.nombre',type:'string'},
   			grid:false,
   			form:true
	   	},	
		
		{
			config:{
				name: 'codigo',
				fieldLabel: 'codigo',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.codigo',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit',
				fieldLabel: 'NIT',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			filters:{pfiltro:'provee.nit',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'numero_sigma',
				fieldLabel: 'Num.Sigma',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.numero_sigma',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'provee.estado_reg',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha Registro',
				allowBlank: false,
				anchor: '90%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'provee.fecha_reg',type:'date'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'provee.fecha_mod',type:'date'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'pais',
				fieldLabel: 'País',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_lugar',
				fieldLabel: 'Lugar',
				allowBlank: true,
				emptyText:'Lugar...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_parametros/control/Lugar/listarLugar',
					id: 'id_lugar',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_lugar','id_lugar_fk','codigo','nombre','tipo','sw_municipio','sw_impuesto','codigo_largo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_lugar',
				displayField: 'nombre',
				gdisplayField:'lugar',
				hiddenName: 'id_lugar',
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['lugar']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'lug.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'per.nombre',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'apellido_paterno',
				fieldLabel: 'Apellido Paterno',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'per.apellido_paterno',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'apellido_materno',
				fieldLabel: 'Apellido Materno',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'per.apellido_paterno',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'ci',
				fieldLabel: 'CI',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:8
			},
			type:'NumberField',
			filters:{pfiltro:'per.ci',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'correo',
				fieldLabel: 'Correo',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'provee.codigo',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'celular1',
				fieldLabel: 'Celular1',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'NumberField',
			filters:{pfiltro:'per.celular1',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'celular2',
				fieldLabel: 'Celular2',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'NumberField',
			filters:{pfiltro:'per.celular2',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'telefono1',
				fieldLabel: 'Telefono1',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			filters:{pfiltro:'per.telefono1',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'telefono2',
				fieldLabel: 'Telefono2',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			filters:{pfiltro:'per.telefono2',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'genero',
				fieldLabel: 'Genero',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				typeAhead:true,
				triggerAction:'all',
				mode:'local',
				store:['varon','mujer']
			},
			type:'ComboBox',
			filters:{pfiltro:'per.genero',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
		config:{
			fieldLabel: "Foto",
			gwidth: 130,
			inputType:'file',
			name: 'foto',
			//allowBlank:true,
			  buttonText: '',	
			maxLength:150,
			anchor:'100%',
			renderer:function (value, p, record){	
						var momentoActual = new Date();
					
						var hora = momentoActual.getHours();
						var minuto = momentoActual.getMinutes();
						var segundo = momentoActual.getSeconds();
						
						hora_actual = hora+":"+minuto+":"+segundo;
						
					
						
						//return  String.format('{0}',"<div style='text-align:center'><img src = ../../control/foto_persona/"+ record.data['foto']+"?"+record.data['nombre_foto']+hora_actual+" align='center' width='70' height='70'/></div>");
						var splittedArray = record.data['foto'].split('.');
						if (splittedArray[splittedArray.length - 1] != "") {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../control/foto_persona/ActionArmafoto.php?nombre="+ record.data['foto']+"&asd="+hora_actual+"' align='center' width='70' height='70'/></div>");
						} else {
							return  String.format('{0}',"<div style='text-align:center'><img src = '../../../lib/imagenes/NoPerfilImage.jpg' align='center' width='70' height='70'/></div>");
						}
						
					},	
			buttonCfg: {
                iconCls: 'upload-icon'
            }
		},
		//type:'FileUploadField',
		type:'Field',
		sortable:false,
		//filters:{type:'string'},
		id_grupo:1,
		grid:false,
		form:true
	},
		{
			config:{
				name: 'fecha_nacimiento',
				fieldLabel: 'Fecha Nacimiento',
				allowBlank: true,
				anchor: '90%',
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'per.fecha_nacimiento',type:'date'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'direccion',
				fieldLabel: 'Direccion',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'per.direccion',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'doc_id',
				fieldLabel: 'Documento Id',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'nombre_institucion',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'direccion_institucion',
				fieldLabel: 'Direccion',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'casilla',
				fieldLabel: 'Casilla',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'telefono1_institucion',
				fieldLabel: 'Telefono 1',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'telefono2_institucion',
				fieldLabel: 'Telefono 2',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'celular1_institucion',
				fieldLabel: 'Celular 1',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'celular2_institucion',
				fieldLabel: 'Celular 2',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'fax',
				fieldLabel: 'Fax',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:12
			},
			type:'NumberField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'email1_institucion',
				fieldLabel: 'Email 1',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'email2_institucion',
				fieldLabel: 'Email 2',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'pag_web',
				fieldLabel: 'Pagina web',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},
		/*
		{
	   		config:{
	   				name:'id_persona',
	   				fieldLabel: 'Persona',
	   				anchor: '100%',
	   				tinit:true,
	   				allowBlank:false,
	   				origen:'PERSONA',
	   				gdisplayField:'nombre_completo1',
	   			    gwidth:200,	
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['nombre_completo1']);}
   			
	   			  },
   			type:'ComboRec',
   			id_grupo:2,
   			filters:{pfiltro:'person.nombre_completo1',type:'string'},
   		    grid:true,
   			form:true
	   	},*/
		{
			config:{
				name: 'codigo_banco',
				fieldLabel: 'Codigo Banco',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		},		
		{
			config:{
				name: 'codigo_institucion',
				fieldLabel: 'Codigo',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			id_grupo:2,
			grid:false,
			form:true
		}
	],
	title:'Proveedores',
	ActSave:'../../sis_adquisiciones/control/Proveedor/insertarProveedor',
	ActDel:'../../sis_adquisiciones/control/Proveedor/eliminarProveedor',
	ActList:'../../sis_adquisiciones/control/Proveedor/listarProveedor',
	id_store:'id_proveedor',
	fields: [
		{name:'id_proveedor', type: 'numeric'},
		{name:'id_persona', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'numero_sigma', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_institucion', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nombre_completo1', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'id_lugar', type: 'string'},
		{name:'lugar', type: 'string'},
		{name:'pais', type: 'string'}
	],
	
	cmbProveedor:new Ext.form.ComboBox({
	       			name:'proveedor',
	       			fieldLabel:'Proveedor',
	       			allowBlank:false,
	       			emptyText:'Proveedor...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    value:'persona',
	       		    mode: 'local',
	       		    width: 100,
	       		    store:['institucion','persona']
	       		}),
			
	sortInfo:{
		field: 'id_proveedor',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth:400,
	
	iniciarEventos:function()
	{		
		
		//this.ocultarComponente(this.getComponente('id_institucion'));
		//this.ocultarComponente(this.getComponente('id_persona'));
		
		//console.log('entra_antes');
		//cuando se tikea un registro salta este evento
		this.getComponente('id_institucion').disable();
		this.getComponente('id_persona').disable();
		
		
		this.ocultarGrupo(1);
		this.ocultarGrupo(2);		
		this.getComponente('tipo').on('select',function(c,r,n){
				
				if(n=='persona natural' || n=='0'){
					this.getComponente('id_persona').enable();
					this.mostrarComponente(this.getComponente('id_persona'));
					this.ocultarComponente(this.getComponente('id_institucion'));
					this.resetGroup(1);
					this.unblockGroup(1);
					this.mostrarGrupo(1);
					this.ocultarGrupo(2);
					
					//this.getComponente('id_institucion').allowBlank=true;
					//this.getComponente('id_persons').allowBlank=false;
					this.getComponente('id_institucion').reset();
					this.getComponente('id_institucion').disable();
					this.register='no_registered';
				}else{
					this.getComponente('id_institucion').enable();
					
					this.ocultarComponente(this.getComponente('id_persona'));
					this.mostrarComponente(this.getComponente('id_institucion'));
					this.resetGroup(2);
					this.unblockGroup(2);
					this.mostrarGrupo(2);
					this.ocultarGrupo(1);
					//
					//this.getComponente('id_persona').allowBlank=true;
					this.getComponente('id_persona').reset();
					this.getComponente('id_persona').disable();
					this.register='no_registered';
				}
				
		},this);
		
		this.getComponente('id_persona').on('select',function(c,r,n){				
					this.blockGroup(1);
					this.getComponente('ci').setValue(r.data.ci);
					this.getComponente('nombre').setValue(r.data.nombre);
					this.getComponente('apellido_paterno').setValue(r.data.ap_paterno);
					this.getComponente('apellido_materno').setValue(r.data.ap_materno);
					this.getComponente('celular1').setValue(r.data.celular1);
					this.getComponente('celular2').setValue(r.data.celular2);
					this.getComponente('telefono1').setValue(r.data.telefono1);
					this.getComponente('telefono2').setValue(r.data.telefono2);
					this.register='before_registered';
			},this);
		this.getComponente('id_institucion').on('select',function(c,r,n){
			this.blockGroup(2);
			this.getComponente('nombre_institucion').setValue(r.data.nombre);
			this.getComponente('doc_id').setValue(r.data.doc_id);
			this.getComponente('codigo_institucion').setValue(r.data.codigo);
			this.getComponente('casilla').setValue(r.data.casilla);
			this.getComponente('telefono1_institucion').setValue(r.data.telefono1);
			this.getComponente('telefono2_institucion').setValue(r.data.telefono2);
			this.getComponente('celular1_institucion').setValue(r.data.celular1);
			this.getComponente('celular2_institucion').setValue(r.data.celular2);
			this.getComponente('fax').setValue(r.data.fax);
			this.getComponente('email1_institucion').setValue(r.data.email1);
			this.getComponente('email2_institucion').setValue(r.data.email2);
			this.getComponente('pag_web').setValue(r.data.pag_web);
			this.getComponente('observaciones').setValue(r.data.observaciones);
			this.getComponente('id_persona').setValue(r.data.desc_persona);			
			this.getComponente('direccion_institucion').setValue(r.data.direccion);
			this.getComponente('codigo_banco').setValue(r.data.codigo_banco);
			this.register='before_registered';
			},this);
	},
	onButtonEdit:function(){
		datos=this.sm.getSelected().data;
		Phx.vista.Proveedor.superclass.onButtonEdit.call(this); //sobrecarga enable select
		if(datos.tipo=='persona natural'){
			//this.ocultarComponente(this.getComponente('id_institucion'));
			this.getComponente('id_persona').enable();
			
			//this.getComponente('id_institucion').allowBlank=true;
			this.getComponente('id_institucion').reset();
			this.getComponente('id_institucion').disable();
			this.mostrarComponente(this.getComponente('id_persona'));
			this.ocultarComponente(this.getComponente('id_institucion'));
			this.ocultarComponente(this.getComponente('tipo'));
			this.getComponente('tipo').setValue('persona natural');
		}else{
			
			//this.getComponente('id_persona').allowBlank=true;
			this.getComponente('id_institucion').enable();
			this.getComponente('id_persona').reset();
			this.getComponente('id_persona').disable();
			this.ocultarComponente(this.getComponente('id_persona'));
			this.mostrarComponente(this.getComponente('id_institucion'));
			this.ocultarComponente(this.getComponente('tipo'));
		 this.getComponente('tipo').setValue('persona juridica');
			
		}
		
	},
	
	fheight: '95%',
 fwidth: '95%',
	Grupos:
[
            {
                layout: 'column',
                border: false,
                defaults: {
                   border: false
                },            
                items: [{
					        bodyStyle: 'padding-right:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos principales',
					            autoHeight: true,
					            items: [],
						        id_grupo:0
					        }]
					    }, {
					        bodyStyle: 'padding-left:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos persona',
					            autoHeight: true,
					            items: [],
						        id_grupo:1
					        }]
					    },{
					        bodyStyle: 'padding-left:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos institucion',
					            autoHeight: true,
					            items: [],
						        id_grupo:2
					        }]
					    }]
            }
        ]
	}
)
</script>
		
		