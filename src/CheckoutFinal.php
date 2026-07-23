<?php
namespace Schrattenholz\Tonnenreinigung;
use Page;
use PageController;
use SilverStripe\Forms\TabSet;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditorField;
class CheckoutFinal extends Page
{
	private static $db=[
		'ErrorMessage'=>'HTMLText'
	];
	private static $table_name="checkoutfinal";
	public function getCMSFields(){


		$fields=parent::getCMSFields();
		$fields->addFieldToTab("Root.Main",new HTMLEditorField("ErrorMessage"),"Metadata");
		return $fields;
	}
}
class CheckoutFinal_Controller extends PageController
{
}