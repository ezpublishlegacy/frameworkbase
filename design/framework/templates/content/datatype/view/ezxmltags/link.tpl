{def $link_class = array()}
{if ne($classification|trim, '')}
	{set $link_class = $link_class|append($classification|wash())}
{/if}
<a{if count($link_class)} class="{$link_class|implode(' ')}"{/if} href={$href|sitelink()} {if and(is_set($id), ne($id, ''))} id="{$id}"{/if}{if and(is_set($title), ne($title, ''))} title="{$title}"{/if}{if and(is_set($target), ne($target, '_self'))} target="{$target}"{/if}>{$content}</a>