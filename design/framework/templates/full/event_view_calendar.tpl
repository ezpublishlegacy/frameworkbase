{* Event Calendar - Full Calendar View *}

{def $event_node = $node
	$event_node_id = $event_node.node_id
	$curr_ts = currentdate()
	$curr_today = $curr_ts|datetime(custom, '%j')
	$curr_year = $curr_ts|datetime(custom, '%Y')
	$curr_month = $curr_ts|datetime(custom, '%n')
	$temp_ts = cond(and(ne($view_parameters.month, ''), ne($view_parameters.year, '')), makedate($view_parameters.month, cond(ne($view_parameters.day, ''), $view_parameters.day, eq($curr_month, $view_parameters.month), $curr_today, 1), $view_parameters.year), currentdate())
	$temp_month = $temp_ts|datetime(custom, '%n')
	$temp_year = $temp_ts|datetime(custom, '%Y')
	$temp_today = $temp_ts|datetime(custom, '%j')

	$days = $temp_ts|datetime(custom, '%t')

	$first_ts = makedate($temp_month, 1, $temp_year)
	$dayone = $first_ts|datetime(custom, '%w')

	$last_ts = makedate($temp_month, $days, $temp_year)
	$daylast = $last_ts|datetime(custom, '%w')

	$span1 = $dayone
	$span2 = sub(7, $daylast)

	$dayofweek = 0

	$day_array = " "
	$loop_dayone = 1
	$loop_daylast = 1
	$day_events = array()
	$loop_count = 0
}
{if ne($temp_month, 12)}
	{set $last_ts=makedate($temp_month|sum(1), 1, $temp_year)}
{else}
	{set $last_ts=makedate(1, 1, $temp_year|sum(1))}
{/if}

{def $events=fetch('content', 'list', hash(
			'parent_node_id', $event_node_id,
			'sort_by', array('attribute', true(), 'event/from_time'),
			'class_filter_type', 'include',
			'class_filter_array', array('event'),
			'main_node_only', true(),
			'attribute_filter',
			array('or',
					array('event/from_time', 'between', array(sum($first_ts, 1), sub($last_ts, 1))),
					array('event/to_time', 'between', array(sum($first_ts, 1), sub($last_ts, 1))))
				))
	$url_reload=concat($event_node.url_alias, "/(day)/", $temp_today, "/(month)/", $temp_month, "/(year)/", $temp_year, "/offset/2")
	$url_back=concat($event_node.url_alias, "/(month)/", sub($temp_month, 1), "/(year)/", $temp_year)
	$url_forward=concat($event_node.url_alias, "/(month)/", sum($temp_month, 1), "/(year)/", $temp_year)
}

{if eq($temp_month, 1)}
	{set $url_back=concat($event_node.url_alias, "/(month)/", "12", "/(year)/", sub($temp_year, 1))}
{elseif eq($temp_month, 12)}
	{set $url_forward=concat($event_node.url_alias, "/(month)/", "1", "/(year)/", sum($temp_year, 1))}
{/if}
{foreach $events as $event}
	{if eq($temp_month|int(), $event.data_map.from_time.content.month|int())}
		{set $loop_dayone = $event.data_map.from_time.content.day}
	{else}
		{set $loop_dayone = 1}
	{/if}
	{if $event.data_map.to_time.content.is_valid}
	{if eq($temp_month|int(), $event.data_map.to_time.content.month|int())}
			{set $loop_daylast = $event.data_map.to_time.content.day}
		{else}
			{set $loop_daylast = $days}
		{/if}
	{else}
		{set $loop_daylast = $loop_dayone}
	{/if}
	{for $loop_dayone|int() to $loop_daylast|int() as $counter}
		{set $day_array = concat($day_array, $counter, ', ')}
		{if eq($counter, $temp_today)}
			{set $day_events = $day_events|append($event)}
		{/if}
	{/for}
{/foreach}

<header>
	<h1>{$event_node.name|wash()}</h1>
	<h2>{$temp_ts|datetime(custom, '%F %Y')|upfirst()}:</h2>
</header>
{foreach $events as $event}
{node_view_gui view='line' content_node=$event htmlshorten=array(200, concat('... <a href="', $event|sitelink('no'), '">More</a>'))}
{delimiter}{include uri="design:content/datatype/view/ezxmltags/separator.tpl"}{/delimiter}
{/foreach}

{set-block variable='calendar'}
{include
	uri='design:parts/calendar.tpl'
	used_node=$node
	day_array=$day_array
	current=hash('month', $curr_ts|datetime('custom', '%n'), 'day', $curr_ts|datetime('custom', '%j'), 'year', $curr_ts|datetime('custom', '%Y'))
	temp=hash('month', $temp_ts|datetime('custom', '%n'), 'day', $temp_ts|datetime('custom', '%j'), 'year', $temp_ts|datetime('custom', '%Y'))
}
{/set-block}

{def $listed_events_header=cond(eq($curr_ts|datetime(custom, '%j'), $temp_ts|datetime(custom, '%j')), 'Today', $temp_ts|datetime(custom, '%l %j')|upfirst())}
{set-block variable='listed_events'}
{if count($day_events)}
{foreach $day_events as $day_event}
{node_view_gui view='listitem' content_node=$day_event htmlshorten=array(80, concat('... <a href="', $day_event|sitelink('no'), '">More</a>')) show_date=false()}
{/foreach}
{else}
<h2>There are currently no events.</h2>
{/if}
{/set-block}

{set-block variable='extrainfo'}
{include uri="design:content/datatype/view/ezxmltags/contentbox.tpl" content=$calendar display_type='infobox'}
{include uri="design:content/datatype/view/ezxmltags/contentbox.tpl" content=$listed_events|trim() header=$listed_events_header display_type='infobox'}
{/set-block}

{pagedata_set('extrainfo', $extrainfo)}
{undef}