<?php
/**
*@package pXP
*@file gen-MODPersonaComunicacion.php
*@author  (admin)
*@date 08-01-2013 19:45:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPersonaComunicacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPersonaComunicacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.f_persona_comunicacion_sel';
		$this->transaccion='DIR_PERCOM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_persona_comunicacion','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_tipo_comunicacion','int4');
		$this->captura('valor','varchar');
		$this->captura('id_persona','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPersonaComunicacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.f_persona_comunicacion_ime';
		$this->transaccion='DIR_PERCOM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_comunicacion','id_tipo_comunicacion','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('id_persona','id_persona','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPersonaComunicacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.f_persona_comunicacion_ime';
		$this->transaccion='DIR_PERCOM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_persona_comunicacion','id_persona_comunicacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_comunicacion','id_tipo_comunicacion','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('id_persona','id_persona','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPersonaComunicacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.f_persona_comunicacion_ime';
		$this->transaccion='DIR_PERCOM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_persona_comunicacion','id_persona_comunicacion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>