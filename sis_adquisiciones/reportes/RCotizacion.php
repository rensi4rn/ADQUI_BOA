<?php
require_once dirname(__FILE__).'/../../pxp/pxpReport/Report.php';

 class CustomReport extends TCPDF {
    
    private $dataSource;
    
    public function setDataSource(DataSource $dataSource) {
        $this->dataSource = $dataSource;
    }
    
    public function getDataSource() {
        return $this->dataSource;
    }
    
    public function Header() {
        $height = 20;
								$this->Image(dirname(__FILE__).'/boa-airline-logo.jpg', $x+10, $y+10, 36);
        $this->Cell(20, $height, '', 0, 0, 'C', false, '', 1, false, 'T', 'C');
								
        $this->SetFontSize(16);
        $this->SetFont('','B');        
        $this->Cell(145, $height, 'Solicitud de Cotización', 0, 0, 'C', false, '', 1, false, 'T', 'C');        
        
								$x=$this->getX();
								$y=$this->getY();
								$this->setXY($x,$y-10);
								$this->SetFontSize(6);
								$this->SetFont('', 'B');
								$this->Cell(20, $height, 'Localidad', 0, 0, 'L', false, '', 1, false, 'T', 'C');
								$this->setXY($x,$y-7);
								$this->SetFontSize(7);
								$this->setFont('','');
								$this->Cell(20, $height, strtoupper($this->getDataSource()->getParameter('lugar_entrega')), 0, 0, 'L', false, '', 1, false, 'T', 'C');
								$this->setXY($x,$y+5);
								$this->setFont('','');
								$this->Cell(6, $height/5, 'Dia', 1, 0, 'L', false, '', 1, false, 'T', 'C');
								$this->Cell(6, $height/5, 'Mes', 1, 0, 'L', false, '', 1, false, 'T', 'C');
								$this->Cell(7, $height/5, 'Año', 1, 0, 'L', false, '', 1, false, 'T', 'C');
								$this->setXY($x,$y+9);
								$fecha_coti = explode('-', $this->getDataSource()->getParameter('fecha_coti'));
								$this->Cell(6, $height/4, $fecha_coti[2], 1, 0, 'C', false, '', 1, false, 'T', 'C');
								$this->Cell(6, $height/4, $fecha_coti[1], 1, 0, 'C', false, '', 1, false, 'T', 'C');
								$this->Cell(7, $height/4, $fecha_coti[0], 1, 0, 'C', false, '', 1, false, 'T', 'C');								
    }
    
    public function Footer() {
        $this->SetFontSize(5.5);
								$this->setY(-10);
								$ormargins = $this->getOriginalMargins();
								$this->SetTextColor(0, 0, 0);
								//set style for cell border
								$line_width = 0.85 / $this->getScaleFactor();
								$this->SetLineStyle(array('width' => $line_width, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0)));
								$ancho = round(($this->getPageWidth() - $ormargins['left'] - $ormargins['right']) / 3);
								$this->Ln(2);
								$cur_y = $this->GetY();
								//$this->Cell($ancho, 0, 'Generado por XPHS', 'T', 0, 'L');
								$this->Cell($ancho, 0, 'Usuario: '.$_SESSION['_LOGIN'], '', 1, 'L');
								$pagenumtxt = 'Página'.' '.$this->getAliasNumPage().' de '.$this->getAliasNbPages();
								//$this->Cell($ancho, 0, '', '', 0, 'C');
								$fecha_rep = date("d-m-Y H:i:s");
								$this->Cell($ancho, 0, "Fecha impresión: ".$fecha_rep, '', 0, 'L');
								$this->Ln($line_width);
			 }
}

