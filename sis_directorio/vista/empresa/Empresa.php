<?php
/**
*@package pXP
*@file gen-Empresa.php
*@author  (admin)
*@date 15-03-2013 21:40:25
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Empresa=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Empresa.superclass.constructor.call(this,config);
		this.init();
		this.addButton('btnFundempresa',{
            text :'Recupera datos de fundempresa',
            iconCls : 'btransfer',
            disabled: false,
            handler : this.onButtonFundempresa,
            tooltip : '<b>Recupera datos de fundempresa</b><br/><b>Recupera datos de fundempresa</b>'
  });
		this.load({params:{start:0, limit:this.tam_pag}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_empresa'
			},
			type:'Field',
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
			filters:{pfiltro:'emp.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'tipo_sociedad',
				fieldLabel: 'Tipo Sociedad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'emp.tipo_sociedad',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'actividad',
				fieldLabel: 'Actividad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'emp.actividad',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'actividad_esp',
				fieldLabel: 'Act. Especifica',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'emp.actividad_esp',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit',
				fieldLabel: 'nit',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'emp.nit',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'actividad_gral',
				fieldLabel: 'Act. Gral',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'emp.actividad_gral',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'domicilio',
				fieldLabel: 'domicilio',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'emp.domicilio',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'matricula',
				fieldLabel: 'matricula',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'emp.matricula',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'renovado',
				fieldLabel: 'renovado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'emp.renovado',type:'numeric'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'actividad_prim',
				fieldLabel: 'Act. Primaria',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'emp.actividad_prim',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'emp.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'departamento',
				fieldLabel: 'Departamento',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'emp.departamento',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'telefono',
				fieldLabel: 'telefono',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'emp.telefono',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'municipio',
				fieldLabel: 'Municipio',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'emp.municipio',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_matricula',
				fieldLabel: 'estado_matricula',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'emp.estado_matricula',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'mail',
				fieldLabel: 'mail',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextField',
			filters:{pfiltro:'emp.mail',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'emp.fecha_reg',type:'date'},
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
			filters:{pfiltro:'emp.fecha_mod',type:'date'},
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
	
	title:'Empresa',
	ActSave:'../../sis_directorio/control/Empresa/insertarEmpresa',
	ActDel:'../../sis_directorio/control/Empresa/eliminarEmpresa',
	ActList:'../../sis_directorio/control/Empresa/listarEmpresa',
	id_store:'id_empresa',
	fields: [
		{name:'id_empresa', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo_sociedad', type: 'string'},
		{name:'actividad', type: 'string'},
		{name:'actividad_esp', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'actividad_gral', type: 'string'},
		{name:'domicilio', type: 'string'},
		{name:'matricula', type: 'string'},
		{name:'renovado', type: 'numeric'},
		{name:'actividad_prim', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'departamento', type: 'string'},
		{name:'telefono', type: 'string'},
		{name:'municipio', type: 'string'},
		{name:'estado_matricula', type: 'string'},
		{name:'mail', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_empresa',
		direction: 'ASC'
	},
	
	onButtonFundempresa:function(){
	    //var rec=this.sm.getSelected();
       //         console.debug(rec);
                Ext.Ajax.request({
                    url:'../../sis_directorio/control/RecuperaDatos/insertarEmpresa',
                    params:{'id_solicitud':'hola'},
                    success: this.successExport,
                    failure: function() {
                        console.log("fail");
                    },
                    timeout: function() {
                        console.log("timeout");
                    },
                    scope:this
                });  
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		