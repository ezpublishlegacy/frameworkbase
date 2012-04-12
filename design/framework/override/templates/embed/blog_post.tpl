{def $comment_count=fetch('content','list_count',hash('parent_node_id',$node.node_id,'class_filter_type','include','class_filter_array',array('comment')))}
<div class="content-view-embed class-blog-post line-image">
	<a href={$node|sitelink()}><h2>{$node.name|wash()}</h2></a>
	<span class="author">by: {$node.object.owner.name|wash()}</span>
	<span class="date">{$node.data_map.publication_date.content.timestamp|datetime('custom','%F %j, %Y')}</span>
	<div class="attribute-image">
	{if $node.object.owner.data_map.image.has_content}
		{attribute_view_gui attribute=$node.object.owner.data_map.image image_class='blogpostthumbnail'}
	{else}
		<img title="Anonymous Author" alt="Anonymous Author" src="/extension/site/design/site/images/temp/anon-author.png" width="58" height="58">
	{/if}
	</div>
	{attribute_view_gui attribute=$node.data_map.body htmlshorten=first_set($htmlshorten,array(300,concat('... <a href="',$node|sitelink('no'),'">Read More</a>')))}
	{if and($node.data_map.enable_comments.data_int, $comment_count)}
		<a class="comments{if gt($comment_count,1)} plural{/if}" href={concat($node.url_alias,'#comments')|sitelink()}>{$comment_count}<span>Comment{if gt($comment_count,1)}s{/if}</span></a>
	{/if}
</div>