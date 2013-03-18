<?php
/**
*@package pXP
*@file gen-ACTEmpresa.php
*@author  (admin)
*@date 15-03-2013 21:40:25
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEmpresa extends ACTbase{    
			
	function listarEmpresa(){
		$this->objParam->defecto('ordenacion','id_empresa');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEmpresa','listarEmpresa');
		} else{
			$this->objFunc=$this->create('MODEmpresa');
			
			$this->res=$this->objFunc->listarEmpresa($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEmpresa(){
		$this->objFunc=$this->create('MODEmpresa');	
		if($this->objParam->insertar('id_empresa')){
			$this->res=$this->objFunc->insertarEmpresa($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEmpresa($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEmpresa(){
			$this->objFunc=$this->create('MODEmpresa');	
		$this->res=$this->objFunc->eliminarEmpresa($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>