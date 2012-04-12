{* Image - Horizontally Listed Subitems view *}
{def $link=$node|sitelink('no')}
<div class="content-view-horizontallylistedsubitems class-image column">
	<div class="content-image">
		{attribute_view_gui attribute=$node.data_map.image image_class='listitem' href=cond(ne($link, ''), $link, false())}
	</div>
	<div class="caption">
		<p><a href={$node|sitelink()}>{$node.name}</a></p>
	</div>
</div>
{undef $link}