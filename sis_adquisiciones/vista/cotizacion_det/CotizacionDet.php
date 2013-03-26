<?php
/**
*@package pXP
*@file CotizacionDet.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-03-2013 21:44:43
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.CotizacionDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.CotizacionDet.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
		//this.load({params:{start:0, limit:this.tam_pag}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_cotizacion_det'
			},
			type:'Field',
			form:true 
		},		
		{
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
				name: 'id_solicitud_det',
				fieldLabel: 'Solicitud Det',
				allowBlank: false,
				emptyText: 'Solicitud Det...',
				store: new Ext.data.JsonStore({

	    					url: '../../sis_adquisiciones/control/SolicitudDet/listarSolicitudDetCotizacion',
	    					id: 'id_solicitud_det',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'id_solicitud_det',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_solicitud_det','desc_centro_costo','desc_concepto_ingas','descripcion'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo'}
	    				}),
	   valueField: 'id_solicitud_det',
	   displayField: 'desc_concepto_ingas',
	   //gdisplayField: 'otro',
	   hiddenName: 'id_solicitud_det',
	   triggerAction: 'all',
	   //queryDelay:1000,
	   pageSize:10,
				forceSelection: true,
				typeAhead: true,
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				mode: 'remote',
				renderer: function(value,p,record){return String.format('{0}',record.data['desc_solicitud_det']);},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_concepto_ingas}<br>{desc_centro_costo}</p></div></tpl>'
			},
	           			
			type:'ComboBox',
			filters:{pfiltro:'cig.desc_ingas',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'descripcion_sol',
                fieldLabel: 'Descripción',
                allowBlank: true,
                anchor: '80%',
                gwidth: 200,
                maxLength:500
            },
            type:'TextArea',
            filters:{pfiltro:'sold.descripcion',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'precio_unitario_sol',
                fieldLabel: 'P/U Ref.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 120,
                maxLength:1245186
            },
            type:'NumberField',
            filters:{pfiltro:'ctd.precio_unitario',type:'numeric'},
            id_grupo:1,
            grid:true,
           form:false
        },
        {
            config:{
                name: 'cantidad_sol',
                fieldLabel: 'Cantidad Ref.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1245184
            },
            type:'NumberField',
            filters:{pfiltro:'sold.precio_unitario',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:false
        },
		{
			config:{
				name: 'precio_unitario',
				fieldLabel: 'P/U Ofer.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 120,
				maxLength:1245186
			},
			type:'NumberField',
			filters:{pfiltro:'ctd.precio_unitario',type:'numeric'},
			id_grupo:1,
			grid:true,
			egrid:true,
			form:true
		},
        {
            config:{
                name: 'cantidad_coti',
                fieldLabel: 'Cant. Ofer.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1245184
            },
            type:'NumberField',
            filters:{pfiltro:'ctd.cantidad_coti',type:'numeric'},
            id_grupo:1,
            grid:true,
            egrid:true,
            form:true
        },
		{
			config:{
				name: 'cantidad_aduj',
				fieldLabel: 'Cant. Adjudicada',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1245184
			},
			type:'NumberField',
			filters:{pfiltro:'ctd.cantidad_aduj',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Obs',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'ctd.obs',type:'string'},
			id_grupo:1,
			grid:true,
			egrid:true,
			form:true
		},
        {
            config:{
                name: 'desc_centro_costo',
                fieldLabel: 'Centro de Costos',
                allowBlank: true,
                anchor: '80%',
                gwidth: 280,
                maxLength:500
            },
            type:'Field',
            filters:{pfiltro:'cc.codigo_cc',type:'string'},
            id_grupo:1,
            grid:true,
            gedit:true,
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
			filters:{pfiltro:'ctd.estado_reg',type:'string'},
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
			filters:{pfiltro:'ctd.fecha_reg',type:'date'},
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
			filters:{pfiltro:'ctd.fecha_mod',type:'date'},
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
	
	title:'Detalle cotizacion',
	ActSave:'../../sis_adquisiciones/control/CotizacionDet/insertarCotizacionDet',
	ActDel:'../../sis_adquisiciones/control/CotizacionDet/eliminarCotizacionDet',
	ActList:'../../sis_adquisiciones/control/CotizacionDet/listarCotizacionDet',
	id_store:'id_cotizacion_det',
	fields: [
		{name:'id_cotizacion_det', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_cotizacion', type: 'numeric'},
		{name:'precio_unitario', type: 'numeric'},
		{name:'cantidad_aduj', type: 'numeric'},
		{name:'cantidad_coti', type: 'numeric'},
		{name:'obs', type: 'string'},
		{name:'id_solicitud_det', type: 'numeric'},
		{name:'desc_solicitud_det', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_centro_costo',
        'cantidad_sol',
        'precio_unitario_sol',
        'descripcion_sol'],
	sortInfo:{
		field: 'id_cotizacion_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	iniciarEventos:function(){
	    
	    this.cmpPrecioUnitario=this.getComponente('precio_unitario');
	    
	    
        this.cmbSolicitudDet=this.getComponente('id_solicitud_det');
        
         this.cmpDescripcionSol=this.getComponente('descripcion_sol');
         this.cmpDescripcionSol.disable();
       
         
          this.cmbSolicitudDet.on('select',function(c,d){
               
               this.cmpDescripcionSol.setValue(d.data.descripcion);
          },this);
	    
	    
	    this.confPrecioUnitarioSol = this.Atributos[this.getIndAtributo('precio_unitario_sol')].config;
	   
	    
	    
	    
	    
	},
	  preparaMenu:function(n){
         
         Phx.vista.SolicitudReqDet.superclass.preparaMenu.call(this,n); 
          if(this.maestro.estado ==  'borrador'){
               this.getBoton('edit').enable();
               this.getBoton('new').enable();
               this.getBoton('del').enable();
               this.getBoton('save').enable();
         }
         else{
             
               this.getBoton('edit').disable();
               this.getBoton('new').disable();
               this.getBoton('del').disable();
               this.getBoton('save').disable();
         }
          
        
          
     },
     liberaMenu: function() {
         Phx.vista.SolicitudReqDet.superclass.liberaMenu.call(this); 
           if(this.maestro&&(this.maestro.estado !=  'borrador' )){
           }
           else{      
               this.getBoton('edit').disable();
               this.getBoton('new').disable();
               this.getBoton('del').disable();
               this.getBoton('save').disable();
         }
    },
	
	onReloadPage:function(m){       
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_cotizacion;
        
        //coloca el id_cotizacion al atributo id_solicitud_det
        this.getComponente('id_solicitud_det').store.baseParams.id_cotizacion=this.maestro.id_cotizacion;
        
        this.store.baseParams={id_cotizacion:this.maestro.id_cotizacion};        
        this.load({params:{start:0, limit:50}})       
       
       
        this.cmpPrecioUnitario.currencyChar = this.maestro.desc_moneda+' ';
        this.setColumnHeader('precio_unitario', '(e)'+this.cmpPrecioUnitario.fieldLabel +' '+this.maestro.desc_moneda)
       
        this.setColumnHeader('precio_unitario_sol',   this.confPrecioUnitarioSol.fieldLabel +' '+this.maestro.desc_moneda_sol)
       
       if(this.maestro.estado ==  'borrador'){
             
             this.getBoton('new').enable();
             
         }
         else{
             
             this.getBoton('edit').disable();
             this.getBoton('new').disable();
             this.getBoton('del').disable();
             this.getBoton('save').disable();
          }
       
      }
	}
)
</script>
		
		