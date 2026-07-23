<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\ORM\DataObject;
class PreislistenElement extends DataObject
{
	private static $table_name = 'PreislistenElement';
	private static $singular_name="PreislistenElement";
	private static $plural_name="PreislistenElemente";
    private static $db = [
        'Title' => 'Varchar(255)',
		'Liter'=> 'Text',
        'SortOrder' => 'Int',
    ];	
} 


?>