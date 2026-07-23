<?php
namespace Schrattenholz\Tonnenreinigung;



use Page;
use PageController;

use SilverStripe\ORM\DataList;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Model\ArrayData;

class Tonnenreinigungsformular extends Page{


}
class Tonnenreinigungsformular_Controller extends PageController{
	private static $allowed_actions=array(
		"Tonnen",
		'Staedte',
		'validateEmail',
		'SendForm',
		'Checkout'
	
	);
	
	 function calcPreis($tonneID,$wheels,$amount){
		$preis=DataList::create("Preis".$wheels)->where("TonneID=".$tonneID." AND MaxProductQuantity >=".$amount." AND MinProductQuantity <=".$amount)->First()->Price;
		return number_format ( $preis*$amount ,2 );
	}
	
	public function Checkout($data){
	$days=array();
	$days['mo']="montags";
	$days['di']="dienstags";
	$days['mi']="mittwochs";
	$days['do']="donnerstags";
	$days['fr']="freitags";
	$days['sa']="samstags";
		$personDaten=json_decode(utf8_decode($data['person']),true);
		$tonnenDaten=json_decode($data['daten'],true);
		$zahlungsart=$data['zahlungsart'];
		$str="";
		$tonnenListe=new ArrayList();

		$totalPrice=0;
		foreach($tonnenDaten as $tonnenArt){
			foreach ($tonnenArt as $tonne){
				if($tonne['anz_tonnen']>0){
					$tonneDB=false;
					$tonneDB=DataList::create("Tonne")->where("ID="+$tonne['id']);

					
					$tonneObj=$tonneDB->where("ID=".$tonne['id'])->First();
					
					$tonneObj->Wheels=$tonne['wheels'];
					$tonneObj->Amount=$tonne['anz_tonnen'];
					$tonneObj->Number=$tonne['anz_reinigungen'];
					$tonneObj->Interval=$tonne['zeit_woche'].", ".$days[$tonne['zeit_tag']];
					$price=$this->calcPreis($tonne['id'],$tonne['wheels'],$tonne['anz_tonnen']);
					$totalPrice=$totalPrice+$price;
					$tonneObj->Price=str_replace(".",",",$price)." €";
					$tonnenListe->push($tonneObj);
				}
			}		
		}
		$str="";
		foreach($personDaten as $personFeld){
			$str.=$personFeld;
		}
		$totalPrice=number_format ($totalPrice,2);
		$totalTax=((number_format ((number_format ($totalPrice,2)*100/119),2)-number_format ($totalPrice,2))*-1);
		$dataList=new ArrayData(array("Person"=>$personDaten,"Tonnen"=>$tonnenListe,'TotalPrice'=>str_replace(".",",",$totalPrice)." €",'TotalTax'=>str_replace(".",",",$totalTax)." €","Zahlungsart"=>$zahlungsart));
		$email = new Email("system@amp-bayern.com", "fabian@schrattenholz.de", "Bestellung Tonnenreinigung", "");
		$email->setTemplate('EmailSummary');
		// You can call this multiple times or bundle everything into an array, including DataSetObjects
		$email->populateTemplate($dataList);
		$email->populateTemplate(array(
			'BaseHref' => $_SERVER['DOCUMENT_ROOT'], // Accessible in template via $WelcomeMessage
		));
		$email->send();
		$email = new Email("system@amp-bayern.com", "fabian@schrattenholz.de", "Bestellbestätigung Tonnenreinigung - amp-bayern.com", "");
		$email->setTemplate('ConfirmationMail');
		// You can call this multiple times or bundle everything into an array, including DataSetObjects
		$email->populateTemplate($dataList);
		$email->populateTemplate(array(
			'BaseHref' => $_SERVER['DOCUMENT_ROOT'], // Accessible in template via $WelcomeMessage
		));
		$email->send();
		return $dataList->renderWith("Confirmation");
	}	
	
	public function SendForm($data){
	$days=array();
	$days['mo']="montags";
	$days['di']="dienstags";
	$days['mi']="mittwochs";
	$days['do']="donnerstags";
	$days['fr']="freitags";
	$days['sa']="samstags";
		$personDaten=json_decode(utf8_decode($data['person']),true);
		$tonnenDaten=json_decode($data['daten'],true);
		$zahlungsart=$data['zahlungsart'];
		$str="";
		$tonnenListe=new ArrayList();

		$totalPrice=0;
		foreach($tonnenDaten as $tonnenArt){
			foreach ($tonnenArt as $tonne){
				if($tonne['anz_tonnen']>0){
					
					$tonneDB=false;
					$tonneDB=DataList::create("Tonne")->where("ID="+$tonne['id']);

					
					$tonneObj=$tonneDB->where("ID=".$tonne['id'])->First();
					
					$tonneObj->Wheels=$tonne['wheels'];
					$tonneObj->Amount=$tonne['anz_tonnen'];
					$tonneObj->Number=$tonne['anz_reinigungen'];
					$tonneObj->Interval=$tonne['zeit_woche'].", ".$days[$tonne['zeit_tag']];
					$price=$this->calcPreis($tonne['id'],$tonne['wheels'],$tonne['anz_tonnen']);
					$totalPrice=$totalPrice+$price;
					$tonneObj->Price=str_replace(".",",",$price)." €";
					$tonnenListe->push($tonneObj);
				}
			}		
		}
		
		$totalPrice=number_format ($totalPrice,2);
		$totalTax=((number_format ((number_format ($totalPrice,2)*100/119),2)-number_format ($totalPrice,2))*-1);
		$dataList=new ArrayData(array("Person"=>$personDaten,"Tonnen"=>$tonnenListe,'TotalPrice'=>str_replace(".",",",$totalPrice)." €",'TotalTax'=>str_replace(".",",",$totalTax)." €","Zahlungsart"=>$zahlungsart));
		return $dataList->renderWith("Summary");
	}
	
	public function Tonnen(){ 
		$tonnen=Tonne::get();
		return $tonnen;	
	}
	
	public function Staedte(){
		$orte=DataList::create("Stadt");
		return $orte;
	}
	
	public function validateEmail($value) {
        if($value!=""){
 
         $pcrePattern = '^[a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*'
             . '@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$';
 
         // PHP uses forward slash (/) to delimit start/end of pattern, so it must be escaped
         $pregSafePattern = str_replace('/', '\\/', $pcrePattern);
 
         if($value && !preg_match('/' . $pregSafePattern . '/i', $value)){
             return false;
         } else{
             return true;
         }
		}else{
			return false;	
		}
    }

}