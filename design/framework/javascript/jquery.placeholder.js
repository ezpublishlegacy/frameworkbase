$Placeholder=(function($){
	var $lib={
		'clear':function(obj,dv){
			if(obj.val()===dv){
				obj.val('');
			}
		},
		'exists':function(){
			return('placeholder' in document.createElement('input'))
		}
	};
	$.fn.placeholder=function(){
		if($lib.exists()){return this;}
		this.each(function(){
			var obj = $(this),
				dv=obj.attr('placeholder')?obj.attr('placeholder'):obj.val();
			obj.val(dv).bind('focus',function(){
				$lib.clear(obj,dv);
			}).bind('blur',function(){
				if(obj.val()==''){
					obj.val(dv);
				}
			}).parents('form').bind('submit',function(){
				$lib.clear(obj,dv);
			});
			$('body').bind('unload',function(){
				$lib.clear(obj,dv);
			});
		});
	}
	if(!$lib.exists()){
		$(function(){
			$('input[placeholder]').placeholder();
		});
	}
	return{
		'exists':$lib.exists
	};
})(jQuery);