<?php
/**
*@package pXP
*@file gen-ACTTipoComunicacion.php
*@author  (admin)
*@date 08-01-2013 19:18:16
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoComunicacion extends ACTbase{    
			
	function listarTipoComunicacion(){
		$this->objParam->defecto('ordenacion','id_tiipo_comunicacion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoComunicacion','listarTipoComunicacion');
		} else{
			$this->objFunc=$this->create('MODTipoComunicacion');
			
			$this->res=$this->objFunc->listarTipoComunicacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoComunicacion(){
		$this->objFunc=$this->create('MODTipoComunicacion');	
		if($this->objParam->insertar('id_tiipo_comunicacion')){
			$this->res=$this->objFunc->insertarTipoComunicacion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoComunicacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoComunicacion(){
			$this->objFunc=$this->create('MODTipoComunicacion');	
		$this->res=$this->objFunc->eliminarTipoComunicacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>