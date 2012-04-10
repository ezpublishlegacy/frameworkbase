<?php

class SiteLinkHandler
{

	static function process($menuitem){
		$OperatorValue = $menuitem->getNode();
		$Parameters = array('parameters'=>array('quotes'=>false));
		SiteLinkOperator::sitelink($OperatorValue, $Parameters);
		return $OperatorValue;
	}

}

?>