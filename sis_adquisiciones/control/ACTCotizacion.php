<?php
/**
*@package pXP
*@file ACTCotizacion.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-03-2013 14:48:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCotizacion extends ACTbase{    
			
	function listarCotizacion(){
		$this->objParam->defecto('ordenacion','id_cotizacion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCotizacion','listarCotizacion');
		} else{
			$this->objFunc=$this->create('MODCotizacion');
			
			$this->res=$this->objFunc->listarCotizacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCotizacion(){
		$this->objFunc=$this->create('MODCotizacion');	
		if($this->objParam->insertar('id_cotizacion')){
			$this->res=$this->objFunc->insertarCotizacion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCotizacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCotizacion(){
			$this->objFunc=$this->create('MODCotizacion');	
		$this->res=$this->objFunc->eliminarCotizacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>