{if and( or(and(is_set($infoboxes_only), not($infoboxes_only)), is_unset($infoboxes_only)), and(is_set($persistent_variable.extrainfo), $persistent_variable.extrainfo) )}
	{$persistent_variable.extrainfo}
{/if}
{if $infoboxes[$infobox_position]}{$infoboxes[$infobox_position]}{/if}