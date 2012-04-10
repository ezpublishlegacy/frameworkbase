{* Content Box - Custom Tag *}
{def $has_header=and(is_set($header), ne($header,''))
	 $element=cond($has_header, 'section', 'div')
}
<{$element} class="module {first_set($display_type, 'customtag')}{if first_set($class, false())} {$class|implode(' ')}{/if}">
	{if $has_header}<header><h1>{$header}</h1></header>{/if}
	<div class="{first_set($display_type, 'customtag')}-content">{$content}</div>
</{$element}>
{undef}