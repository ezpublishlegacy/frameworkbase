{* Blog post - Line view *}
<section class="content-view-line class-blog-post">
	<a href={$node|sitelink()} title="{$node.data_map.title.content|wash()}"><h2>{$node.data_map.title.content|wash()}</h2></a>

<div class="attribute-byline">
<p class="date">{$node.data_map.publication_date.content.timestamp|datetime('custom','%F %j, %Y')}</p>
<p class="author">by: {$node.object.owner.name}</p>
{if $node.data_map.tags.has_content}
<p class="tags"> {"Tags:"|i18n("design/ezwebin/line/blog_post")}{foreach $node.data_map.tags.content.keywords as $keyword}
<a href={concat( $node.parent.url_alias, "/(tag)/", $keyword|rawurlencode )|sitelink()} title="{$keyword}">{$keyword}</a>{delimiter}, {/delimiter}
{/foreach}
</p>
{/if}
</div>

<div class="attribute-body">
{attribute_view_gui attribute=$node.data_map.body htmlshorten=array(400,concat('... <a href="',$node|sitelink('no'),'">More</a>'))}
</div>

{if $node.data_map.enable_comments.data_int}
<div class="attribute-comments">
<p>
{def $comment_count = fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
'class_filter_type', 'include',
'class_filter_array', array( 'comment' ) ) )}
{if $comment_count|gt( 0 )}
<a href={concat( $node.url_alias, "#comments" )|sitelink()}>{"View comments"|i18n("design/ezwebin/line/blog_post")} ({$comment_count})</a>
{else}
<a href={concat( $node.url_alias, "#comments" )|sitelink()}>{"Add comment"|i18n("design/ezwebin/line/blog_post")}</a>
{/if}
</p>
</div>
{/if}
</section>