<?php
/**
*@package pXP
*@file gen-ACTSolicitud.php
*@author  (admin)
*@date 19-02-2013 12:12:51
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTSolicitud extends ACTbase{    
			
	function listarSolicitud(){
		$this->objParam->defecto('ordenacion','id_solicitud');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		//var_dump($_SESSION["ss_id_funcionario"]);
		
		 $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODSolicitud','listarSolicitud');
		} else{
			$this->objFunc=$this->create('MODSolicitud');
			
			$this->res=$this->objFunc->listarSolicitud($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	
	
				
	function insertarSolicitud(){
		$this->objFunc=$this->create('MODSolicitud');	
		if($this->objParam->insertar('id_solicitud')){
			$this->res=$this->objFunc->insertarSolicitud($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarSolicitud($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSolicitud(){
			$this->objFunc=$this->create('MODSolicitud');	
		$this->res=$this->objFunc->eliminarSolicitud($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function finalizarSolicitud(){
            $this->objFunc=$this->create('MODSolicitud');   
        $this->res=$this->objFunc->finalizarSolicitud($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function siguienteEstadoSolicitud(){
        $this->objFunc=$this->create('MODSolicitud');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->siguienteEstadoSolicitud($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    
    
    
			
}

?>