{* Article - Listitem view *}
<div class="content-view-listitem class-article">
	<a href={$node|sitelink()}><h2>{$node.data_map.title.content|wash()}</h2></a>
{if $node.data_map.publish_date.has_content}	<p class="date">{$node.data_map.publish_date.data_int|datetime('custom','%F %j, %Y')}</p>{/if}
</div>