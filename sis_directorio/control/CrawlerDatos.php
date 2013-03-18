<?php 
/*Script CrawlerDatos
 * Descripcion: Script para extraer datos de una pagina web online en base a criterios
 * 				de  tag y estilos.
 * Autor: Freddy Rojas
 */
include 'simple_html_dom.php';
//Datos analizados de la pagina fundaempresa.com
//primer ID: 00100001   -->  bb318ba55e89aa1f5c21e00a52f71ae8
//limite superior: 00142001

//Obtener las empresas que tienen el ID  en el rango definido a cntinuacion
for ($i = 100001; $i <= 100003; $i++) {
	$idx = md5('00'.$i);
	//echo 'ID: '.$idx;
	
	//URL de prueba desde la que se extraen los datos 
	$url = 'http://www.fundempresa.org.bo/directorio/ver-mas.php?id='.$idx.'&seccion=0&division=00&clase=000&rubro=&depto=03&page=1&searchSW=2';
	
	$html = file_get_html($url);
	
	//Creacion del DOM a partir de la URL
	
	$array1 = $html->find('span[class=color2]');
	$array2 = $html->find('div[class=empresaData]');
	
	//Desplegar los datos extraidos
	while (list($key, $value) = each($array1)){
		list($key2, $value2) = each($array2);	
		echo ($key + 1).'. '.$value->plaintext."   ".$value2->plaintext."<br />\n";
	}
	
	echo "<br />\n"."********************************************************************************<br />\n";
}



?>