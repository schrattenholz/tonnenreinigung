<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\Admin\ModelAdmin;
class WidgetAdmin extends ModelAdmin {
    
  private static $managed_models = array(   //since 2.3.2
      Widget::class
   );
 public function getList() {
        $list = parent::getList();
        // Always limit by model class, in case you're managing multiple
        if($this->modelClass == 'Format') {
            $list->sort('SortID');
        }
        return $list;
    }
/*public function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        // $gridFieldName is generated from the ModelClass, eg if the Class 'Product'
        // is managed by this ModelAdmin, the GridField for it will also be named 'Product'
        $gridFieldName = $this->sanitiseClassName($this->modelClass);
        $gridField = $form->Fields()->fieldByName($gridFieldName);
        $gridField->getConfig()->addComponent(new GridFieldAddNewMultiClass());
		$gridField->getConfig()->removeComponentsByType("GridFieldAddNewButton");
		$gridField->getConfig()->removeComponentsByType("GridFieldExportButton");
		$gridField->getConfig()->removeComponentsByType("GridFieldPrintButton");
        return $form;
    }*/
  private static $url_segment = 'widgets'; // will be linked as /admin/products
  private static $menu_title = 'WidgetVerwaltung';
 
}