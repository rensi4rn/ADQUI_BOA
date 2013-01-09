<?php
/**
*@package pXP
*@file gen-ACTPersonaComunicacion.php
*@author  (admin)
*@date 08-01-2013 19:45:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPersonaComunicacion extends ACTbase{    
			
	function listarPersonaComunicacion(){
		$this->objParam->defecto('ordenacion','id_persona_comunicacion');
      
	    if($this->objParam->getParametro('id_persona')!=''){
	    	$this->objParam->addFiltro("percom.id_persona = ".$this->objParam->getParametro('id_persona'));	
		}
		
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPersonaComunicacion','listarPersonaComunicacion');
		} else{
			$this->objFunc=$this->create('MODPersonaComunicacion');
			
			$this->res=$this->objFunc->listarPersonaComunicacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPersonaComunicacion(){
		$this->objFunc=$this->create('MODPersonaComunicacion');	
		if($this->objParam->insertar('id_persona_comunicacion')){
			$this->res=$this->objFunc->insertarPersonaComunicacion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPersonaComunicacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPersonaComunicacion(){
			$this->objFunc=$this->create('MODPersonaComunicacion');	
		$this->res=$this->objFunc->eliminarPersonaComunicacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>