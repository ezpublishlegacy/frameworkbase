{if first_set($used_node, false())}

{if is_unset($day_array)}
{def $ts=currentdate()
	 $current=hash('month', $ts|datetime('custom', '%n'), 'day', $ts|datetime('custom', '%j'), 'year', $ts|datetime('custom', '%Y'))
	 $temp_ts=cond(and(ne($view_parameters.month, ''), ne($view_parameters.year, '')), makedate($view_parameters.month, cond(ne($view_parameters.day, ''), $view_parameters.day, eq($current.month, $view_parameters.month), $current.day, 1), $view_parameters.year), $ts)
	 $temp=hash('month', $temp_ts|datetime('custom', '%n'), 'day', $temp_ts|datetime('custom', '%j'), 'year', $temp_ts|datetime('custom', '%Y'))
	 $days=$temp_ts|datetime('custom', '%t')
	 $bounds=hash(
		'first', hash(
			'ts', makedate($temp.month, 1, $temp.year),
			'day', makedate($temp.month, 1, $temp.year)|datetime('custom', '%w')
			),
		'last', hash(
			'ts', cond(ne($temp.month, 12), makedate($temp.month|sum(1), 1, $temp.year), makedate(1, 1, $temp.year|sum(1))),
			'day', makedate($temp.month, $days, $temp.year)|datetime('custom', '%w')
			)
		)
	 $span1 = $bounds.first.day
	 $span2 = sub(7, $bounds.last.day)
	 $dayofweek = 0
	 $day_array = " "
	 $loop_dayone = 1
	 $loop_daylast = 1
	 $day_items = array()
	 $loop_count = 0
	 $range = array(sum($bounds.first.ts, 1), sub($bounds.last.ts, 1))
}
{if is_unset($attribute_filter)}
{def $attribute_filter=cond(gt(count($attributes.items), 1), array(first_set($attributes.condition, 'or')), array('and'))}
{foreach $attributes.items as $value}
{set $attribute_filter=$attribute_filter|append(array(concat($class_identifier, '/', $value), 'between', $range))}
{/foreach}
{/if}
{def $items=fetch('content', 'list', hash(
		'parent_node_id', $used_node.node_id,
		'attribute_filter', $attribute_filter
		)|merge(first_set($parameters, array())))
	$url_reload=concat($used_node.url_alias, "/(day)/", $temp.day, "/(month)/", $temp.month, "/(year)/", $temp.year, "/offset/2")
	$url_back=concat($used_node.url_alias, "/(month)/", sub($temp.month, 1), "/(year)/", $temp.year)
	$url_forward=concat($used_node.url_alias, "/(month)/", sum($temp.month, 1), "/(year)/", $temp.year)
}
{if eq($temp.month, 1)}
{set $url_back=concat($used_node.url_alias, "/(month)/", "12", "/(year)/", sub($temp.year, 1))}
{elseif eq($temp.month, 12)}
{set $url_forward=concat($used_node.url_alias, "/(month)/", "1", "/(year)/", sum($temp.year, 1))}
{/if}
{foreach $items as $item}
	{if eq($temp.month|int(), $item.data_map[$attributes.items.from].content.month|int())}
		{set $loop_dayone = $item.data_map[$attributes.items.from].content.day}
	{else}
		{set $loop_dayone = 1}
	{/if}
	{if and(is_set($item.data_map[$attributes.items.to]), $item.data_map[$attributes.items.to].content.is_valid)}
		{if eq($temp.month|int(), $item.data_map[$attributes.items.to].content.month|int())}
			{set $loop_daylast = $item.data_map[$attributes.items.to].content.day}
		{else}
			{set $loop_daylast = $days}
		{/if}
	{else}
		{set $loop_daylast = $loop_dayone}
	{/if}
	{for $loop_dayone|int() to $loop_daylast|int() as $counter}
		{set $day_array = concat($day_array, $counter, ', ')}
		{if eq($counter, $temp.day)}
			{set $day_items = $day_items|append($event)}
		{/if}
	{/for}
{/foreach}

{/if}

<table class="renderedtable calendar" cellspacing="0" cellpadding="0" border="0">
<caption>
	<a href={$url_back|sitelink()} title=" Previous month ">&#8249;&#8249;</a>
	<span>{$temp_ts|datetime(custom, '%F')|upfirst()}&nbsp;{$temp.year}</span>
	<a href={$url_forward|sitelink()} title=" Next Month ">&#8250;&#8250;</a>
</caption>
<thead>
<tr class="calendar_heading_days">
	<th class="first_col" scope="col">Mon</th>
	<th scope="col">Tue</th>
	<th scope="col">Wed</th>
	<th scope="col">Thu</th>
	<th scope="col">Fri</th>
	<th scope="col">Sat</th>
	<th class="last_col" scope="col">Sun</th>
</tr>
</thead>
<tbody>
{def $counter=1 $col_counter=1 $css_col_class='' $col_end=0}
{while le( $counter, $days )}
    {set $dayofweek     = makedate( $temp.month, $counter, $temp.year )|datetime( custom, '%w' )
         $css_col_class = ''
         $col_end       = or( eq( $dayofweek, 0 ), eq( $counter, $days ) )}
    {if or( eq( $counter, 1 ), eq( $dayofweek, 1 ) )}
        <tr class="{cond(mod($counter, 2), 'bglight', 'bgdark')} days{if eq( $counter, 1 )} first_row{elseif lt( $days|sub( $counter ), 7 )} last_row{/if}">
        {set $css_col_class=' first_col'}
    {elseif and( $col_end, not( and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne( 7 ) ) ) )}
        {set $css_col_class=' last_col'}
    {/if}
    {if and( $span1|gt( 1 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while ne( $col_counter, $span1 )}
            <td>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {elseif and( eq($span1, 0 ), eq( $counter, 1 ) )}
        {set $col_counter=1 $css_col_class=''}
        {while le( $col_counter, 6 )}
            <td>&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {/if}
    <td class="{if eq($counter, $temp.day)}selected{/if} {if and(eq($counter, $current.day), eq($current.month, $temp.month))}current{/if}{$css_col_class}">
    {if $day_array|contains(concat(' ', $counter, ', ')) }
        <a href={concat( $used_node.url_alias, "/(day)/", $counter, "/(month)/", $temp.month, "/(year)/", $temp.year)|ezurl}>{$counter}</a>
    {else}
        {$counter}
    {/if}
    </td>
    {if and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))}
        {set $col_counter=1}
        {while le( $col_counter, $span2 )}
            {set $css_col_class=''}
            {if eq( $col_counter, $span2 )}
                {set $css_col_class=' last_col'}
            {/if}
            <td class="{$css_col_class}">&nbsp;</td>
            {set $col_counter=inc( $col_counter )}
        {/while}
    {/if}
    {if $col_end}
        </tr>
    {/if}
    {set $counter=inc( $counter )}
{/while}
</tbody>
</table>

{/if}