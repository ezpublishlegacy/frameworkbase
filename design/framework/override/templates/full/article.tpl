{* Article - Full view *}
<header>
	<h1>{$node.data_map.title.content|wash()}</h1>
</header>

<div class="attribute-byline">
{if $node.data_map.author.content.is_empty|not()}<p class="author">{attribute_view_gui attribute=$node.data_map.author}</p>{/if}
{if $node.data_map.publish_date.has_content}<p class="date">{$node.data_map.publish_date.data_int|l10n(shortdatetime)}</p>{/if}
</div>

{if eq(ezini('article','ImageInFullView','content.ini'),'enabled')}
	{if $node.data_map.image.has_content}
		<div class="attribute-image align-right">
			{attribute_view_gui attribute=$node.data_map.image image_class=medium}
			{if $node.data_map.caption.has_content}
			<div class="caption" style="width: {$node.data_map.image.content.medium.width}px">
				{attribute_view_gui attribute=$node.data_map.caption}
			</div>
			{/if}
		</div>
	{/if}
{/if}

{if eq(ezini('article','SummaryInFullView','content.ini'),'enabled')}
	{if $node.data_map.intro.content.is_empty|not}
		<div class="attribute-short">
			{attribute_view_gui attribute=$node.data_map.intro}
		</div>
	{/if}
{/if}

{if $node.data_map.body.content.is_empty|not}
	<div class="attribute-long">
		{attribute_view_gui attribute=$node.data_map.body}
	</div>
{/if}

{if and(is_set($node.data_map.star_rating),$node.data_map.star_rating.has_content)}
<div class="attribute-star-rating">
	{attribute_view_gui attribute=$node.data_map.star_rating}
</div>
{/if}

{include uri='design:parts/related_content.tpl'}
{include uri="design:parts/comments.tpl" class=array('advanced','module') section=true()}

{def $tipafriend_access=fetch('user','has_access_to',hash('module','content','function','tipafriend'))}
{if and(ezmodule('content/tipafriend'),$tipafriend_access)}
<div class="attribute-tipafriend">
	<p><a href={concat("/content/tipafriend/",$node.node_id)|sitelink()} title="{'Tip a friend'|i18n('design/ezwebin/full/article')}">{'Tip a friend'|i18n('design/ezwebin/full/article')}</a></p>
</div>
{/if}
