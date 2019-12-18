package facturation

import grails.gorm.transactions.Transactional

class ArticleService extends AppService<Article> {

	List<Article> search(ArticleCommand command, Map pagination) {
		return Article.createCriteria().list(pagination) {
			if (command.code) {
				ilike 'code', QueryUtils.decorateMatchAll(command.code)
			}
			if (command.libelle) {
				ilike 'libelle', QueryUtils.decorateMatchAll(command.libelle)
			}
			if (command.famille) {
				ilike 'famille', QueryUtils.decorateMatchAll(command.famille)
			}

			order 'libelle'
		}
	}


	List<String> groupFamille() {
		Article.createCriteria().list {
			isNotNull "famille"
			projections {
				groupProperty "famille"
			}
			order "famille"
		}
	}


	List<String> groupUnite() {
		Article.createCriteria().list {
			isNotNull "unite"
			projections {
				groupProperty "unite"
			}
			order "unite"
		}
	}


	@Override
	@Transactional(readOnly = false, rollbackFor = AppException)
	Article save(Article article) throws AppException {
		article.code = article.code?.toUpperCase()
		return super.save(article)
	}
}
