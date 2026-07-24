<?php

namespace Schrattenholz\Tonnenreinigung;

use SilverStripe\Admin\ModelAdmin;

class TonnenreinigungAdmin extends ModelAdmin
{

    private static $menu_title = 'Tonnenreinigung';

    private static $menu_icon_class = 'font-icon-trash-bin';

    private static $url_segment = 'tonnenreinigung';

    private static $managed_models = [
        Stadt::class,
		Tonnenart::class,
		PreislistenElement::class,
		ShopConfig::class
    ];
}