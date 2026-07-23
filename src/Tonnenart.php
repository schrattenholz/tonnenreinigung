<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\CurrencyField;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\ORM\ArrayLib;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\TabSet;

class Tonnenart extends DataObject
{
	private static $table_name = 'Tonnenart';
	private static $singular_name="Tonnenart";
	private static $plural_name="Tonnenarten";	
    private static $db = [
        'Title' => 'Varchar(255)',
        'SortOrder' => 'Int',
    ];
	

    public function getCMSfields()
    {
        $fields = FieldList::create(TabSet::create('Root'));
        $fields->addFieldsToTab('Root.Main', [
            TextField::create('Title')
        ]);
        return $fields;
    }
}
?>