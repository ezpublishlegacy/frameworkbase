{* Article - Line view *}
{def $show_image=and(cond(is_set($hide_image), not($hide_image), true()), $node.data_map.image.has_content)}
<div class="content-view-line class-article{if $show_image} line-image{/if}">
	<h2><a href={$node|sitelink()}>{$node.data_map.title.content|wash()}</a></h2>
	{if $show_image}
		<div class="attribute-image">{attribute_view_gui image_class='small' href=$node|sitelink() attribute=$node.data_map.image}</div>
	{/if}
	{if not($node.data_map.intro.content.is_empty)}
		<div class="attribute-xmlblock">{attribute_view_gui attribute=$node.data_map.intro}</div>
	{/if}
</div>