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
Phx.vista.PersonaDir = {
	require:'../../../sis_seguridad/vista/persona/Persona.php',
	requireclase:'Phx.vista.persona',
	title:'Persona',
	nombreVista: 'personaDir',
	bdel: true,
	bedit: true,
	bnew: true,
	constructor: function(config) {
		Phx.vista.PersonaDir.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		
	},
	
	south:{
		  url:'../../../sis_directorio/vista/persona_comunicacion/PersonaComunicacion.php',
		  title:'Comunicaciones', 
		  height:'50%',
		  cls:'PersonaComunicacion'
		}
	
};
</script>
