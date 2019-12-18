// !! IMPORTANT !!
// A compléter aussi dans application.yml pour le démarrage Sprin Boot depuis
// la classe conf/Application.groovy car depuis cette classe, le fichier
// application.groovy n'est pas chargé

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.password.algorithm = 'bcrypt'
grails.plugin.springsecurity.userLookup.userDomainClassName = 'facturation.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'facturation.UserRole'
grails.plugin.springsecurity.authority.className = 'facturation.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

