{def $show_image=and(cond(is_set($hide_image),not($hide_image),true()), cond(is_set($node.data_map.image),$node.data_map.image.has_content,false()))}
<div class="content-view-line class-{$node.class_identifier}{if $show_image} line-image{/if} {$bgColor}" style="background-position:{$node.score_percent|wash()|int()}% 0;">
	<h2><a href={$node|sitelink()}>{$node.name|wash()}</a></h2>
	{if $show_image}
		<div class="attribute-image">
			{attribute_view_gui attribute=$node.data_map.image image_class='search_result' href=$node|sitelink()}
		</div>
	{/if}
	{$node.highlight}
	<div><em><a href={$node|sitelink()}>/{$node.url_alias|shorten(70, '...', 'middle')|wash}</a></em></div>
	<span class="score-percent">Relevance: {$node.score_percent|wash}%</span>
</div>
