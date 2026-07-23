<?php
namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TabSet;
class Widget extends DataObject{
	private static $table_name="widget";
	private static $db=array(
		"Title"=>"Text",
		"Content"=>"HTMLText"

	);
	private static $belongs_many_many=array(
        'Pages'=>Page::class
    );
	public function getCMSFields(){
	$fields = FieldList::create(TabSet::create('Root'));
        $fields->addFieldsToTab('Root.Main', [
          TextField::create('Title')->setTitle('Interne Bezeichnung'),
          HTMLEditorField::create('Content')->setTitle('Inhalt')
        ]);
      
    
	return $fields;
	
	}
}