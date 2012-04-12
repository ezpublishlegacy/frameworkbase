{* Folder - Line view *}
{def $show_image=and(cond(is_set($hide_image),not($hide_image),true()), $node.data_map.image.has_content)}
<div class="content-view-line class-folder{if $show_image} line-image{/if}">
	<h2><a href={$node|sitelink()}>{$node.name|wash()}</a></h2>
	{if $show_image}
		<div class="attribute-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}
	{if $node.data_map.short_description.has_content}
		<div class="attribute-short">{attribute_view_gui attribute=$node.data_map.short_description htmlshorten=first_set($htmlshorten,false())}</div>
	{/if}
</div>