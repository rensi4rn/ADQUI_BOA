<?php
/**
*@package pXP
*@file ACTCuenta.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-02-2013 15:04:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCuenta extends ACTbase{    
			
	function listarCuenta(){
		$this->objParam->defecto('ordenacion','id_cuenta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCuenta','listarCuenta');
		} else{
			$this->objFunc=$this->create('MODCuenta');
			
			$this->res=$this->objFunc->listarCuenta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCuenta(){
		$this->objFunc=$this->create('MODCuenta');	
		if($this->objParam->insertar('id_cuenta')){
			$this->res=$this->objFunc->insertarCuenta($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCuenta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCuenta(){
			$this->objFunc=$this->create('MODCuenta');	
		$this->res=$this->objFunc->eliminarCuenta($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>