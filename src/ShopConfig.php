<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\ORM\DataObject;

class ShopConfig extends DataObject
{
	private static $db = array (
		'Title'=>'Varchar(255)'
	);
	private static $table_name="shopconfig";
	private static $has_one=array(
		"Basket"=>"SiteTree",
		"CheckoutAdress"=>"SiteTree",
		"CheckoutSummary"=>"SiteTree",
		"CheckoutFinal"=>"SiteTree",
		"ProductRoot"=>"SiteTree",
		"AGB"=>"SiteTree"
	);

	private static $singular_name="Shop Konfiguration";
	private static $plural_name="Shop Konfiguration";
	public function getTitle(){
		return "ShopConfig";
		
	}
	
}
?>