<?php

namespace Schrattenholz\Tonnenreinigung;

use Page;
use PageController;

class Preisliste extends Page{
	private static $table_name="preisliste";
}

class Preisliste_Controller extends PageController{

	public $allowed_actions=array(
		'Preisliste'

	);
	public function Preisliste(){
		$liste=Tonne::get()->sort("Sort");
		return $liste;
	}
}