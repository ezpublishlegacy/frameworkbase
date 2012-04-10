{if and( is_set($text_only), eq($text_only, true()) )}
{cond($attribute.data_text, $attribute.data_text, $attribute.content)|wash()}
{else}
<a href="{$attribute.content|wash()}">{cond($attribute.data_text, $attribute.data_text, $attribute.content)|wash()}</a>
{/if}