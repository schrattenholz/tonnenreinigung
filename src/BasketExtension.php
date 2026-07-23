<?php 	

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\Core\Extension; 
use SilverStripe\ORM\DataList;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Model\ArrayData;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Core\Injector\Injector;
use SilverStripe\Control\Email\Email;
use Psr\Log\LoggerInterface;
class BasketExtension extends Extension {
		private static $allowed_actions = array (
		'ClearBasket',
		'addToList',
		'getListCount',
		'getBasket',
		'calcPreis',
		'removeProductFromBasket',
		'getSinlgeProduct',
		'getLinkCheckoutAddress',
		'setCheckoutAddress',
		'getCheckoutAdress',
		'makeOrder',
		'getLocations'
	);
	function utf8_urldecode($str) {
		$str = preg_replace("/%u([0-9a-f]{3,4})/i","&#x\\1;",urldecode($str));
		return html_entity_decode($str,null,'UTF-8');;
	} 
	public function getLocations(){
	
		return Stadt::get();
	}
	public function setCheckoutAddress($data){
		$personDaten=json_decode($this->utf8_urldecode($data['person']),true);
		$ar=array();
		foreach($personDaten as $key => $value){
			 array_push($ar, $key."=".$value);
		}
		array_push($ar, "Location=".$this->utf8_urldecode($data['location']));
		$this->getSession()->set('personendaten', implode('+++',$ar));
		return $this->getSession()->get('personendaten');
	}
	public function getCheckoutAdress(){
		$personenDaten=$this->getSession()->get('personendaten');
		if($personenDaten){
		$tmpAr=explode('+++',$personenDaten);		
		$arForDataList=array();	
		foreach($tmpAr as $element){
			$tmp=explode('=',$element);
			
			$arForDataList[$tmp[0]]=$tmp[1];
			
		}
		return new ArrayData($arForDataList);
		}else{return false;}		
	}
	public function getLinkAGB(){
		$shopConfig=ShopConfig::get()->First();
		$agb=SiteTree::get()->where('ID='.$shopConfig->AGBID)->First();
		return $agb->Link();	
	}
	public function getLinkProductRoot(){
		$shopConfig=ShopConfig::get()->First();
		$productRoot=SiteTree::get()->where('ID='.$shopConfig->ProductRootID)->First();
		return $productRoot->Link();	
	}
	public function getLinkCheckoutAddress(){
		$shopConfig=ShopConfig::get()->First();
		$checkoutAdress=SiteTree::get()->where('ID='.$shopConfig->CheckoutAdressID)->First();
		return $checkoutAdress->Link();	
	}
	public function getLinkBasket(){
		$shopConfig=ShopConfig::get()->First();
		$basket=SiteTree::get()->where('ID='.$shopConfig->BasketID)->First();
		return $basket->Link();	
	}
	public function getLinkCheckoutSummary(){
		$shopConfig=ShopConfig::get()->First();
		$checkoutSummary=SiteTree::get()->where('ID='.$shopConfig->CheckoutSummaryID)->First();
		return $checkoutSummary->Link();	
	}
	public function getLinkCheckoutFinal(){
		$shopConfig=ShopConfig::get()->First();
		$checkoutFinal=SiteTree::get()->where('ID='.$shopConfig->CheckoutFinalID)->First();
		return $checkoutFinal->Link();	
	}
	public function getWarenkorbData(){
		$request = Injector::inst()->get(HTTPRequest::class);
		$session = $request->getSession();
		return $session->get('warenkorb');
	}
	function getSession(){
		$request = Injector::inst()->get(HTTPRequest::class);
		$session = $request->getSession();
		return $session;
	}
	public function setWarenkorbData($data){
		$this->getSession()->set('warenkorb', implode('|||',$data));
	}
	public function clearSession($value){
		$this->getSession()->set($value, '');
	}
	public function getSingleProduct(){
		
		foreach(explode('|||',$this->getWarenkorbData()) as $tonne){
			$tmpAr=explode('+++',$tonne);		
			// Alle Produkte ausser dem zu l�schenden Produkt werden im neuen Warenkorb gespeichert
			if($tmpAr[0]==$this->getOwner()->ID){
				$aktTonne=$tmpAr;
				return new ArrayData(array("anz_tonnen"=>$aktTonne[1],"anz_reinigungen"=>$aktTonne[2],"zeit_woche"=>$aktTonne[3],"zeit_tag"=>$aktTonne[4]));
			}	
		}	
		return false;
	}
	//Produkt aus dem Warenkorb entfernen
	public function removeProductFromBasket($data){
		$newBasket=array();
		foreach(explode('|||',$this->getWarenkorbData()) as $tonne){
			$tmpAr=explode('+++',$tonne);		
			// Alle Produkte ausser dem zu l�schenden Produkt werden im neuen Warenkorb gespeichert
			if($tmpAr[0]!=$data['id']){
				array_push($newBasket,$tonne);
			}		
		}	
		$this->setWarenkorbData($newBasket);
		return implode('|||',$newBasket);
	
	}
	function calcPreis($tonneID,$amount,$number,$totalItems){
		$preis=Preis::get()->where("TonneID=".$tonneID." AND MaxProductQuantity >=".$totalItems." AND MinProductQuantity <=".$totalItems)->First()->Price;
		//number_format($tmpAD->TotalPrice,2),",",".")
		
		return number_format ( ($preis*$amount)*$number ,2,".","" );
	}
	// Anzahl der Produkte 
	public function getListCount(){
		if($this->getWarenkorbData()){
			$count=count(explode('|||',$this->getWarenkorbData()));
		}else{
			$count=0;
		}
		return $count;	
	}
	// clear basket
	public function ClearBasket(){
		$this->clearSession('warenkorb');
		
		//return Session::get('warenkorb');
	}
	// clear address-data
	public function ClearAddress(){
		$this->clearSession('personendaten');
		
		//return Session::get('warenkorb');
	}
	
	
	// Produkt in den Warenkorb
	public function addToList($data){
		$error=false;
		$action=$data['action'];
		$tonnenDaten=json_decode(utf8_encode($data['tonne']),true);
		
		//Daten validieren

		if($tonnenDaten['anz_tonnen']!=0 && $tonnenDaten['anz_reinigungen']!='no' && $tonnenDaten['zeit_woche']!='no' && $tonnenDaten['zeit_tag']!='no'){
			if($action=="new"){
				// Pr�fen, ob das Produkt bereits in der Session abgelegt ist
				//if($this->noDouble($tonnenDaten['id'])){
				if($this->noDouble($tonnenDaten['id'])){
					$list=explode('|||',$this->getWarenkorbData());
					$tmp=$tonnenDaten['id']."+++".$tonnenDaten['anz_tonnen']."+++".$tonnenDaten['anz_reinigungen']."+++".$tonnenDaten['zeit_woche']."+++".$tonnenDaten['zeit_tag'];
					array_push($list,$tmp);
					$list=array_filter($list);
					$this->setWarenkorbData($list);			
					
				}else{
				
				
				
					// Produkt bereits im Warenkorb
					return "0|double";
				}		
			}else if($action=="edit"){
				$list=array();
				foreach(explode('|||',$this->getWarenkorbData()) as $tonne){
					$tmpAr=explode('+++',$tonne);

					// Abbrechen wenn ein Double gefunden wurde
					if($tmpAr[0]==$tonnenDaten['id']){
						$tonne=$tonnenDaten['id']."+++".$tonnenDaten['anz_tonnen']."+++".$tonnenDaten['anz_reinigungen']."+++".$tonnenDaten['zeit_woche']."+++".$tonnenDaten['zeit_tag'];
						//return false;
					}
					array_push($list,$tonne);
				}
				$this->setWarenkorbData($list);
			}
			return "2|".count($list);
		}else{
		
			
			// Es fehlen Eingaben
			$error=true;
			return "0|validation";
		}
	}
	
