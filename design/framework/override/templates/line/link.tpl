{* Link - Line view *}
{def 	$show_image=and(cond(is_set($hide_image),not($hide_image),true()), $node.data_map.image.has_content)
		$href = $node|sitelink('no')
}
<div class="content-view-line class-link{if $show_image} line-image{/if}">
	<h2>{if $href}<a href="{$href}"{if $node.data_map.external_link.data_text} class="external" rel="external"{/if}{if $node.data_map.open_in_new_window.data_int} target="_blank"{/if}>{/if}{$node.name|wash()}{if $href}</a>{/if}</h2>
	{if $show_image}
		<div class="attribute-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}
	{if $node.data_map.short_description.has_content}
		<div class="attribute-short">{attribute_view_gui attribute=$node.data_map.short_description htmlshorten=first_set($htmlshorten,false())}</div>
	{/if}
</div>

