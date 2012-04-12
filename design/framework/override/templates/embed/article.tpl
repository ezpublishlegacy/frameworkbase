{* Article - Embed view *}
<div class="content-view-embed class-article">
	<a href={$node|sitelink()}><h2>{$node.data_map.title.content|wash()}</h2></a>
	{if not($node.data_map.intro.content.is_empty)}
		{attribute_view_gui attribute=$node.data_map.intro htmlshorten=first_set($htmlshorten,false())}
	{/if}
</div>