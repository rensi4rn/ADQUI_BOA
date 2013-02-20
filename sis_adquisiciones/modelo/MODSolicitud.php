<?php
/**
*@package pXP
*@file gen-MODSolicitud.php
*@author  (admin)
*@date 19-02-2013 12:12:51
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODSolicitud extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarSolicitud(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='adq.f_solicitud_sel';
		$this->transaccion='ADQ_SOL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_solicitud','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_solicitud_ext','int4');
		$this->captura('presu_revertido','varchar');
		$this->captura('fecha_apro','date');
		$this->captura('estado','varchar');
		$this->captura('id_funcionario_aprobador','int4');
		$this->captura('id_moneda','int4');
		$this->captura('id_gestion','int4');
		$this->captura('tipo','varchar');
		$this->captura('num_tramite','varchar');
		$this->captura('justificacion','text');
		$this->captura('id_depto','int4');
		$this->captura('lugar_entrega','varchar');
		$this->captura('extendida','varchar');
		$this->captura('numero','varchar');
		$this->captura('posibles_proveedores','text');
		$this->captura('id_proceso_wf','int4');
		$this->captura('comite_calificacion','text');
		$this->captura('id_categoria_compra','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('id_estado_wf','int4');
		$this->captura('fecha_soli','date');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('desc_funcionario','text');
		$this->captura('desc_funcionario_apro','text');
		$this->captura('desc_uo','varchar');
		$this->captura('desc_gestion','integer');
		$this->captura('desc_moneda','varchar');
		$this->captura('desc_depto','varchar');
		
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarSolicitud(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_solicitud_ime';
		$this->transaccion='ADQ_SOL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_solicitud_ext','id_solicitud_ext','int4');
		$this->setParametro('presu_revertido','presu_revertido','varchar');
		$this->setParametro('fecha_apro','fecha_apro','date');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('id_funcionario_aprobador','id_funcionario_aprobador','int4');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('num_tramite','num_tramite','varchar');
		$this->setParametro('justificacion','justificacion','text');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('lugar_entrega','lugar_entrega','varchar');
		$this->setParametro('extendida','extendida','varchar');
		$this->setParametro('numero','numero','varchar');
		$this->setParametro('posibles_proveedores','posibles_proveedores','text');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('comite_calificacion','comite_calificacion','text');
		$this->setParametro('id_categoria_compra','id_categoria_compra','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('fecha_soli','fecha_soli','date');
		
		$this->setParametro('id_uo','id_uo','int4');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarSolicitud(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_solicitud_ime';
		$this->transaccion='ADQ_SOL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_solicitud','id_solicitud','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_solicitud_ext','id_solicitud_ext','int4');
		$this->setParametro('presu_revertido','presu_revertido','varchar');
		$this->setParametro('fecha_apro','fecha_apro','date');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('id_funcionario_aprobador','id_funcionario_aprobador','int4');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('num_tramite','num_tramite','varchar');
		$this->setParametro('justificacion','justificacion','text');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('lugar_entrega','lugar_entrega','varchar');
		$this->setParametro('extendida','extendida','varchar');
		$this->setParametro('numero','numero','varchar');
		$this->setParametro('posibles_proveedores','posibles_proveedores','text');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('comite_calificacion','comite_calificacion','text');
		$this->setParametro('id_categoria_compra','id_categoria_compra','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('fecha_soli','fecha_soli','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarSolicitud(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_solicitud_ime';
		$this->transaccion='ADQ_SOL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_solicitud','id_solicitud','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>