<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SolicitudReq = {
	require:'../../../sis_adquisiciones/vista/solicitud/Solicitud.php',
	requireclase:'Phx.vista.Solicitud',
	title:'Solicitud',
	nombreVista: 'solicitudReq',
	
	constructor: function(config) {
    		Phx.vista.SolicitudReq.superclass.constructor.call(this,config);
    		this.addButton('fin_requerimiento',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.fin_requerimiento,tooltip: '<b>Finalizar</b>'});
            
            this.iniciarEventos();
            
            //agrega ventana para selecion de RPC
            
                
            this.formRPC = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
           
            layout: 'form',
              
           
    
            items: [{
                    xtype: 'combo',
                    name: 'id_funcionario_rpc',
                     hiddenName: 'id_funcionario_rpc',
                    fieldLabel: 'RPC',
                    allowBlank: false,
                    emptyText:'Elija un funcionario',
                    store:new Ext.data.JsonStore(
                    {
                        url: '../../sis_parametros/control/Aprobador/listarAprobadorFiltrado',
                        id: 'id_funcionario',
                        root:'datos',
                        sortInfo:{
                            field:'prioridad',
                            direction:'ASC'
                        },
                        totalProperty:'total',
                        fields: ['id_funcionario','desc_funcionario','prioridad'],
                        // turn on remote sorting
                        remoteSort: true,
                        baseParams:{par_filtro:'desc_funcionario'}
                    }),
                    valueField: 'id_funcionario',
                    displayField: 'desc_funcionario',
                    forceSelection:true,
                    typeAhead: false,
                    triggerAction: 'all',
                    lazyRender:true,
                    mode:'remote',
                    pageSize:50,
                    queryDelay:500,
                    width:210,
                    gwidth:220,
                    minChars:2,
                    tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                
                }]
        });
        
        
         this.cmbRPC =this.formRPC.getForm().findField('id_funcionario_rpc');
         this.cmbRPC.store.on('exception', this.conexionFailure);
         this.cmbRPC.store.baseParams.codigo_subsistema='ADQ';
         
         
         
         this.wRPC = new Ext.Window({
            title: 'RPC',
            collapsible: true,
            maximizable: true,
             autoDestroy: true,
            width: 350,
            height: 200,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formRPC,
            modal:true,
             closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                 handler:this.onFinalizarSol,
                scope:this
                
            },{
                text: 'Cancelar',
                handler:function(){this.wRPC.hide()},
                scope:this
            }]
        });
            
		
		
		this.store.baseParams={tipo_interfaz:this.nombreVista};
		this.load({params:{start:0, limit:this.tam_pag}});
		
		
	},
    
    iniciarEventos:function(){
        
        this.cmpFechaSoli = this.getComponente('fecha_soli');
        this.cmpIdDepto = this.getComponente('id_depto');
        this.cmpIdProcesoMacro = this.getComponente('id_proceso_macro');
        this.cmpIdGestion = this.getComponente('id_gestion');
        this.cmpIdUo = this.getComponente('id_uo');
        this.cmpIdFuncionarioAprobador = this.getComponente('id_funcionario_aprobador');
        
        //inicio de eventos 
        this.cmpFechaSoli.on('change',function(f){
             this.obtenerGestion(f);
             this.cmpIdUo.reset();
             this.cmpIdFuncionarioAprobador.reset();
             this.cmpIdUo.enable();
             
             },this);
        
        this.cmpIdUo.on('select',function(){   
            this.cmpIdFuncionarioAprobador.store.baseParams.id_uo=this.cmpIdUo.getValue();
            this.cmpIdFuncionarioAprobador.store.baseParams.fecha = this.cmpFechaSoli.getValue().dateFormat(this.cmpFechaSoli.format);
            this.cmpIdFuncionarioAprobador.modificado=true;
            this.cmpIdFuncionarioAprobador.reset();
            this.cmpIdFuncionarioAprobador.enable();
           },this);
      
    },
    
    onButtonNew:function(){
        
       this.cmpFechaSoli.enable();
       this.cmpIdDepto.enable(); 
        this.cmpIdProcesoMacro.enable(); 
       
       this.cmpIdFuncionarioAprobador.disable();
       this.cmpIdUo.disable();
       Phx.vista.SolicitudReq.superclass.onButtonNew.call(this);
           
    },
    onButtonEdit:function(){
       this.cmpFechaSoli.disable();
       this.cmpIdDepto.disable(); 
       this.cmpIdProcesoMacro.disable(); 
       
       this.cmpIdFuncionarioAprobador.disable();
       this.cmpIdUo.disable();
       Phx.vista.SolicitudReq.superclass.onButtonEdit.call(this);
           
    },
    
    onFinalizarSol:function(){
        
            var d= this.sm.getSelected().data;
            Phx.CP.loadingShow();
            
            Ext.Ajax.request({
                // form:this.form.getForm().getEl(),
                url:'../../sis_adquisiciones/control/Solicitud/finalizarSolicitud',
                params:{id_solicitud:d.id_solicitud,operacion:'finalizar',id_funcionario_rpc:this.cmbRPC.getValue()},
                success:this.successFinSol,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });  
     },
        successFinSol:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                
                this.reload();
                 this.wRPC.hide ();
               
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
           
            
        },
    
    
    fin_requerimiento:function()
        {                   
            var d= this.sm.getSelected().data;
           
            Phx.CP.loadingShow();
            this.cmbRPC.reset();
            
            this.cmbRPC.store.baseParams.id_uo=d.id_uo;
            this.cmbRPC.store.baseParams.fecha=d.fecha_soli;
            Ext.Ajax.request({
                // form:this.form.getForm().getEl(),
                url:'../../sis_adquisiciones/control/Solicitud/finalizarSolicitud',
                params:{id_solicitud:d.id_solicitud,operacion:'verificar'},
                success:this.successSinc,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });     
        },
       successSinc:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
               
               this.cmbRPC.store.baseParams.monto= reg.ROOT.datos.total;
                this.cmbRPC.modificado=true;
               this.wRPC.show();
                
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
           
            
        },
     
     obtenerGestion:function(x){
         
         var fecha = x.getValue().dateFormat(x.format);
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                    // form:this.form.getForm().getEl(),
                    url:'../../sis_parametros/control/Gestion/obtenerGestionByFecha',
                    params:{fecha:fecha},
                    success:this.successGestion,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
             });
        }, 
    successGestion:function(resp){
       Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                
                this.cmpIdGestion.setValue(reg.ROOT.datos.id_gestion);
                
               
            }else{
                
                alert('ocurrio al obtener la gestion')
            } 
    },
    
  
    
	 preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.SolicitudReq.superclass.preparaMenu.call(this,n);  
          
          if(data['estado']==  'borrador' || data['estado']==  'Borrador'){
             this.getBoton('fin_requerimiento').enable();
             
           }
          else{
               this.getBoton('fin_requerimiento').disable();
               this.getBoton('edit').disable();
               this.getBoton('new').disable();
               this.getBoton('del').disable();
              // this.getBoton('save').disable();
            
              
              
          }
        return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.SolicitudReq.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('fin_requerimiento').disable();
           
        }
        
       return tb
    },    
       
	
	south:
          { 
          url:'../../../sis_adquisiciones/vista/solicitud_det/SolicitudReqDet.php',
          title:'Detalle', 
          height:'50%',
          cls:'SolicitudReqDet'
         }
};
</script>
