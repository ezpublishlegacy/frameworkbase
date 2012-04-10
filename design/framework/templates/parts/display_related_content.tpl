{if count($related_content)}
{def $threshold=15}
<div class="attribute-relatedcontent">
	<h2>{"Related content"|i18n("design/ezwebin/full/article")}</h2>
	<ul>
	{foreach $related_content as $related_object max 5}
	{if gt($related_object.score_percent, $threshold)}
		<li><a href="{$related_object|sitelink('no')}" title="{$related_object.name|wash()}">{$related_object.name|wash()}</a>{*$related_object.score_percent*}</li>
	{/if}
	{/foreach}
	</ul>
</div>
{/if}