<?php
/**
*@package pXP
*@file MODCuenta.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-02-2013 15:04:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCuenta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCuenta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='conta.f_cuenta_sel';
		$this->transaccion='CONTA_CTA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_cuenta','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('vigente','varchar');
		$this->captura('nombre_cuenta','varchar');
		$this->captura('sw_oec','int4');
		$this->captura('sw_auxiliar','int4');
		$this->captura('nivel_cuenta','int4');
		$this->captura('tipo_cuenta','varchar');
		$this->captura('id_empresa','int4');
		$this->captura('id_cuenta_padre','int4');
		$this->captura('nombre_cuenta_padre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_auxiliar_dif','int4');
		$this->captura('tipo_plantilla','varchar');
		$this->captura('desc_cuenta','varchar');
		$this->captura('sw_sigma','varchar');
		$this->captura('cuenta_sigma','varchar');
		$this->captura('tipo_cuenta_pat','varchar');
		$this->captura('obs','varchar');
		$this->captura('sw_sistema_actualizacion','varchar');
		$this->captura('id_cuenta_actualizacion','int4');
		$this->captura('id_parametro','int4');
		$this->captura('id_auxliar_actualizacion','int4');
		$this->captura('plantilla','varchar');
		$this->captura('nro_cuenta','varchar');
		$this->captura('id_moneda','int4');
		$this->captura('cuenta_flujo_sigma','varchar');
		$this->captura('id_cuenta_dif','int4');
		$this->captura('id_cuenta_sigma','int4');
		$this->captura('sw_transaccional','varchar');
		$this->captura('id_gestion','int4');
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
			
	function insertarCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='conta.f_cuenta_ime';
		$this->transaccion='CONTA_CTA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('vigente','vigente','varchar');
		$this->setParametro('nombre_cuenta','nombre_cuenta','varchar');
		$this->setParametro('sw_oec','sw_oec','int4');
		$this->setParametro('sw_auxiliar','sw_auxiliar','int4');
		$this->setParametro('nivel_cuenta','nivel_cuenta','int4');
		$this->setParametro('tipo_cuenta','tipo_cuenta','varchar');
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('id_cuenta_padre','id_cuenta_padre','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_auxiliar_dif','id_auxiliar_dif','int4');
		$this->setParametro('tipo_plantilla','tipo_plantilla','varchar');
		$this->setParametro('desc_cuenta','desc_cuenta','varchar');
		$this->setParametro('sw_sigma','sw_sigma','varchar');
		$this->setParametro('cuenta_sigma','cuenta_sigma','varchar');
		$this->setParametro('tipo_cuenta_pat','tipo_cuenta_pat','varchar');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('sw_sistema_actualizacion','sw_sistema_actualizacion','varchar');
		$this->setParametro('id_cuenta_actualizacion','id_cuenta_actualizacion','int4');
		$this->setParametro('id_parametro','id_parametro','int4');
		$this->setParametro('id_auxliar_actualizacion','id_auxliar_actualizacion','int4');
		$this->setParametro('plantilla','plantilla','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('cuenta_flujo_sigma','cuenta_flujo_sigma','varchar');
		$this->setParametro('id_cuenta_dif','id_cuenta_dif','int4');
		$this->setParametro('id_cuenta_sigma','id_cuenta_sigma','int4');
		$this->setParametro('sw_transaccional','sw_transaccional','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='conta.f_cuenta_ime';
		$this->transaccion='CONTA_CTA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cuenta','id_cuenta','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('vigente','vigente','varchar');
		$this->setParametro('nombre_cuenta','nombre_cuenta','varchar');
		$this->setParametro('sw_oec','sw_oec','int4');
		$this->setParametro('sw_auxiliar','sw_auxiliar','int4');
		$this->setParametro('nivel_cuenta','nivel_cuenta','int4');
		$this->setParametro('tipo_cuenta','tipo_cuenta','varchar');
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('id_cuenta_padre','id_cuenta_padre','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_auxiliar_dif','id_auxiliar_dif','int4');
		$this->setParametro('tipo_plantilla','tipo_plantilla','varchar');
		$this->setParametro('desc_cuenta','desc_cuenta','varchar');
		$this->setParametro('sw_sigma','sw_sigma','varchar');
		$this->setParametro('cuenta_sigma','cuenta_sigma','varchar');
		$this->setParametro('tipo_cuenta_pat','tipo_cuenta_pat','varchar');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('sw_sistema_actualizacion','sw_sistema_actualizacion','varchar');
		$this->setParametro('id_cuenta_actualizacion','id_cuenta_actualizacion','int4');
		$this->setParametro('id_parametro','id_parametro','int4');
		$this->setParametro('id_auxliar_actualizacion','id_auxliar_actualizacion','int4');
		$this->setParametro('plantilla','plantilla','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('cuenta_flujo_sigma','cuenta_flujo_sigma','varchar');
		$this->setParametro('id_cuenta_dif','id_cuenta_dif','int4');
		$this->setParametro('id_cuenta_sigma','id_cuenta_sigma','int4');
		$this->setParametro('sw_transaccional','sw_transaccional','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='conta.f_cuenta_ime';
		$this->transaccion='CONTA_CTA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cuenta','id_cuenta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>