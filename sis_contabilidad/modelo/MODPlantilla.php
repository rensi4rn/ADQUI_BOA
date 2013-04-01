<?php
/**
*@package pXP
*@file MODPlantilla.php
*@author  Gonzalo Sarmiento Sejas
*@date 01-04-2013 21:49:11
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPlantilla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPlantilla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='conta.f_plantilla_sel';
		$this->transaccion='CONTA_PLT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_plantilla','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('desc_plantilla','varchar');
		$this->captura('sw_tesoro','varchar');
		$this->captura('sw_compro','varchar');
		$this->captura('nro_linea','numeric');
		$this->captura('tipo','numeric');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPlantilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='conta.f_plantilla_ime';
		$this->transaccion='CONTA_PLT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('desc_plantilla','desc_plantilla','varchar');
		$this->setParametro('sw_tesoro','sw_tesoro','varchar');
		$this->setParametro('sw_compro','sw_compro','varchar');
		$this->setParametro('nro_linea','nro_linea','numeric');
		$this->setParametro('tipo','tipo','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPlantilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='conta.f_plantilla_ime';
		$this->transaccion='CONTA_PLT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla','id_plantilla','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('desc_plantilla','desc_plantilla','varchar');
		$this->setParametro('sw_tesoro','sw_tesoro','varchar');
		$this->setParametro('sw_compro','sw_compro','varchar');
		$this->setParametro('nro_linea','nro_linea','numeric');
		$this->setParametro('tipo','tipo','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPlantilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='conta.f_plantilla_ime';
		$this->transaccion='CONTA_PLT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla','id_plantilla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>