{* Event - Listitem view *}
<div class="content-view-listitem class-event{if and($node.data_map.to_time.has_content,gt(currentdate(),$node.data_map.to_time.content.timestamp))} ezagenda_event_old{/if}">
{if first_set($show_date,true())}
	<span class="date-icon">
		<span class="month">{$node.data_map.from_time.content.timestamp|datetime(custom,"%M")}</span>
		<span class="date">{$node.data_map.from_time.content.timestamp|datetime(custom,"%j")}</span>
	</span>
{/if}
	<h2><a href={$node|sitelink()}>{$node.name|wash()}</a></h2>
	<h3>{$node.data_map.from_time.content.timestamp|datetime('custom',cond(first_set($show_date,true()),'%F %j %Y %g:%i%a','%g:%i%a'))}</h3>
	{attribute_view_gui attribute=$node.data_map.text htmlshorten=80}
</div>
