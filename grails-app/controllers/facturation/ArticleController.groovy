package facturation

class ArticleController extends AppController {

	ArticleService articleService


	def index(ArticleCommand command) {
		def articles = articleService.search(command, pagination())
		def familles = articleService.groupFamille()
		render view: 'index', model: [command: command, articles: articles,
			familles: familles]
	}

	def globalSearch(String value) {
		def command
		if (value.isInteger()) {
			command = new ArticleCommand(code: value)
		} else {
			command = new ArticleCommand(libelle: value)
		}

		def articles = articleService.search(command, [max: 1])

		if (articles.totalCount == 1) {
			edit(articles[0])
		} else {
			index(command)
		}
	}

	def edit(Article article) {
		article = getRequestCommand(article ?: new Article())
		def familles = articleService.groupFamille()
		def unites = articleService.groupUnite()
		render view: 'edit', model: [article: article, familles: familles,
			unites: unites]
	}

	@ExceptionHandler
	def save(Article article) {
		checkErrors(this, article)
		articleService.save(article)
		redirect(action: 'index')
	}

	@ExceptionHandler
	def delete(Article article) {
		checkErrors(this, article)
		articleService.delete(article)
		redirect(action: 'index')
	}
}
