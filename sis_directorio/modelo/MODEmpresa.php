<?php
/**
*@package pXP
*@file gen-MODEmpresa.php
*@author  (admin)
*@date 15-03-2013 21:40:25
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEmpresa extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEmpresa(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dir.f_empresa_sel';
		$this->transaccion='DIR_EMP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_empresa','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo_sociedad','varchar');
		$this->captura('actividad','text');
		$this->captura('actividad_esp','varchar');
		$this->captura('nit','varchar');
		$this->captura('actividad_gral','varchar');
		$this->captura('domicilio','text');
		$this->captura('matricula','int8');
		$this->captura('renovado','int4');
		$this->captura('actividad_prim','varchar');
		$this->captura('nombre','varchar');
		$this->captura('departamento','varchar');
		$this->captura('telefono','varchar');
		$this->captura('municipio','varchar');
		$this->captura('estado_matricula','varchar');
		$this->captura('mail','varchar');
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
			
	function insertarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.f_empresa_ime';
		$this->transaccion='DIR_EMP_INS';
		$this->tipo_procedimiento='IME';
		
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo_sociedad','tipo_sociedad','varchar');
		$this->setParametro('actividad','actividad','text');
		$this->setParametro('actividad_esp','actividad_esp','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('actividad_gral','actividad_gral','varchar');
		$this->setParametro('domicilio','domicilio','text');
		$this->setParametro('matricula','matricula','int8');
		$this->setParametro('renovado','renovado','int4');
		$this->setParametro('actividad_prim','actividad_prim','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('departamento','departamento','varchar');
		$this->setParametro('telefono','telefono','varchar');
		$this->setParametro('municipio','municipio','varchar');
		$this->setParametro('estado_matricula','estado_matricula','varchar');
		$this->setParametro('mail','mail','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.f_empresa_ime';
		$this->transaccion='DIR_EMP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo_sociedad','tipo_sociedad','varchar');
		$this->setParametro('objeto','objeto','text');
		$this->setParametro('dir_comercial','dir_comercial','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('clase','clase','varchar');
		$this->setParametro('domicilio','domicilio','text');
		$this->setParametro('matricula','matricula','int8');
		$this->setParametro('renovado','renovado','int4');
		$this->setParametro('domicilio_legal','domicilio_legal','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('seccion','seccion','varchar');
		$this->setParametro('telefono','telefono','varchar');
		$this->setParametro('divission','divission','varchar');
		$this->setParametro('estado_matricula','estado_matricula','varchar');
		$this->setParametro('mail','mail','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEmpresa(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dir.f_empresa_ime';
		$this->transaccion='DIR_EMP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_empresa','id_empresa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>