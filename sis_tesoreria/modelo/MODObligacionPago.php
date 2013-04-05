<?php
/**
*@package pXP
*@file MODObligacionPago.php
*@author  Gonzalo Sarmiento Sejas
*@date 02-04-2013 16:01:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODObligacionPago extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarObligacionPago(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='tes.ft_obligacion_pago_sel';
		$this->transaccion='TES_OBPG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_obligacion_pago','int4');
		$this->captura('id_proveedor','int4');
		$this->captura('desc_proveedor','varchar');
		$this->captura('estado','varchar');
		$this->captura('tipo_obligacion','varchar');
		$this->captura('id_moneda','int4');
		$this->captura('moneda','varchar');
		$this->captura('obs','varchar');
		$this->captura('porc_retgar','numeric');
		$this->captura('id_subsistema','int4');
		$this->captura('nombre_subsistema','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('desc_funcionario1','text');
		$this->captura('estado_reg','varchar');
		$this->captura('porc_anticipo','numeric');
		$this->captura('id_estado_wf','int4');
		$this->captura('id_depto','int4');
		$this->captura('nombre_depto','varchar');
		$this->captura('num_tramite','varchar');
		$this->captura('id_proceso_wf','int4');
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
			
	function insertarObligacionPago(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tes.ft_obligacion_pago_ime';
		$this->transaccion='TES_OBPG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tipo_obligacion','tipo_obligacion','varchar');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('porc_retgar','porc_retgar','numeric');
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porc_anticipo','porc_anticipo','numeric');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('num_tramite','num_tramite','varchar');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarObligacionPago(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tes.ft_obligacion_pago_ime';
		$this->transaccion='TES_OBPG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_obligacion_pago','id_obligacion_pago','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tipo_obligacion','tipo_obligacion','varchar');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('porc_retgar','porc_retgar','numeric');
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porc_anticipo','porc_anticipo','numeric');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('num_tramite','num_tramite','varchar');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarObligacionPago(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tes.ft_obligacion_pago_ime';
		$this->transaccion='TES_OBPG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_obligacion_pago','id_obligacion_pago','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>