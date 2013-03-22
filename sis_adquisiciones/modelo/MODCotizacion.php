<?php
/**
*@package pXP
*@file MODCotizacion.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-03-2013 14:48:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCotizacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCotizacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='adq.f_cotizacion_sel';
		$this->transaccion='ADQ_COT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		$this->setParametro('id_proceso_compra','id_proceso_compra','int4');
		//Definicion de la lista del resultado del query
		$this->captura('id_cotizacion','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('lugar_entrega','varchar');
		$this->captura('tipo_entrega','varchar');
		$this->captura('fecha_coti','date');
		$this->captura('numero_oc','int4');
		$this->captura('id_proveedor','int4');
		$this->captura('desc_proveedor','varchar');
		$this->captura('porc_anticipo','numeric');
		$this->captura('precio_total','numeric');
		$this->captura('fecha_entrega','date');
		$this->captura('id_moneda','int4');
		$this->captura('moneda','varchar');
		$this->captura('id_proceso_compra','int4');
		$this->captura('fecha_venc','date');
		$this->captura('obs','text');
		$this->captura('fecha_adju','date');
		$this->captura('nro_contrato','varchar');
		$this->captura('porc_retgar','numeric');
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
			
	function insertarCotizacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_cotizacion_ime';
		$this->transaccion='ADQ_COT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('lugar_entrega','lugar_entrega','varchar');
		$this->setParametro('tipo_entrega','tipo_entrega','varchar');
		$this->setParametro('fecha_coti','fecha_coti','date');
		$this->setParametro('numero_oc','numero_oc','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('porc_anticipo','porc_anticipo','numeric');
		$this->setParametro('precio_total','precio_total','numeric');
		$this->setParametro('fecha_entrega','fecha_entrega','date');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('id_proceso_compra','id_proceso_compra','int4');
		$this->setParametro('fecha_venc','fecha_venc','date');
		$this->setParametro('obs','obs','text');
		$this->setParametro('fecha_adju','fecha_adju','date');
		$this->setParametro('nro_contrato','nro_contrato','varchar');
		$this->setParametro('porc_retgar','porc_retgar','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCotizacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_cotizacion_ime';
		$this->transaccion='ADQ_COT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cotizacion','id_cotizacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('lugar_entrega','lugar_entrega','varchar');
		$this->setParametro('tipo_entrega','tipo_entrega','varchar');
		$this->setParametro('fecha_coti','fecha_coti','date');
		$this->setParametro('numero_oc','numero_oc','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('porc_anticipo','porc_anticipo','numeric');
		$this->setParametro('precio_total','precio_total','numeric');
		$this->setParametro('fecha_entrega','fecha_entrega','date');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('id_proceso_compra','id_proceso_compra','int4');
		$this->setParametro('fecha_venc','fecha_venc','date');
		$this->setParametro('obs','obs','text');
		$this->setParametro('fecha_adju','fecha_adju','date');
		$this->setParametro('nro_contrato','nro_contrato','varchar');
		$this->setParametro('porc_retgar','porc_retgar','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCotizacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_cotizacion_ime';
		$this->transaccion='ADQ_COT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cotizacion','id_cotizacion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>