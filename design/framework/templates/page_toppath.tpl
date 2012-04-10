{def $path_array=$current_node|sitelink_path()}
{if and(is_set($reverse), $reverse)}{set $path_array=$path_array|reverse()}{/if}
{if and(is_set($text_only), $text_only)}
{foreach $path_array as $key=>$path}
	{if not($path.current)}{$path.text|wash()}{else}{$path.text|wash()}{/if}{delimiter}{first_set($delimiter, ' / ')}{/delimiter}
{/foreach}
{else}
{def $menu=array()}
{foreach $path_array as $key=>$path}
{set $menu=$menu|append(hash(
	'content', $path.text|wash(),
	'link', cond($path.current, false(), $path.url_alias)
))}
{/foreach}
<nav id="path">
{menubar(hash(
	'orientation', 'horizontal',
	'delimiter', first_set($delimiter,'/'),
	'items', $menu
))}
</nav>
{undef $menu}
{/if}