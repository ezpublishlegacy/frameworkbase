<?php

class SiteLinkHandler
{

	static function process($object){
		$Parameters = array('parameters'=>array('quotes'=>false));
		SiteLinkOperator::sitelink($object, $Parameters);
		return $object;
	}

}

?>