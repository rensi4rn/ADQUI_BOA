<?php
/**
*@package pXP
*@file gen-PlanPago.php
*@author  (admin)
*@date 10-04-2013 15:43:23
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PlanPago=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PlanPago.superclass.constructor.call(this,config);
		this.init();
		 //si la interface es pestanha este código es para iniciar 
          var dataPadre = Phx.CP.getPagina(this.idContenedorPadre).getSelectedData()
          if(dataPadre){
             this.onEnablePanel(this, dataPadre);
          }
          else
          {
             this.bloquearMenus();
          }
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_plan_pago'
			},
			type:'Field',
			form:true 
		},
        {
            config:{
                name: 'id_obligacion_pago',
                inputType:'hidden'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                name: 'id_plan_pago_fk',
                inputType:'hidden',
            },
            type:'NumberField',
            form:true
        },
        {
            config:{
                name: 'estado',
                fieldLabel: 'Estado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:60
            },
            type:'Field',
            filters:{pfiltro:'plapa.estado',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
		{
			config:{
				name: 'nro_cuota',
				fieldLabel: 'Nro',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'plapa.nro_cuota',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'tipo',
                fieldLabel: 'Momento',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:30
            },
            type:'TextField',
            filters:{pfiltro:'plapa.tipo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'nro_sol_pago',
				fieldLabel: 'Número',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:60
			},
			type:'TextField',
			filters:{pfiltro:'plapa.nro_sol_pago',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_pag',
				fieldLabel: 'Fecha Pago',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'plapa.fecha_pag',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_dev',
				fieldLabel: 'Fecha Dev.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'plapa.fecha_dev',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'tipo_cambio',
                fieldLabel: 'Tip Cambio',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1245186
            },
            type:'NumberField',
            filters:{pfiltro:'plapa.tipo_cambio',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'tipo_pago',
				fieldLabel: 'Tipo de Pago',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'plapa.tipo_pago',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_plantilla',
				fieldLabel: 'Doc. de Pago',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'plapa.id_plantilla',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'monto',
                fieldLabel: 'Monto a Pagar',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1245186
            },
            type:'NumberField',
            filters:{pfiltro:'plapa.monto',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'descuento_anticipo',
				fieldLabel: 'Desc. Anticipo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1245186
			},
			type:'NumberField',
			filters:{pfiltro:'plapa.descuento_anticipo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'Obs. Desc. Anticipo',
                fieldLabel: 'Obs. Desc. Antic.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:-5
            },
            type:'TextArea',
            filters:{pfiltro:'plapa.obs_descuentos_anticipo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'monto_no_pagado',
				fieldLabel: 'Monto no pagado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1245186
			},
			type:'NumberField',
			filters:{pfiltro:'plapa.monto_no_pagado',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'obs_monto_no_pagado',
                fieldLabel: 'Obs. Monto no Pagado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:-5
            },
            type:'TextArea',
            filters:{pfiltro:'plapa.obs_monto_no_pagado',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'otros_decuentos',
                fieldLabel: 'Otros Decuentos',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1245186
            },
            type:'NumberField',
            filters:{pfiltro:'plapa.otros_decuentos',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'obs_otros_descuentos',
                fieldLabel: 'Obs. otros desc.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:-5
            },
            type:'TextArea',
            filters:{pfiltro:'plapa.obs_otros_descuentos',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'monto_ejecutar_total_mo',
                fieldLabel: 'Monto a Ejecutar',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1245186
            },
            type:'NumberField',
            filters:{pfiltro:'plapa.monto_ejecutar_total_mo',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre_pago',
                fieldLabel: 'Nombre Pago',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:255
            },
            type:'TextField',
            filters:{pfiltro:'plapa.nombre_pago',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'forma_pago',
                fieldLabel: 'Forma Pago',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:25
            },
            type:'TextField',
            filters:{pfiltro:'plapa.forma_pago',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'id_cuenta_bancaria',
                fieldLabel: 'Cuenta Bancaria Origen',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
            type:'NumberField',
            filters:{pfiltro:'plapa.id_cuenta_bancaria',type:'numeric'},
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
            filters:{pfiltro:'plapa.estado_reg',type:'string'},
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
			filters:{pfiltro:'plapa.fecha_reg',type:'date'},
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
			filters:{pfiltro:'plapa.fecha_mod',type:'date'},
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
	
	title:'Plan Pago',
	ActSave:'../../sis_tesoreria/control/PlanPago/insertarPlanPago',
	ActDel:'../../sis_tesoreria/control/PlanPago/eliminarPlanPago',
	ActList:'../../sis_tesoreria/control/PlanPago/listarPlanPago',
	id_store:'id_plan_pago',
	fields: [
		{name:'id_plan_pago', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nro_cuota', type: 'numeric'},
		{name:'monto_ejecutar_total_mb', type: 'numeric'},
		{name:'nro_sol_pago', type: 'string'},
		{name:'tipo_cambio', type: 'numeric'},
		{name:'fecha_pag', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'fecha_dev', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado', type: 'string'},
		{name:'tipo_pago', type: 'string'},
		{name:'monto_ejecutar_total_mo', type: 'numeric'},
		{name:'descuento_anticipo_mb', type: 'numeric'},
		{name:'obs_descuentos_anticipo', type: 'string'},
		{name:'id_plan_pago_fk', type: 'numeric'},
		{name:'id_obligacion_pago', type: 'numeric'},
		{name:'id_plantilla', type: 'numeric'},
		{name:'descuento_anticipo', type: 'numeric'},
		{name:'otros_decuentos', type: 'numeric'},
		{name:'tipo', type: 'string'},
		{name:'obs_monto_no_pagado', type: 'string'},
		{name:'obs_otros_descuentos', type: 'string'},
		{name:'monto', type: 'numeric'},
		{name:'id_comprobante', type: 'numeric'},
		{name:'nombre_pago', type: 'string'},
		{name:'monto_no_pagado_mb', type: 'numeric'},
		{name:'monto_mb', type: 'numeric'},
		{name:'id_estado_wf', type: 'numeric'},
		{name:'id_cuenta_bancaria', type: 'numeric'},
		{name:'otros_descuentos_mb', type: 'numeric'},
		{name:'forma_pago', type: 'string'},
		{name:'monto_no_pagado', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	iniciarEventos:function(){
        
        this.cmpObligacionPago=this.getComponente('id_obligacion_pago');
        
    },
	onReloadPage:function(m){
       
        this.maestro=m;
        
        
        
        this.store.baseParams={id_obligacion_pago:this.maestro.id_obligacion_pago};
        this.load({params:{start:0, limit:this.tam_pag}})
       
    },
    onButtonNew:function(){
        Phx.vista.PlanPago.superclass.onButtonNew.call(this); 
         
        this.cmpObligacionPago.setValue(this.maestro.id_obligacion_pago)
        
    },
	sortInfo:{
		field: 'id_plan_pago',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		