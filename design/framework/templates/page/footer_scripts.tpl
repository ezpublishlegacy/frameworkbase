{if $has_cufon}<script type="text/javascript">Cufon.now();</script>{/if}
{if first_set($include, false())}{include uri=$include}{/if}
{if $template_look.data_map.footer_script.has_content}
<script type="text/javascript">
{$template_look.data_map.footer_script.content}
</script>
{/if}