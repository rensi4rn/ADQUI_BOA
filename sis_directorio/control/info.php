<?php
    // Inicia o cURL acessando uma URL
    $cURL = curl_init('http://blog.thiagobelem.net/robots.txt');
    // Define a opção que diz que você quer receber o resultado encontrado
    curl_setopt($cURL, CURLOPT_RETURNTRANSFER, true);
    // Executa a consulta, conectando-se ao site e salvando o resultado na variável $resultado
    $resultado = curl_exec($cURL);
    // Encerra a conexão com o site
    curl_close($cURL);
?>