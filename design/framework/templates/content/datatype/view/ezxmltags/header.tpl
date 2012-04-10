{set $classification=cond( and(is_set($align), $align), concat($classification, 'text-align-', $align), $classification)
	 $level=cond(and(is_set($level), gt($level, 0), le($level, 7)), concat('h', cond(lt($level, 7), sum($level, 1), $level)), 'h2')
}
<a id="{cond(is_set($anchor_name), $anchor_name|wash(), concat('eztoc', $toc_anchor_name))}"></a>
<{$level}{if $classification|trim()} class="{$classification|wash}"{/if}>{$content}</{$level}>