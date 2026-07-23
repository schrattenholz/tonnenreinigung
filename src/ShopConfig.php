<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\ORM\DataObject;
use SilverStripe\CMS\Model\SiteTree;

class ShopConfig extends DataObject
{
	private static $db = array (
		'Title'=>'Varchar(255)'
	);
	private static $table_name="shopconfig";
	private static $has_one=array(
		"Basket"=>SiteTree::class,
		"CheckoutAdress"=>SiteTree::class,
		"CheckoutSummary"=>SiteTree::class,
		"CheckoutFinal"=>SiteTree::class,
		"ProductRoot"=>SiteTree::class,
		"AGB"=>SiteTree::class
	);

	private static $singular_name="Shop Konfiguration";
	private static $plural_name="Shop Konfiguration";
	public function getTitle(){
		return "ShopConfig";
		
	}
	
}
?>