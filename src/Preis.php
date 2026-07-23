<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\HiddenField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
class Preis extends DataObject
{
	private static $db = array (
		'Title'=>'Varchar(255)',
		'Price'=>'Decimal(4,2)',
		'Currency'=>"Enum('EUR', 'EUR')",
		'MaxProductQuantity'=>'Int',
		'MinProductQuantity'=>'Int',
		'SortOrder'=>'Int'
	);
	private static $summary_fields = [
			'MinProductQuantity' => 'Ab',
			'MaxProductQuantity' => 'Bis',
			'Price'=>'Preis'
    ];
 	private static $singular_name="Preis";
	private static $plural_name="Preise";
	private static $table_name="preis";
	private static $has_one = [
		'Tonne'=>Tonne::Class
	];
 	public function getCMSFields()
	{
		$fields=FieldList::create(TabSet::create('Root'));
		$fields->addFieldsToTab('Root.Main', [
            TextField::create('Price','Preis'),
			HiddenField::create('Curreny','EUR'),
			TextField::create('MinProductQuantity','Ab'),
			TextField::create('MaxProductQuantity','Bis')
        ]);
		return $fields;
	}	
}
?>