<?php
/**
*@package pXP
*@file ACTCotizacion.php
*@author  Gonzalo Sarmiento Sejas
*@date 21-03-2013 14:48:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../../pxp/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RCotizacion.php');
require_once(dirname(__FILE__).'/../../pxp/pxpReport/DataSource.php');

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
	
	
	function reporteCotizacion(){
		  $dataSource = new DataSource();
    $idCotizacion = $this->objParam->getParametro('id_cotizacion');
    $this->objParam->addParametroConsulta('ordenacion','id_cotizacion');
    $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
    $this->objParam->addParametroConsulta('cantidad',1000);
    $this->objParam->addParametroConsulta('puntero',0);
    $this->objFunc = $this->create('MODCotizacion');
    $this->res = $this->objFunc->reporteCotizacion();
    $datosCotizacion = $this->res->getDatos();
 			
    //armamos el array parametros y metemos ahi los data sets de las otras tablas
    $dataSource->putParameter('estado', $datosCotizacion[0]['estado']);
				$dataSource->putParameter('fecha_adju', $datosCotizacion[0]['fecha_adju']);
    $dataSource->putParameter('fecha_venc', $datosCotizacion[0]['fecha_venc']);
				$dataSource->putParameter('fecha_coti', $datosCotizacion[0]['fecha_coti']);
    $dataSource->putParameter('fecha_entrega', $datosCotizacion[0]['fecha_entrega']);
    $dataSource->putParameter('id_moneda', $datosCotizacion[0]['id_moneda']);
    $dataSource->putParameter('moneda', $datosCotizacion[0]['moneda']);
				$dataSource->putParameter('id_proceso_compra', $datosCotizacion[0]['id_proceso_compra']);
				$dataSource->putParameter('codigo_proceso', $datosCotizacion[0]['codigo_proceso']);
    $dataSource->putParameter('num_cotizacion', $datosCotizacion[0]['num_cotizacion']);
				$dataSource->putParameter('num_tramite', $datosCotizacion[0]['num_tramite']);
    $dataSource->putParameter('id_proveedor', $datosCotizacion[0]['id_proveedor']);
				$dataSource->putParameter('desc_proveedor', $datosCotizacion[0]['desc_proveedor']);
    $dataSource->putParameter('lugar_entrega', $datosCotizacion[0]['lugar_entrega']);
    $dataSource->putParameter('nro_contrato', $datosCotizacion[0]['nro_contrato']);
				$dataSource->putParameter('numero_oc', $datosCotizacion[0]['numero_oc']);				
    $dataSource->putParameter('obs', $datosCotizacion[0]['obs']);
    $dataSource->putParameter('porc_anticipo', $datosCotizacion[0]['porc_anticipo']);
				$dataSource->putParameter('porc_retgar', $datosCotizacion[0]['porc_retgar']);
				$dataSource->putParameter('precio_total', $datosCotizacion[0]['precio_total']);
				$dataSource->putParameter('tipo_entrega', $datosCotizacion[0]['tipo_entrega']);
				
    //get detalle
    //Reset all extra params:
    $this->objParam->defecto('ordenacion', 'id_cotizacion_det');
    $this->objParam->defecto('cantidad', 1000);
    $this->objParam->defecto('puntero', 0);
    $this->objParam->addParametro('id_cotizacion', $idCotizacion );
    
    $modCotizacionDet = $this->create('MODCotizacionDet');
    $resultCotizacionDet = $modCotizacionDet->listarCotizacionDet();
				$cotizacionDetDataSource = new DataSource();
				$cotizacionDetDataSource->setDataSet($resultCotizacionDet->getDatos());
    $dataSource->putParameter('detalleDataSource', $cotizacionDetDataSource);
            
    //build the report
    $reporte = new RCotizacion();
    $reporte->setDataSource($dataSource);
    $nombreArchivo = 'Cotizacion.pdf';
    $reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
    $reportWriter->writeReport(ReportWriter::PDF);
    
    $mensajeExito = new Mensaje();
    $mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
                                    'Se generó con éxito el reporte: '.$nombreArchivo,'control');
    $mensajeExito->setArchivoGenerado($nombreArchivo);
    $this->res = $mensajeExito;
    $this->res->imprimirRespuesta($this->res->generarJson());			
   }

	
	function finalizarRegistro(){
        $this->objFunc=$this->create('MODCotizacion');  
        $this->res=$this->objFunc->finalizarRegistro($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
			
}

?>