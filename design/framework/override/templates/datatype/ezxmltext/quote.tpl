{def $aside=or(eq($align, 'left'), eq($align, 'right'))
	 $element=cond($aside, 'aside', 'div')
}
<{$element} class="quote {if $aside}align-{$align}{else}noalign{/if}">
<div class="quote-begin"><span class="hide">&#147;</span></div>
{$content}
{if is_set($author)}<p class="author">{$author}</p>{/if}
<div class="quote-end"><span class="hide">&#148;</span></div>
</{$element}>
{undef $aside $element}