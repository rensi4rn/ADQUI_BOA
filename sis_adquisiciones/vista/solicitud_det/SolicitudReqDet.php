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
Phx.vista.SolicitudReqDet = {
   /* bedit:false,
    bnew:false,
    bsave:false,
    bdel:false,*/
	require:'../../../sis_adquisiciones/vista/solicitud_det/SolicitudDet.php',
	requireclase:'Phx.vista.SolicitudDet',
	title:'Solicitud',
	nombreVista: 'solicitudDetVb',
	
	constructor: function(config) {
	    
	    this.maestro=config.maestro;
	    Phx.vista.SolicitudReqDet.superclass.constructor.call(this,config);
    },
	onReloadPage:function(m){
       this.maestro=m;
       
       this.store.baseParams={id_solicitud:this.maestro.id_solicitud};
       this.getComponente('id_concepto_ingas').store.baseParams.tipo=this.maestro.tipo
       this.getComponente('id_centro_costo').store.baseParams.id_gestion=this.maestro.id_gestion
       this.getComponente('id_concepto_ingas').modificado = true;
       this.getComponente('id_centro_costo').modificado=true;
       this.load({params:{start:0, limit:50}});
              
       this.cmpPrecioUnitario.currencyChar = this.maestro.desc_moneda+' ';   
       this.cmpPrecioTotal.currencyChar = this.maestro.desc_moneda+' ';
       this.cmpCantidad.currencyChar = this.maestro.desc_moneda+' ';
       this.cmpPrecioSg.currencyChar = this.maestro.desc_moneda+' ';
       this.cmpPrecioGa.currencyChar = this.maestro.desc_moneda+' ';
         
       this.setColumnHeader('precio_unitario', this.cmpPrecioUnitario.fieldLabel +' '+this.maestro.desc_moneda)
       this.setColumnHeader('precio_total', this.cmpPrecioTotal.fieldLabel +' '+this.maestro.desc_moneda)
       this.setColumnHeader('precio_sg', this.cmpPrecioSg.fieldLabel +' '+this.maestro.desc_moneda)
       this.setColumnHeader('precio_ga', this.cmpPrecioGa.fieldLabel +' '+this.maestro.desc_moneda)
        
         if(this.maestro.estado ==  'borrador' || this.maestro.estado ==  'Borrador'){
             
             this.getBoton('new').enable();
             
         }
         else{
             
             this.getBoton('edit').disable();
             this.getBoton('new').disable();
             this.getBoton('del').disable();
          }
     },
    
     preparaMenu:function(n){
         
         Phx.vista.SolicitudReqDet.superclass.preparaMenu.call(this,n); 
          if(this.maestro.estado ==  'borrador' || this.maestro.estado==  'Borrador'){
               this.getBoton('edit').enable();
               this.getBoton('new').enable();
               this.getBoton('del').enable();
         }
         else{
             
               this.getBoton('edit').disable();
               this.getBoton('new').disable();
               this.getBoton('del').disable();
         }
          
          console.log('maestro en prepara ',this.maestro.estado) 
          
     },
     
     liberaMenu: function() {
         Phx.vista.SolicitudReqDet.superclass.liberaMenu.call(this); 
           if(this.maestro&&(this.maestro.estado !=  'borrador' || this.maestro.estado!=  'Borrador')){
           }
           else{      
               this.getBoton('edit').disable();
               this.getBoton('new').disable();
               this.getBoton('del').disable();
         }
    },
    
	iniciarEventos:function(){
         this.cmpPrecioUnitario= this.getComponente('precio_unitario');
         this.cmpPrecioTotal = this.getComponente('precio_total');
         this.cmpCantidad = this.getComponente('cantidad');
         this.cmpPrecioSg = this.getComponente('precio_sg');
         this.cmpPrecioGa = this.getComponente('precio_ga');
         
        this.cmpPrecioUnitario.on('valid',function(field){
             var pTot = this.cmpCantidad.getValue() *this.cmpPrecioUnitario.getValue();
             this.cmpPrecioTotal.setValue(pTot);
              this.cmpPrecioGa.setValue(pTot);
             this.cmpPrecioSg.setValue(0)
             
        } ,this);
        
       this.cmpCantidad.on('valid',function(field){
            var pTot = this.cmpCantidad.getValue() * this.cmpPrecioUnitario.getValue();
            this.cmpPrecioTotal.setValue(pTot);
             this.cmpPrecioGa.setValue(pTot);
             this.cmpPrecioSg.setValue(0);
            
        } ,this);
        
         this.cmpPrecioSg.on('valid',function(field){
            
            this.cmpPrecioGa.setValue(this.cmpPrecioTotal.getValue() -this.cmpPrecioSg.getValue());
            
        } ,this);
     }
   
};
</script>
