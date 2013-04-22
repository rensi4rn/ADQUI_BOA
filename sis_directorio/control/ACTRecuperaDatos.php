<?php
include_once 'simple_html_dom.php';

class ACTRecuperaDatos extends ACTbase{
		function recuperarDatos(){
				/*
				$this->objParam->addParametro('matricula',$matricula);
				$this->objParam->addParametro('nombre',$nombre);
				$this->objParam->addParametro('tipo_sociedad',$tipo_sociedad);
				$this->objParam->addParametro('nit',$nit);
				$this->objParam->addParametro('telefono',$telefono);
				$this->objParam->addParametro('mail',$mail);
				 * */
				$this->objFunc=$this->create('MODEmpresa');
				$objetoFuncion = $this->create('MODEmpresa');
				$this->res=$this->objFunc->insertarEmpresa($this->objParam);	//esta bien			
				$this->res->imprimirRespuesta($this->res->generarJson());
		} 
		
		function insertarEmpresa(){
			for ($i = 103001; $i <= 106000; $i++) {
	$idx = md5('00'.$i);
	//echo 'ID: '.$idx;
	
	//URL de prueba desde la que se extraen los datos 
	$url = 'http://www.fundempresa.org.bo/directorio/ver-mas.php?id='.$idx.'&seccion=0&division=00&clase=000&rubro=&depto=03&page=1&searchSW=2';
	$html = file_get_html($url);
	//Creacion del DOM a partir de la URL
	
	$array1 = $html->find('span[class=color2]');
	$array2 = $html->find('div[class=empresaData]');
	if(count($array1)==0)		continue;
	$arrayEmpresa= array();
	//Desplegar los datos extraidos
	while (list($key, $value) = each($array1)){
		list($key2, $value2) = each($array2);	
		//var_dump($value2->plaintext."\n");
		//echo ($key + 1).'. '.$value->plaintext."   ".$value2->plaintext."<br />\n";
		
		array_push($arrayEmpresa,str_replace('-', '', trim($value2->plaintext)));
	}
			if(count($arrayEmpresa)!=0){
				  //var_dump($arrayEmpresa);
						$parametro = new CTParametro(null,null,array());
						$parametro->addParametro('matricula',$arrayEmpresa[0]);
						$parametro->addParametro('nombre',$arrayEmpresa[1]);
						$parametro->addParametro('actividad',$arrayEmpresa[2]);
						$parametro->addParametro('tipo_sociedad',$arrayEmpresa[3]);
						$parametro->addParametro('contacto',$arrayEmpresa[4]);
						$parametro->addParametro('nit',$arrayEmpresa[5]);
						$parametro->addParametro('licencia',$arrayEmpresa[6]);
						$parametro->addParametro('departamento',$arrayEmpresa[7]);
						$parametro->addParametro('municipio',$arrayEmpresa[8]);						
						$parametro->addParametro('domicilio',$arrayEmpresa[9]);
						$parametro->addParametro('telefono',$arrayEmpresa[10]);
						$parametro->addParametro('fax',$arrayEmpresa[11]);
						$parametro->addParametro('mail',$arrayEmpresa[12]);
						$parametro->addParametro('actividad_gral',$arrayEmpresa[13]);
						$parametro->addParametro('actividad_prim',$arrayEmpresa[14]);
						$parametro->addParametro('actividad_esp',$arrayEmpresa[15]);
						
								$this->objParam = $parametro;	
							 $this->objFunc=$this->create('MODEmpresa');
							if($this->objParam->insertar('id_empresa')){
								$this->res=$this->objFunc->insertarEmpresa();			
							} else{
								$this->res=$this->objFunc->modificarEmpresa($this->objParam);
							}
							//echo "<br />\n"."********************************************************************************<br />\n";
							unset($parametro);
							unset($this->objFunc);
				}
  }

		//$this->res->imprimirRespuesta($this->res->generarJson());
	}
}
?>