<header role="banner">
	<a id="logo" href="/"><img title="{$logo_alt}" alt="{$logo_alt}" src={'images/logo.png'|ezdesign()} width="{$logo_width|int()}" height="{$logo_height|int()}" /></a>
	<nav id="utility">
	{menubar(hash(
		'orientation', 'horizontal',
		'class', 'utility',
		'include_root_node', false(),
		'identifier_list', 'UtilityIdentifierList',
		'fetch_parameters', hash(
			'AttributeFilter', array(array('priority', 'between', array(100, 110)))
		),
		'append', hash(
			'condition', array('result', $current_user.is_logged_in),
			'conditional', array(
				hash(
					'content', 'User Login',
					'link', '/user/login',
				),
				hash(
					'content', 'Logout',
					'link', '/user/logout',
				)
			)
		)
	))}
	</nav>
	<div id="search">
		{include uri="design:parts/searchform.tpl" placeholder=first_set($placeholder, 'null') label=first_set($label, 'null')}
	</div>
</header>