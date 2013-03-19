<?php
/**
*@package pXP
*@file gen-ACTProcesoCompra.php
*@author  (admin)
*@date 19-03-2013 12:55:30
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProcesoCompra extends ACTbase{    
			
	function listarProcesoCompra(){
		$this->objParam->defecto('ordenacion','id_proceso_compra');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProcesoCompra','listarProcesoCompra');
		} else{
			$this->objFunc=$this->create('MODProcesoCompra');
			
			$this->res=$this->objFunc->listarProcesoCompra($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProcesoCompra(){
		$this->objFunc=$this->create('MODProcesoCompra');	
		if($this->objParam->insertar('id_proceso_compra')){
			$this->res=$this->objFunc->insertarProcesoCompra($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProcesoCompra($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProcesoCompra(){
			$this->objFunc=$this->create('MODProcesoCompra');	
		$this->res=$this->objFunc->eliminarProcesoCompra($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>