<?php
/**
*@package pXP
*@file gen-ChequeoDocumentoSol.php
*@author  (admin)
*@date 08-02-2013 19:01:00
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ChequeoDocumentoSol={
    require:'../../../sis_adquisiciones/vista/documento_sol/DocumentoSol.php',
    requireclase:'Phx.vista.DocumentoSol',
    title:'Chequeo de documentos de la solicitud',
    nombreVista: 'ChequeoDocumentoSol',
    bdel: true,
    bedit: true,
    bnew: true,

	constructor:function(config){		
    	//llama al constructor de la clase padre
		Phx.vista.ChequeoDocumentoSol.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, 'nombreVista': this.nombreVista}});
	}
			
	
};

</script>
		
		