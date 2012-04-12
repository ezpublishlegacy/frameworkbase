{def $sidebar=false()
	 $extrainfo=false()
	 $bottomarea=false()
	 $left_zone=cond(is_set($node.data_map.left_zone), $node.data_map.left_zone, $node.data_map.left_column)
	 $right_zone=cond(is_set($node.data_map.right_zone), $node.data_map.right_zone, $node.data_map.right_column)
	 $bottom_zone=cond(is_set($node.data_map.bottom_zone), $node.data_map.bottom_zone, $node.data_map.bottom_column)
	 $center_zone=cond(is_set($node.data_map.center_zone), $node.data_map.center_zone, $node.data_map.center_column)
}

{if $left_zone.has_content}
	{set-block variable='sidebar'}{attribute_view_gui attribute=$left_zone}{/set-block}
{/if}
{if $right_zone.has_content}
	{set-block variable='extrainfo'}{attribute_view_gui attribute=$right_zone}{/set-block}
{/if}
{if $bottom_zone.has_content}
	{set-block variable='bottomarea'}{attribute_view_gui attribute=$bottom_zone}{/set-block}
{/if}

{pagedata_merge(hash('sidebar', $sidebar, 'extrainfo', $extrainfo, 'bottomarea', $bottomarea))}

{if $center_zone.has_content}
	{attribute_view_gui attribute=$center_zone}
{/if}

{undef $sidebar $extrainfo $bottomarea}
