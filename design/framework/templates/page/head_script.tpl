{pagedesign_javascript()}
{if and(ezini_hasvariable('GoogleSettings', 'TrackingCode', 'site.ini'), ne(ezini('GoogleSettings', 'TrackingCode', 'site.ini'), ''))}
<script type="text/javascript">
var _gaq=_gaq||[];_gaq.push(["_setAccount", "{ezini('GoogleSettings', 'TrackingCode', 'site.ini')}"]);_gaq.push(["_trackPageview"]);
{literal}(function(){var ga=document.createElement('script');ga.type='text/javascript';ga.async=true;ga.src=('https:'==document.location.protocol?'https://ssl':'http://www')+'.google-analytics.com/ga.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(ga, s);})();{/literal}
</script>
{/if}
<!--[if IE]><script type="text/javascript" src={'javascript/ie/html5.js'|ezdesign()} charset="utf-8"></script><![endif]-->
