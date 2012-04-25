{def $use_link_header = and(is_set($link_header), $link_header)
	 $menubar_id = 'primary'
	 $root_in_menubar = false()
}
<nav id="sidemenu">
{if and(is_set($show_header), $show_header)}
{set $root_in_menubar = $current_node|in_menubar($menubar_id)}
	<h2{if $root_in_menubar} class="{$menubar_id}-menu-item"{/if}>{if $use_link_header}<a href={$current_node|sitelink()}>{/if}{$current_node.name|wash()}{if $use_link_header}</a>{/if}</h2>
{/if}
	{menubar(hash(
		'root_node_id', $current_node_id
	))}
</nav>
{undef $use_link_header $menubar_id $root_in_menubar}