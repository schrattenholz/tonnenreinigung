<?php

namespace Schrattenholz\Tonnenreinigung;

use Page;
use PageController;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\FieldList;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\TabSet;
use SilverStripe\Forms\DropdownField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
class Tonne extends Page
{
	private static $table_name="tonne";
 	private static $singular_name="Behälter";
	private static $plural_name="Behälter";
	private static $db=array(
		'Wheels'=>"Enum('2,4','2')",
		'SortOrder'=>'Int'
	);
	private static $has_many = [
		'Preise'=>Preis::class
	];
	private static $has_one=[
		'Bild'=>Image::class,
		'Tonnenart'=>Tonnenart::class
		
	];
	public function getSummaryTitle(){	
		return $this->Title." mit ".$this->Wheels." Rädern";
	}
	public function getMenuTitle(){
	
		return $this->Title." ".$this->Wheels."R";
	}
	/*public function getTitle(){
		//$tonnenart=	DataObject::get_one("Tonnenart","ID=".intval($this->TonnenartID));
		$tonnenart = Tonnenart::get()->filter(['ID' => $this->TonnenartID]);
		return $tonnenart->First()->Title;
	}*/
 	public function getCMSFields()
	{
		$fields=parent::getCMSFields();

		$fields->addFieldToTab('Root.Preise', GridField::create(
            'Preise',
            'Preise on this page',
            $this->Preise()->sort('SortOrder'),
            GridFieldConfig_RecordEditor::create()
        ));
		
		$bild=new UploadField("Bild", "Bild");
		$bild->setFolderName('Uploads/tsTonnenreinigung/'.$this->URLSegment);
		
		$fields->addFieldToTab("Root.Main",new DropdownField("TonnenartID","Tonnenart", Tonnenart::get()->map("ID", "Title", "Bitte auswählen")),"Metadata");
		$fields->addFieldToTab("Root.Main",new DropdownField("Wheels","Räder",$this->dbObject("Wheels")->enumValues()),"Metadata");
		$fields->removeFieldFromTab("Root.Main","Content");
		$fields->addFieldToTab("Root.Main",$bild,"Metadata");
			
		return $fields;
	}	

	

}
class Tonne_Controller extends PageController{

	
}