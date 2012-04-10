{def $uri_suffix=first_set($page_uri_suffix, false())
	 $max=hash('left', first_set($left_max, 7), 'right', first_set($right_max, 6))
	 $page_count=ceil(div($item_count, $item_limit))int()
	 $current_page=min($page_count, ceil(div(first_set($view_parameters.offset, 0), $item_limit))|int())
	 $item_previous=sub(mul($current_page, $item_limit), $item_limit)
	 $item_next=sum(mul($current_page, $item_limit), $item_limit)
	 $left_length=min($current_page, $max.left)
	 $right_length=max(min(sub($page_count, $current_page, 1), $max.right), 0)
	 $view_parameter_text=""
	 $offset_text=eq(ezini('ControlSettings', 'AllowUserVariables', 'template.ini'), 'true')|choose('/offset/', '/(offset)/')
	 $page_offset=0
	 $pages=array()
}
{* Create view parameter text with the exception of offset *}
{foreach $view_parameters as $key=>$value}
{if ne($key, 'offset')}{set $view_parameter_text=concat($view_parameter_text, '/(', $key, ')/', $value)}{/if}
{/foreach}

{if gt($page_count, 1)}
<div class="paging_stats">
	{cond(gt(sum($:item_previous, $item_limit), 0), sum($:item_previous, $item_limit)|inc, true(), 1)} 
	-  {cond(lt(sum(mul( $:current_page, $item_limit ), $item_limit ), $item_count), sum(mul( $:current_page, $item_limit ), $item_limit), true(), $item_count) }
	of {$item_count}
</div>
<nav class="pagenavigator">
	{if gt($current_page, $max.left)}
		{set $pages=$pages|append(hash(
				'text', 1, 
				'link', concat($page_uri, $view_parameter_text, $uri_suffix)|sitelink('no'),
				'current', false()
			))}
	{/if}
	{if $left_length}
		{for 0 to sub($left_length, 1) as $index}
			{set $page_offset=sum(sub($current_page, $left_length), $index)
				 $pages=$pages|append(hash(
						'text', $page_offset|inc(),
						'link', concat($page_uri, gt($page_offset, 0)|choose('', concat($offset_text, mul($page_offset, $item_limit))), $view_parameter_text, $uri_suffix)|sitelink('no'),
						'current', false()
					))
			}
		{/for}
	{/if}
	{set $pages=$pages|append(hash('text', $current_page|inc(), 'link', false(), 'current', true()))}
	{if $right_length}
		{for 0 to sub($right_length, 1) as $index}
			{set $page_offset=sum($current_page, 1, $index)
				 $pages=$pages|append(hash(
						'text', $page_offset|inc(),
						'link', concat($page_uri, gt($page_offset, 0)|choose('', concat($offset_text, mul($page_offset, $item_limit))), $view_parameter_text, $uri_suffix)|sitelink('no'),
						'current', false()
					))
			}
		{/for}
	{/if}
	{if gt($page_count, sum($current_page, $max.right, 1))}
		{set $pages=$pages|append(hash(
				'text', $page_count,
				'link', concat($page_uri, gt($page_count|dec(), 0)|choose('', concat($offset_text, mul($page_count|dec, $item_limit))), $view_parameter_text, $uri_suffix)|sitelink('no'),
				'current', false()
			))}
	{/if}

	{if not(lt($item_previous, 0))}
		<a class="previous" href={concat($page_uri, gt($item_previous, 0)|choose('', concat($offset_text, $item_previous)), $view_parameter_text, $uri_suffix)|sitelink()}><span class="text">&laquo; Previous</span></a>
	{/if}
	<ul class="pages menu horizontal">
	{foreach $pages as $key=>$page}
		<li class="{cond($page.current, 'current', 'other')}"><a{if $page.link} href="{$page.link}"{/if}>{$page.text}</a>{if ne($key, sub(count($pages), 1))}<span class="delimiter">{cond( eq($page.text|inc(), $pages[$key|inc].text) , first_set($delimiter, '|'), '...')}</span>{/if}</li>
	{/foreach}
	</ul>
	{if lt($item_next, $item_count)}
		<a class="next" href={concat($page_uri, $offset_text, $item_next, $view_parameter_text, $uri_suffix)|sitelink()}><span class="text">Next &raquo;</span></a>
	{/if}
</nav>
{/if}

{undef}