	// Pr�ft ob das aktuelle Produkt bereits in der Session angelegt wurde
	function noDouble($tonnenID){	
		foreach(explode('|||',$this->getWarenkorbData()) as $tonne){
			$tmpAr=explode('+++',$tonne);

			// Abbrechen wenn ein Double gefunden wurde
			if($tmpAr[0]==$tonnenID){
				return false;
			}		
		}		
		// Kein Double gefunden
		return true;		
	} 
	public function getBasket(){
		$products=new ArrayList();
		$tmpAr=array();
		$totalPrice=0;

		if($this->getWarenkorbData()!="" || $this->getWarenkorbData()!=false){
		$session=explode('|||',$this->getWarenkorbData());
		//Anzahl gebuchter Tonnne gesamt
		$totalProductItems=0;
		foreach($session as $product){
			$productAr=explode('+++',$product);
			$totalProductItems+=$productAr[1];
		}
			foreach($session as $product){
				$productAr=explode('+++',$product);
				//$tmpAD=	DataList::create('Tonne')->where('Tonne'.$add.'.ID='.$productAr[0])->First();
				$tonne=tonne::get()->byID($productAr[0]);
				$tmpAD= $tonne;
				$itemPrice=$this->calcPreis($productAr[0],$productAr[1],$productAr[2],$totalProductItems);
				$tmpAD->TotalPrice=number_format($this->calcPreis($productAr[0],$productAr[1],$productAr[2],$totalProductItems),2,",",".");
				//$tmpAD->TotalPrice=str_replace(".",",",$tmpAD->TotalPrice);
				//Injector::inst()->get(LoggerInterface::class)->error(' TotalPrice'.$tmpAD->TotalPrice);
				$tmpAD->anz_tonnen=_t("tsTonnenreinigung.".$productAr[1],$productAr[1]);
				$tmpAD->anz_reinigungen=_t("tsTonnenreinigung.".$productAr[2],$productAr[2]);
				$tmpAD->Interval=_t("tsTonnenreinigung.".$productAr[3],$productAr[3]).", "._t("tsTonnenreinigung.".$productAr[4],$productAr[4]);
				$totalPrice=$totalPrice+$itemPrice;
				$products->push($tmpAD);
				
			}
			//Mehrwertsteuer
			$totalTax=$totalPrice/100*19;
			//Bruttopreis
			$bruttoPrice=$totalPrice+$totalTax;
			return new ArrayData(array('Products'=>$products,'TotalPrice'=>number_format($totalPrice,2,",","."),'TotalPriceFloat'=>number_format($totalPrice,2),'TotalTax'=>number_format($totalTax,2,",","."),'BruttoPrice'=>number_format($bruttoPrice,2,",","."),'TotalProductItems'=>$totalProductItems));
			
		}else{
			return new ArrayData(array('Products'=>false));
		}
		
	}
	function makeOrder(){
			
	$email = Email::create()
    ->setHTMLTemplate('Silverstripe\\Tonnenreinigung\\Layout\\ConfirmationClient') 
    ->setData([
			'BaseHref' => $_SERVER['DOCUMENT_ROOT'],
			'Basket' => $this->getBasket(),
			'CheckoutAdress' => $this->getCheckoutAdress(),
    ])
    ->setFrom("system@amp-bayern.com")
    ->setTo($this->getCheckoutAdress()->Email)
    ->setSubject(utf8_encode("Bestellbest�tigung Tonnenreinigung - amp-bayern.com"));
	$email->send();
		//$email = new Email("webseite@amp-bayern.com", "stein@amp-bayern.com", "Neue Tonnenreinigung-Bestellung", "");
		/*
		$email = new Email("webseite@amp-bayern.com", "fabian@schrattenholz.de", "Neue Tonnenreinigung-Bestellung", "");
		$email->setHTMLTemplate('Confirmation');
		$email->populateTemplate($this->getBasket());
		$email->populateTemplate(array(
			'BaseHref' => $_SERVER['DOCUMENT_ROOT'],
			'Basket' => $this->getBasket(),
			'CheckoutAdress' => $this->getCheckoutAdress(),
		));
		*/
		
	$email = Email::create()
    ->setHTMLTemplate('Silverstripe\\Tonnenreinigung\\Layout\\Confirmation') 
    ->setData([
        'BaseHref' => $_SERVER['DOCUMENT_ROOT'],
		'Basket' => $this->getBasket(),
		'CheckoutAdress' => $this->getCheckoutAdress(),
    ])
    ->setFrom("system@amp-bayern.com")
    ->setTo("info@amp-bayern.com")
    ->setSubject("Neue Tonnenreinigung-Bestellung");		
	$email->send();
		
		
	
	}
	
}
