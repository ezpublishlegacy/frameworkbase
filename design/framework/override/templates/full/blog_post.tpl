{* Blog post - Full view *}
<header><h1>{$node.data_map.title.content|wash()}</h1></header>

<div class="attribute-byline">
	<p class="date">{$node.data_map.publication_date.content.timestamp|datetime('custom','%F %j, %Y')}</p>
	<p class="author">by: {$node.object.owner.name}</p>
{if $node.data_map.tags.has_content}
	<p class="tags"> {"Tags:"|i18n("design/ezwebin/full/blog_post")}
		{foreach $node.data_map.tags.content.keywords as $keyword}
<a href={concat( $node.parent.url_alias, "/(id)/", $node.parent.node_id, "/(tag)/", $keyword|rawurlencode )|ezurl} title="{$keyword}">{$keyword}</a>{delimiter}, {/delimiter}
		{/foreach}
	</p>
{/if}
</div>
<div class="attribute-image">
{if $node.object.owner.data_map.image.has_content}
	{attribute_view_gui attribute=$node.object.owner.data_map.image image_class='blogpostthumbnail'}
{else}
	<img title="Anonymous Author" alt="Anonymous Author" src="/extension/site/design/site/images/anon-user.png" width="58" height="58">
{/if}
</div>
<div class="attribute-body float-break">
	{attribute_view_gui attribute=$node.data_map.body}
</div>
{include uri='design:parts/related_content.tpl'}

{include uri="design:parts/comments.tpl" class=array('advanced','module') section=true()}

{set-block variable='extrainfo'}
	{include uri='design:parts/blog/extra_info.tpl' used_node=$node.parent display_type='infobox'}
{/set-block}
{pagedata_set('extrainfo',$extrainfo)}