Class RCotizacion extends Report {

    function write($fileName) {
        $pdf = new CustomReport('P', PDF_UNIT, "LETTER", true, 'UTF-8', false);
        $pdf->setDataSource($this->getDataSource());
        // set document information
        $pdf->SetCreator(PDF_CREATOR);
        
        // set default monospaced font
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        
        //set margins
        $pdf->SetMargins(PDF_MARGIN_LEFT, 40, PDF_MARGIN_RIGHT);
        $pdf->SetHeaderMargin(10);
        $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
        
        //set auto page breaks
        $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
        
        //set image scale factor
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
        
        //set some language-dependent strings
        
        // add a page
        $pdf->AddPage();
        
        $height = 5;
        $width1 = 15;
        $width2 = 20;
        $width3 = 35;
        $width4 = 75;
        
								$white = array('LTRB' =>array('width' => 0.3, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255, 255, 255)));
								$black = array('T' =>array('width' => 0.3, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0)));
								$pdf->SetFontSize(7);
								$pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Señores:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width4+$width3+$width2, $height, $this->getDataSource()->getParameter('desc_proveedor'), $white, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
								$pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Telf.:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
								$pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('telefono1'), $white, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Dirección:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width4+$width3+$width2, $height, $this->getDataSource()->getParameter('direccion'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Telf. 2:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('telefono2'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Ciudad:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width4+$width3+$width2, $height, $this->getDataSource()->getParameter('lugar_entrega'), $white, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
								$pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Celular:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
								$pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('celular'), $white, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Email:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width4+$width3+$width2, $height, $this->getDataSource()->getParameter('email'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Fax:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('fax'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->Ln();
								$pdf->SetFontSize(10);
								$pdf->SetFont('', 'B');								
								$pdf->MultiCell(0, $height, 'Agradecemos a Ud.(s) cotizar el siguiente material con IMPUESTOS INCLUIDOS, indicando plazo de entrega y validez de su oferta hasta el '.$this->getDataSource()->getParameter('fecha_venc'), 1,'L', false ,1);
								
								$this->writeDetalles($this->getDataSource()->getParameter('detalleDataSource'), $pdf);
        
        $pdf->SetFont('', 'B');
        $pdf->Cell($width4+$width3*2+$width2, $height, 'IMPORTE TOTAL:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
								$pdf->SetFont('', '');
								$pdf->Cell($width2, $height, $this->getDataSource()->getParameter('precio_total'), 1, 0, 'R', true, '', 0, false, 'T', 'C');
								$pdf->Ln();
								
								$pdf->SetFontSize(9);
								$pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($width3, $height, 'Plazo de Entrega:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width3+$width2, $height, $this->getDataSource()->getParameter('fecha_entrega'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->Cell($width3, $height, 'Moneda:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width3+$width2, $height, $this->getDataSource()->getParameter('moneda'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($width3, $height, 'Validez de la oferta:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width3+$width2, $height, $this->getDataSource()->getParameter(''), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->Cell($width3, $height, 'Lugar de Entrega:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width3+$width2, $height, $this->getDataSource()->getParameter('lugar_entrega'), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($width3, $height, 'Forma de Pago:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width3+$width2, $height, $this->getDataSource()->getParameter(''), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Cell(5, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->Cell($width3, $height, 'Garantia:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', '');
        $pdf->SetFillColor(192,192,192, true);
        $pdf->Cell($width3+$width2, $height, $this->getDataSource()->getParameter(''), $white, 0, 'L', true, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        								
        $pdf->Output($fileName, 'F');
    }
    
    function writeDetalles (DataSource $dataSource, TCPDF $pdf) {
    	
    	   $blackAll = array('LTRB' =>array('width' => 0.3, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0)));
        $widthMarginLeft = 1;
        $width1 = 20;
        $width2 = 125;
        
        $pdf->Ln();
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $height = 5;
        $pdf->SetFillColor(255,255,255, true);
        $pdf->setTextColor(0,0,0);        
        //$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Cantidad', $blackAll, 0, 'l', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'Item', $blackAll, 0, 'L', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Precio Unitario', $blackAll, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Total', $blackAll, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->SetFontSize(6.5);
        foreach($dataSource->getDataset() as $row) {
        				$pdf->SetFont('', '');
            //$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width1, $height, $row['cantidad_coti'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width2, $height, $row['desc_solicitud_det'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width1, $height, $row['precio_unitario'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width1, $height, $row['torla'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Ln();
        }        									
    }      
}
?>