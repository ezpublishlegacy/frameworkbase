{* Event - Line view *}
{def $show_image=and(cond(is_set($hide_image),not($hide_image),true()), $node.data_map.image.has_content)}
<div class="content-view-line class-event{if $show_image} line-image{/if}{if and($node.data_map.to_time.has_content,gt(currentdate(),$node.data_map.to_time.content.timestamp))} ezagenda_event_old{/if}">
	<h2><a href={$node|sitelink()}>{$node.name|wash()}</a></h2>
	<h3 class="date">
		{$node.data_map.from_time.content.timestamp|datetime(custom,"%M %j %H:%i")}
		{if $node.data_map.to_time.has_content} - {$node.data_map.to_time.content.timestamp|datetime(custom,"%M %j %H:%i")}{/if}
	</h3>
	{if $node.data_map.category.has_content}
		<span class="keyword">{"Category"|i18n("design/ezwebin/line/event")}:{attribute_view_gui attribute=$node.data_map.category}</span>
	{/if}
	{if $show_image}
		<div class="attribute-image">{attribute_view_gui attribute=$node.data_map.image image_class=first_set($image_class,'small')}</div>
	{/if}
	{if $node.data_map.text.has_content}{attribute_view_gui attribute=$node.data_map.text htmlshorten=first_set($htmlshorten,150)}{/if}
</div>