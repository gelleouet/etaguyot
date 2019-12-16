<!doctype html>
<html>
	<head>
	    <meta name="layout" content="page-login"/>
	</head>
	
	<body>
		<div class="form-group">
			<input class="form-control" type="email" placeholder="Email" name="${ usernameParameter }" autocomplete="off" style="background-color:#e2e5ec; color:black">
		</div>
		<div class="form-group">
			<input class="form-control" type="password" placeholder="Mot de passe" name="${ passwordParameter }" autocomplete="off" style="background-color:#e2e5ec; color:black">
		</div>
		<div class="form-group ml-4">
			<label class="kt-checkbox kt-checkbox--solid kt-checkbox--brand" for="remember_me" style="color:white;">
				<input type="checkbox" name="${rememberMeParameter}" id="remember_me" checked='checked'> Mémoriser mes identifiants
				<span></span>
			</label>
		</div>
		<div class="kt-login-v1__actions">
			<a href="#" class="kt-login-v1__forgot" style="color:white; font-weight:bold;">
				Mot de passe oublié ?
			</a>
			<button type="submit" class="btn btn-brand btn-pill btn-elevate">Connexion</button>
		</div>
	
	</body>
</html>
