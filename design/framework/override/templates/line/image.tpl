{* Image - Line view *}
{def $captionAttribute = cond($node.data_map.caption.has_content,$node.data_map.caption,$node.data_map.name)}

{if and(is_set($caption_identifier), $node.data_map[$caption_identifier].has_content)}
	{set $captionAttribute = $node.data_map[$caption_identifier]}
{/if}

{if not($embed)}<div class="line-image">{/if}
	<a href={$node|sitelink()}>
		{attribute_view_gui attribute=$node.data_map.image image_class=first_set($class,'small')}
		{if $caption}<span class="caption">{attribute_view_gui attribute=$captionAttribute text_only=true()}</span>{/if}
	</a>
{if not($embed)}</div>{/if}