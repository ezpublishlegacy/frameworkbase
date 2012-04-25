{def $use_link_header = and(is_set($link_header), $link_header)}
<nav id="sidemenu">
{if and(is_set($show_header), $show_header)}
	<h2>{if $use_link_header}<a href={$current_node|sitelink()}>{/if}{$current_node.name|wash()}{if $use_link_header}</a>{/if}</h2>
{/if}
	{menubar(hash(
		'root_node_id', $current_node_id
	))}
</nav>
{undef $use_link_header}