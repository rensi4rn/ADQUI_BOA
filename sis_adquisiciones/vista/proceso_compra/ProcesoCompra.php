<?php
/**
*@package pXP
*@file gen-ProcesoCompra.php
*@author  (admin)
*@date 19-03-2013 12:55:30
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ProcesoCompra=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ProcesoCompra.superclass.constructor.call(this,config);
		this.init();
		this.addButton('btnCotizacion',{
            text :'Cotizacion',
            iconCls : 'bdocuments',
            disabled: true,
            handler : this.onButtonCotizacion,
            tooltip : '<b>Cotizacion de solicitud de Compra</b><br/><b>Cotizacion de solicitud de Compra</b>'
  });
  
		this.addButton('btnCuadroComparativo',{
							 text :'Cuadro Comparativo',
							 iconCls : 'bexcel',
							 disabled: true,
							 handler : this.onCuadroComparativo,
							 tooltip : '<b>Cuadro Comparativo</b><br/><b>Cuadro Comparativo de Cotizaciones</b>'
	 });
	 
		this.load({params:{start:0, limit:this.tam_pag}});
		this.iniciarEventos();
	
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_proceso_compra',
					
			},
			type:'Field',
			form:true 
		},
        {
            config:{
                name: 'estado',
                fieldLabel: 'Estado',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                renderer: function(value,p,record){
                        if(record.data.estado=='anulado'||record.data.estado=='desierto'){
                             return String.format('<b><font color="red">{0}</font></b>', value);
                         }
                         else{
                            return String.format('{0}', value);
                        }},
                maxLength:30
            },
            type:'TextField',
            filters:{pfiltro:'proc.estado',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
		{
            config:{
                name:'id_depto',
                 hiddenName: 'id_depto',
                    origen:'DEPTO',
                    allowBlank:false,
                    fieldLabel: 'Depto',
                    gdisplayField:'desc_depto',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
                    width:250,
                    gwidth:100,
                    baseParams:{estado:'activo',codigo_subsistema:'ADQ',tipo_filtro:'DEPTO_UO'},//parametros adicionales que se le pasan al store
                    renderer:function (value, p, record){return String.format('{0}', record.data['desc_depto']);}
            },
            //type:'TrigguerCombo',
            type:'ComboRec',
            id_grupo:0,
            filters:{pfiltro:'dep.nombre',type:'string'},
            grid:true,
            form:true
        },
        {
            config: {
                name: 'id_solicitud',
                hiddenName: 'id_solicitud',
                fieldLabel: 'Solicutud de Compra',
                typeAhead: false,
                forceSelection: false,
                allowBlank: false,
                emptyText: 'Solicitudes...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_adquisiciones/control/Solicitud/listarSolicitud',
                    id: 'id_solicitud',
                    root: 'datos',
                    sortInfo: {
                        field: 'numero',
                        direction: 'DESC'
                    },
                    totalProperty: 'total',
                    fields: ['id_solicitud','numero','desc_uo','desc_funcionario','id_moneda','desc_moneda','desc_categoria_compra','num_tramite'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'sol.numero#fun.desc_funcionario1#uo.codigo#uo.nombre_unidad',tipo_interfaz:'aprobadores'}
                }),
                valueField: 'id_solicitud',
                displayField: 'numero',
                gdisplayField: 'desc_solicitud',
                gsortField:'sol.numero',
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                listWidth:280,
                minChars: 2,
                gwidth: 170,
                renderer: function(value, p, record) {
                        if(record.data.estado=='anulado'||record.data.estado=='desierto'){
                             return String.format('<b><font color="red">{0}</font></b>', record.data['desc_solicitud']);
                         }
                         else{
                            return String.format('{0}', record.data['desc_solicitud']);
                        }
                },
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>{numero}</p><p>Sol.: <strong>{desc_funcionario}</strong></p><p>UO: <strong>{desc_uo}</strong></p> </div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'sol.numero',
                type: 'string'
            },
            grid: true,
            form: true
        },
        {
            config:{
                name: 'desc_funcionario',
                fieldLabel: 'Funcionario',
                allowBlank: true,
                anchor: '80%',
                gwidth: 200,
                maxLength:30
            },
            type:'TextField',
            filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'num_tramite',
                fieldLabel: 'N# Tramite',
                allowBlank: true,
                anchor: '80%',
                gwidth: 130,
                maxLength:200
            },
            type:'TextField',
            filters:{pfiltro:'proc.num_tramite',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'desc_moneda',
                fieldLabel: 'Moneda',
                allowBlank: true,
                anchor: '80%',
                gwidth: 50,
                maxLength:50
            },
            type:'TextField',
            filters:{pfiltro:'mon.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'codigo_proceso',
                fieldLabel: 'Código Proceso',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:50
            },
            type:'TextField',
            filters:{pfiltro:'proc.codigo_proceso',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        
        {
            config:{
                name: 'fecha_ini_proc',
                fieldLabel: 'Fecha Inicio',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                        format: 'd/m/Y', 
                        renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
            },
            type:'DateField',
            filters:{pfiltro:'proc.fecha_ini_proc',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'obs_proceso',
                fieldLabel: 'Observaciones',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:500
            },
            type:'TextArea',
            filters:{pfiltro:'proc.obs_proceso',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'num_cotizacion',
                fieldLabel: 'num_cotizacion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:30
            },
            type:'TextField',
            filters:{pfiltro:'proc.num_cotizacion',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        }
        ,
		{
			config:{
				name: 'num_convocatoria',
				fieldLabel: 'Num Convocatoria',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'proc.num_convocatoria',type:'string'},
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
			filters:{pfiltro:'proc.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'proc.fecha_reg',type:'date'},
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
			filters:{pfiltro:'proc.fecha_mod',type:'date'},
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
	
	title:'Proceso de Compra',
	ActSave:'../../sis_adquisiciones/control/ProcesoCompra/insertarProcesoCompra',
	ActDel:'../../sis_adquisiciones/control/ProcesoCompra/eliminarProcesoCompra',
	ActList:'../../sis_adquisiciones/control/ProcesoCompra/listarProcesoCompra',
	id_store:'id_proceso_compra',
	fields: [
		{name:'id_proceso_compra', type: 'numeric'},
		{name:'id_depto', type: 'numeric'},
		{name:'num_convocatoria', type: 'string'},
		{name:'id_solicitud', type: 'numeric'},
		{name:'id_estado_wf', type: 'numeric'},
		{name:'fecha_ini_proc', type: 'date',dateFormat:'Y-m-d'},
		{name:'obs_proceso', type: 'string'},
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'num_tramite', type: 'string'},
		{name:'codigo_proceso', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'num_cotizacion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},'desc_moneda','desc_funcionario','desc_uo','desc_depto','desc_solicitud'
		
	],
	
	iniciarEventos:function(){
	  this.cmbDepto = this.getComponente('id_depto');
	  this.cmbSolicitud = this.getComponente('id_solicitud');
	  this.cmpNumTramite = this.getComponente('num_tramite');
	  this.cmbSolicitud.disable();
	  this.cmpNumTramite.disable();
	  
	  
	  this.cmbDepto.on('select',function(){
	      this.cmbSolicitud.enable();
	      this.cmbSolicitud.store.baseParams.id_depto =this.cmbDepto.getValue();
	      this.cmbSolicitud.store.baseParams.estado = 'aprobado';
	      this.cmbSolicitud.reset();
	      this.cmbSolicitud.modificado=true;
	  },this);
	  
	  this.cmbSolicitud.on('select',function(cmb,dat,c){
	      
            this.cmpNumTramite.setValue(dat.data.num_tramite)
      },this);
	  
	  
	  
	},
	
	 onButtonCotizacion:function() {
            var rec=this.sm.getSelected();
            Phx.CP.loadWindows('../../../sis_adquisiciones/vista/cotizacion/Cotizacion.php',
                    'Cotizacion de solicitud de compra',
                    {
                        width:900,
                        height:600
                    },
                    rec.data,
                    this.idContenedor,
                    'Cotizacion'
        )
    },
    
		onCuadroComparativo: function(){
					var rec=this.sm.getSelected();
         console.debug(rec);
         Ext.Ajax.request({
             url:'../../sis_adquisiciones/control/ProcesoCompra/cuadroComparativo',
             params:{'id_proceso_compra':rec.data.id_proceso_compra},
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
    
    onButtonNew:function(){         
            Phx.vista.ProcesoCompra.superclass.onButtonNew.call(this);
            this.cmbSolicitud.enable();
            this.cmbDepto.enablle();          
    },
    onButtonEdit:function(){         
            Phx.vista.ProcesoCompra.superclass.onButtonEdit.call(this);
            this.cmbSolicitud.disable();  
            this.cmbDepto.disable();        
    },
    
    
    preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
        
        Phx.vista.ProcesoCompra.superclass.preparaMenu.call(this,n);
        if(data.estado=='anulado' || data.estado=='desierto'){
            this.getBoton('edit').disable();
            this.getBoton('del').disable();
            this.getBoton('btnCotizacion').disable();
            this.getBoton('btnCuadroComparativo').disable();
        }
        else{
            this.getBoton('btnCotizacion').enable();
            this.getBoton('btnCuadroComparativo').enable();
        }
         return tb 
     },
     
     liberaMenu:function(){
        var tb = Phx.vista.ProcesoCompra.superclass.liberaMenu.call(this);
        if(tb){           
            this.getBoton('btnCotizacion').setDisabled(true);           
        }
       return tb
    },
    
	sortInfo:{
		field: 'id_proceso_compra',
		direction: 'ASC'
	},
	south:
          { 
          url:'../../../sis_adquisiciones/vista/solicitud_det/SolicitudVbDet.php',
          title:'Detalle', 
          height:'50%',
          cls:'SolicitudVbDet'
         },
	bdel:true,
	bsave:false
	}
)
</script>
		
		