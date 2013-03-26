<?php
/**
*@package pXP
*@file Cotizacion.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-03-2013 14:48:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Cotizacion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
    	
		Phx.vista.Cotizacion.superclass.constructor.call(this,config);
		this.init();		
  this.addButton('btnReporte',{
            text :'Reporte',
            iconCls : 'bpdf32',
            disabled: true,
            handler : this.onButtonReporte,
            tooltip : '<b>Reporte de Cotizacion</b><br/><b>Reporte de Cotizacion de solicitud de Compra</b>'
  });
		this.load({params:{start:0, limit:this.tam_pag, id_proceso_compra:this.id_proceso_compra}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_cotizacion'
			},
			type:'Field',
			form:true 
		},		
		{
			config:{
				name: 'id_proveedor',
				fieldLabel: 'Proveedor',
				allowBlank: false,
				emptyText: 'Proveedor ...',
				store: new Ext.data.JsonStore({

	    					url: '../../sis_parametros/control/Proveedor/listarProveedorCombos',
	    					id: 'id_proveedor',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'desc_proveedor',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_proveedor','codigo','desc_proveedor'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo#desc_proveedor'}
	    				}),
	   valueField: 'id_proveedor',
	   displayField: 'desc_proveedor',
	   gdisplayField: 'desc_proveedor',
	   hiddenName: 'id_proveedor',
	   triggerAction: 'all',
	   //queryDelay:1000,
	   pageSize:10,
				forceSelection: true,
				typeAhead: true,
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				mode: 'remote',
				renderer: function(value,p,record){return String.format('{0}',record.data['desc_proveedor']);}
			},
	           			
			type:'ComboBox',
			filters:{pfiltro:'cot.desc_proveedor',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_moneda',
				fieldLabel: 'Moneda',
				allowBlank: false,
				emptyText: 'Moneda ...',
				store: new Ext.data.JsonStore({

	    					url: '../../sis_parametros/control/Moneda/listarMoneda',
	    					id: 'id_moneda',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'moneda',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_moneda','codigo','moneda'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo#moneda'}
	    				}),
	   valueField: 'id_moneda',
	   displayField: 'moneda',
	   //gdisplayField: 'otro',
	   hiddenName: 'id_moneda',
	   triggerAction: 'all',
	   //queryDelay:1000,
	   pageSize:10,
				forceSelection: true,
				typeAhead: true,
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				mode: 'remote',
				renderer: function(value,p,record){return String.format('{0}',record.data['moneda']);}
			},
	           			
			type:'ComboBox',
			filters:{pfiltro:'cot.moneda',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'cot.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'lugar_entrega',
				fieldLabel: 'Lugar Entrega',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'cot.lugar_entrega',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tipo_entrega',
				fieldLabel: 'Tipo Entrega',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:40
			},
			type:'TextField',
			filters:{pfiltro:'cot.tipo_entrega',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_coti',
				fieldLabel: 'Fecha Cotiz.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cot.fecha_coti',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'numero_oc',
				fieldLabel: 'Numero O.C.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'cot.numero_oc',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'porc_anticipo',
				fieldLabel: '% Anticipo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1245286
			},
			type:'NumberField',
			filters:{pfiltro:'cot.porc_anticipo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'precio_total',
				fieldLabel: 'Precio Total',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1245186
			},
			type:'NumberField',
			filters:{pfiltro:'cot.precio_total',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_entrega',
				fieldLabel: 'Fecha Entrega',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cot.fecha_entrega',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proceso_compra'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'fecha_venc',
				fieldLabel: 'Fecha Venc',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cot.fecha_venc',type:'date'},
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
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'cot.obs',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_adju',
				fieldLabel: 'Fecha Adju',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'cot.fecha_adju',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nro_contrato',
				fieldLabel: 'Nro Contrato',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'cot.nro_contrato',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'porc_retgar',
				fieldLabel: '% retgar',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:131074
			},
			type:'NumberField',
			filters:{pfiltro:'cot.porc_retgar',type:'numeric'},
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
			filters:{pfiltro:'cot.estado_reg',type:'string'},
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
			filters:{pfiltro:'cot.fecha_reg',type:'date'},
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
			filters:{pfiltro:'cot.fecha_mod',type:'date'},
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
	
	title:'Cotizaciones',
	ActSave:'../../sis_adquisiciones/control/Cotizacion/insertarCotizacion',
	ActDel:'../../sis_adquisiciones/control/Cotizacion/eliminarCotizacion',
	ActList:'../../sis_adquisiciones/control/Cotizacion/listarCotizacion',
	id_store:'id_cotizacion',
	fields: [
		{name:'id_cotizacion', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'lugar_entrega', type: 'string'},
		{name:'tipo_entrega', type: 'string'},
		{name:'fecha_coti', type: 'date',dateFormat:'Y-m-d'},
		{name:'numero_oc', type: 'numeric'},
		{name:'id_proveedor', type: 'numeric'},
		{name:'desc_proveedor', type: 'string'},
		{name:'porc_anticipo', type: 'numeric'},
		{name:'precio_total', type: 'numeric'},
		{name:'fecha_entrega', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_moneda', type: 'numeric'},
		{name:'moneda', type: 'string'},
		{name:'id_proceso_compra', type: 'numeric'},
		{name:'fecha_venc', type: 'date',dateFormat:'Y-m-d'},
		{name:'obs', type: 'string'},
		{name:'fecha_adju', type: 'date',dateFormat:'Y-m-d'},
		{name:'nro_contrato', type: 'string'},
		{name:'porc_retgar', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	
	onButtonReporte:function(){
	    var rec=this.sm.getSelected();
                console.debug(rec);
                Ext.Ajax.request({
                    url:'../../sis_adquisiciones/control/Cotizacion/reporteCotizacion',
                    params:{'id_cotizacion':rec.data.id_cotizacion},
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
	
	preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
       
        this.getBoton('btnReporte').setDisabled(false);

        Phx.vista.Cotizacion.superclass.preparaMenu.call(this,n);
         return tb 
     },
     
     liberaMenu:function(){
        var tb = Phx.vista.Cotizacion.superclass.liberaMenu.call(this);
        if(tb){           
            this.getBoton('btnReporte').setDisabled(true);           
        }
       return tb
    },
    
	sortInfo:{
		field: 'id_cotizacion',
		direction: 'ASC'
	},
	
	onButtonNew:function(){			
			Phx.vista.Cotizacion.superclass.onButtonNew.call(this);
			this.getComponente('id_proceso_compra').setValue(this.id_proceso_compra);			
	},
	
	bdel:true,
	bsave:true,
	south:{	   
        url:'../../../sis_adquisiciones/vista/cotizacion_det/CotizacionDet.php',
        title:'Detalles Cotizacion', 
        height : '50%',
        cls:'CotizacionDet'    
    }
	}
)
</script>
		
		