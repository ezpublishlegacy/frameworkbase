{if and(is_set($htmlshorten), $htmlshorten)}
	{if is_array($htmlshorten)}
		{$attribute.content.output.output_text|html_shorten($htmlshorten[0], $htmlshorten[1])}
	{elseif is_integer($htmlshorten)}
		{$attribute.content.output.output_text|html_shorten($htmlshorten)}
	{/if}
{else}
{$attribute.content.output.output_text}
{/if}