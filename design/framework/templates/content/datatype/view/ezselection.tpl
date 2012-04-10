{foreach $attribute.content as $option}
{if first_set($options, false())}{$options[$option|int()]}{else}{$attribute.class_content.options[$option|int()].name|wash()}{/if}{delimiter}{first_set($delimiter, ',')}{/delimiter}
{/foreach}