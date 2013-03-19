<?php
/**
*@package pXP
*@file gen-ACTSolicitud.php
*@author  (admin)
*@date 19-02-2013 12:12:51
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../../pxp/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RSolicitudCompra.php');
require_once(dirname(__FILE__).'/../../pxp/pxpReport/DataSource.php');

class ACTSolicitud extends ACTbase{    
			
	function listarSolicitud(){
		$this->objParam->defecto('ordenacion','id_solicitud');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_depto')!=''){
            $this->objParam->addFiltro("sol.id_depto = ".$this->objParam->getParametro('id_depto'));    
        }
        
        if($this->objParam->getParametro('estado')!=''){
            $this->objParam->addFiltro("sol.estado = ''".$this->objParam->getParametro('estado')."''");    
        }
		
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

 function reporteSolicitud(){
    $dataSource = new DataSource();
    $idSolicitud = $this->objParam->getParametro('id_solicitud');
    //$this->objParam->addParametroConsulta('id_plan_mant',$idPlanMant);
    $this->objParam->addParametroConsulta('ordenacion','id_solicitud');
    $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
    $this->objParam->addParametroConsulta('cantidad',1000);
    $this->objParam->addParametroConsulta('puntero',0);
    $this->objFunc = $this->create('MODSolicitud');
    $resultSolicitud = $this->objFunc->reporteSolicitud();
    $datosSolicitud = $resultSolicitud->getDatos();
 			
    //armamos el array parametros y metemos ahi los data sets de las otras tablas
    $dataSource->putParameter('id_solicitud', $datosSolicitud[0]['id_solicitud']);
				$dataSource->putParameter('numero', $datosSolicitud[0]['numero']);
    $dataSource->putParameter('fecha_apro', $datosSolicitud[0]['fecha_apro']);
    $dataSource->putParameter('desc_moneda', $datosSolicitud[0]['desc_moneda']);
    $dataSource->putParameter('tipo', $datosSolicitud[0]['tipo']);
				$dataSource->putParameter('desc_gestion', $datosSolicitud[0]['desc_gestion']);
    $dataSource->putParameter('fecha_soli', $datosSolicitud[0]['fecha_soli']);
				$dataSource->putParameter('desc_categoria_compra', $datosSolicitud[0]['desc_categoria_compra']);
    
    $dataSource->putParameter('desc_proceso_macro', $datosSolicitud[0]['desc_proceso_macro']);
    $dataSource->putParameter('desc_funcionario', $datosSolicitud[0]['desc_funcionario']);
    $dataSource->putParameter('desc_uo', $datosSolicitud[0]['desc_uo']);
				$dataSource->putParameter('desc_depto', $datosSolicitud[0]['desc_depto']);
				
    $dataSource->putParameter('justificacion', $datosSolicitud[0]['justificacion']);
    $dataSource->putParameter('lugar_entrega', $datosSolicitud[0]['lugar_entrega']);
				$dataSource->putParameter('comite_calificacion', $datosSolicitud[0]['comite_calificacion']);
				$dataSource->putParameter('posibles_proveedores', $datosSolicitud[0]['posibles_proveedores']);
				$dataSource->putParameter('desc_funcionario_apro', $datosSolicitud[0]['desc_funcionario_apro']);
				
    //get detalle
    //Reset all extra params:
    $this->objParam->defecto('ordenacion', 'id_solicitud_det');
    $this->objParam->defecto('cantidad', 1000);
    $this->objParam->defecto('puntero', 0);
    $this->objParam->addParametro('id_solicitud', $idSolicitud );
    
    $modSolicitudDet = $this->create('MODSolicitudDet');
    $resultSolicitudDet = $modSolicitudDet->listarSolicitudDet();
				$solicitudDetAgrupado = $this->groupArray($resultSolicitudDet->getDatos(), 'codigo_partida','desc_centro_costo');
    $solicitudDetDataSource = new DataSource();
				$solicitudDetDataSource->setDataSet($solicitudDetAgrupado);
    $dataSource->putParameter('detalleDataSource', $solicitudDetDataSource);
            
    //build the report
    $reporte = new RSolicitudCompra();
    $reporte->setDataSource($dataSource);
    $nombreArchivo = 'SolicitudCompra.pdf';
    $reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
    $reportWriter->writeReport(ReportWriter::PDF);
    
    $mensajeExito = new Mensaje();
    $mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
                                    'Se generó con éxito el reporte: '.$nombreArchivo,'control');
    $mensajeExito->setArchivoGenerado($nombreArchivo);
    $this->res = $mensajeExito;
    $this->res->imprimirRespuesta($this->res->generarJson());

    }

    
    function siguienteEstadoSolicitud(){
        $this->objFunc=$this->create('MODSolicitud');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->siguienteEstadoSolicitud($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function anteriorEstadoSolicitud(){
        $this->objFunc=$this->create('MODSolicitud');  
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        $this->res=$this->objFunc->anteriorEstadoSolicitud($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
   function groupArray($array,$groupkey,$groupkeyTwo)
	{
	 if (count($array)>0)
	 {
	 	$keys = array_keys($array[0]);
	 	$removekey = array_search($groupkey, $keys);
	 	$removekeyTwo = array_search($groupkeyTwo, $keys);
			if ($removekey===false)
	 		return array("Clave \"$groupkey\" no existe");
			if($removekeyTwo===false)
	 		return array("Clave \"$groupkeyTwo\" no existe");
	 	$groupcriteria = array();
	 	$arrayResp=array();
	 	foreach($array as $value)
	 	{
	 		$item=null;
	 		foreach ($keys as $key)
	 		{
	 			$item[$key] = $value[$key];
	 		}
	 	 	$busca = array_search($value[$groupkey].$value[$groupkeyTwo], $groupcriteria);
	 		if ($busca === false)
	 		{
	 			$groupcriteria[]=$value[$groupkey].$value[$groupkeyTwo];
	 			$arrayResp[]=array($groupkey.$groupkeyTwo=>$value[$groupkey].$value[$groupkeyTwo],'groupeddata'=>array());
	 			$busca=count($arrayResp)-1;
	 		}
	 		$arrayResp[$busca]['groupeddata'][]=$item;
	 	}
	 	return $arrayResp;
	 }
	 else
	 	return array();
	}			
}

?>