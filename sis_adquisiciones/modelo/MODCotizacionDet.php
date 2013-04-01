<?php
/**
*@package pXP
*@file MODCotizacionDet.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-03-2013 21:44:43
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCotizacionDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCotizacionDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='adq.f_cotizacion_det_sel';
		$this->transaccion='ADQ_CTD_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
			
		$this->setParametro('id_cotizacion','id_cotizacion','int4');	
		//Definicion de la lista del resultado del query
		$this->captura('id_cotizacion_det','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_cotizacion','int4');
		$this->captura('precio_unitario','numeric');
		$this->captura('cantidad_adju','numeric');
		$this->captura('cantidad_coti','numeric');
		$this->captura('obs','varchar');
		$this->captura('id_solicitud_det','int4');
		$this->captura('desc_solicitud_det','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		
		$this->captura('desc_centro_costo','text');
        $this->captura('cantidad_sol','integer');
        $this->captura('precio_unitario_sol','numeric');
        $this->captura('descripcion_sol','text'); 
        $this->captura('precio_unitario_mb','numeric');
        $this->captura('precio_unitario_mb_sol','numeric');
		
	
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCotizacionDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_cotizacion_det_ime';
		$this->transaccion='ADQ_CTD_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_cotizacion','id_cotizacion','int4');
		$this->setParametro('precio_unitario','precio_unitario','numeric');
		$this->setParametro('cantidad_adju','cantidad_adju','numeric');
		$this->setParametro('cantidad_coti','cantidad_coti','numeric');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('id_solicitud_det','id_solicitud_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCotizacionDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_cotizacion_det_ime';
		$this->transaccion='ADQ_CTD_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_cotizacion','id_cotizacion','int4');
		$this->setParametro('precio_unitario','precio_unitario','numeric');
		$this->setParametro('cantidad_adju','cantidad_adju','numeric');
		$this->setParametro('cantidad_coti','cantidad_coti','numeric');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('id_solicitud_det','id_solicitud_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCotizacionDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='adq.f_cotizacion_det_ime';
		$this->transaccion='ADQ_CTD_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function totalAdjudicado(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='adq.f_cotizacion_det_ime';
        $this->transaccion='ADQ_TOTALADJ_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
    function AdjudicarDetalle(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='adq.f_cotizacion_det_ime';
        $this->transaccion='ADQ_ADJDET_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');
        $this->setParametro('cantidad_adjudicada','cantidad_adjudicada','int4');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }	
	
			
}
?>